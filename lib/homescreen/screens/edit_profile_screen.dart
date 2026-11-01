import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TODO: load these from the real logged-in user later.
  final TextEditingController _name = TextEditingController(
    text: 'Pranav Kabdal',
  );
  final TextEditingController _username = TextEditingController(
    text: 'pranavk',
  );
  final TextEditingController _university = TextEditingController(
    text: 'Graphic Era Hill University',
  );
  final TextEditingController _course = TextEditingController(
    text: 'B.Tech Computer Science & Engineering',
  );
  final TextEditingController _location = TextEditingController(
    text: 'Dehradun, Uttarakhand',
  );
  final TextEditingController _bio = TextEditingController();

  String _year = '3rd Year';
  static const List<String> _years = [
    '1st Year',
    '2nd Year',
    '3rd Year',
    '4th Year',
    'Graduated',
  ];

  @override
  void dispose() {
    _name.dispose();
    _username.dispose();
    _university.dispose();
    _course.dispose();
    _location.dispose();
    _bio.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    // TODO: save the changes (backend / Firebase).
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Profile updated')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _navy,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ---------- Navy header ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ---------- Content ----------
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: _bg,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              _buildAvatar(),
                              const SizedBox(height: 24),
                              _buildFormCard(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    _SaveBar(onSave: _save),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Column(
      children: [
        Stack(
          children: [
            // Placeholder avatar. Replace with Image.asset('assets/avatar.png')
            CircleAvatar(
              radius: 50,
              backgroundColor: _blue.withOpacity(0.15),
              child: const Icon(Icons.person, size: 54, color: _blue),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  // TODO: open the photo picker
                },
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: _blue,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Change photo',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _blue,
          ),
        ),
      ],
    );
  }

  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _Field(
            label: 'Full name',
            icon: Icons.person_outline,
            controller: _name,
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'Please enter your name'
                : null,
          ),
          _Field(
            label: 'Username',
            icon: Icons.alternate_email,
            controller: _username,
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'Please enter a username'
                : null,
          ),
          _Field(
            label: 'University',
            icon: Icons.school_outlined,
            controller: _university,
          ),
          _Field(
            label: 'Course / Branch',
            icon: Icons.laptop_mac,
            controller: _course,
          ),
          _buildYearDropdown(),
          _Field(
            label: 'Location',
            icon: Icons.location_on_outlined,
            controller: _location,
          ),
          _Field(
            label: 'About me',
            icon: Icons.edit_note,
            controller: _bio,
            maxLines: 4,
            hint: 'Write a short intro and your career goals',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildYearDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: _year,
        isExpanded: true,
        decoration: _inputDecoration('Year', Icons.calendar_today_outlined),
        items: _years
            .map((y) => DropdownMenuItem<String>(value: y, child: Text(y)))
            .toList(),
        onChanged: (value) {
          if (value != null) setState(() => _year = value);
        },
      ),
    );
  }
}

InputDecoration _inputDecoration(String label, IconData icon, {String? hint}) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    prefixIcon: Icon(icon, color: _blue, size: 20),
    filled: true,
    fillColor: _bg,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _blue, width: 1.5),
    ),
  );
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.icon,
    required this.controller,
    this.validator,
    this.maxLines = 1,
    this.hint,
    this.isLast = false,
  });

  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int maxLines;
  final String? hint;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maxLines,
        decoration: _inputDecoration(label, icon, hint: hint),
      ),
    );
  }
}

class _SaveBar extends StatelessWidget {
  const _SaveBar({required this.onSave});

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        12 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: _blue,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Text(
            'Save Changes',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
