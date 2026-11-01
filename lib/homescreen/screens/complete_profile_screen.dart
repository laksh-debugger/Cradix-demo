import 'package:Cradix/homescreen/homepage.dart';
import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _navy2 = Color(0xFF14408F);
const Color _blue = Color(0xFF1E63E9);
const Color _blue2 = Color(0xFF4A8BF5);
const Color _fieldBg = Color(0xFFF6F8FC);
const Color _fieldBorder = Color(0xFFDDE5F3);
const Color _hint = Color(0xFF9AA7BF);
const Color _textGrey = Color(0xFF6B7A93);
const Color _red = Color(0xFFE53935);

const List<String> _courses = [
  'B.Tech',
  'B.E.',
  'BCA',
  'B.Sc',
  'B.Com',
  'BBA',
  'MBA',
  'M.Tech',
  'MCA',
  'Other',
];

const List<String> _branches = [
  'Computer Science (CSE)',
  'Information Technology',
  'Electronics (ECE)',
  'Electrical (EEE)',
  'Mechanical',
  'Civil',
  'AI & Machine Learning',
  'Data Science',
  'Other',
];

const List<String> _years = [
  '1st Year',
  '2nd Year',
  '3rd Year',
  '4th Year',
  '5th Year',
  'Graduated',
];

const List<String> _gradYears = [
  '2026',
  '2027',
  '2028',
  '2029',
  '2030',
  '2031',
];

const List<String> _skillOptions = [
  'Flutter',
  'Dart',
  'Java',
  'Python',
  'C++',
  'JavaScript',
  'React',
  'SQL',
  'Firebase',
  'UI/UX Design',
  'Machine Learning',
  'Data Analysis',
  'Cloud',
  'Cyber Security',
  'Marketing',
  'Public Speaking',
];

// Number of required parts (4 dropdowns + skills). Used by the progress bar.
const int _requiredCount = 5;

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _linkedinCtrl = TextEditingController();
  final TextEditingController _githubCtrl = TextEditingController();

  String? _course;
  String? _branch;
  String? _year;
  String? _gradYear;
  final List<String> _skills = [];

  bool _tried = false; // true after Save & Continue is pressed once

  @override
  void dispose() {
    _linkedinCtrl.dispose();
    _githubCtrl.dispose();
    super.dispose();
  }

  int get _filled {
    int n = 0;
    if (_course != null) n++;
    if (_branch != null) n++;
    if (_year != null) n++;
    if (_gradYear != null) n++;
    if (_skills.isNotEmpty) n++;
    return n;
  }

  InputDecoration _decoration(IconData icon, {String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _hint, fontSize: 15),
      prefixIcon: Icon(icon, color: _blue, size: 24),
      filled: true,
      fillColor: _fieldBg,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      errorStyle: const TextStyle(
        color: _red,
        fontSize: 12.5,
        fontWeight: FontWeight.w600,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _fieldBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _blue, width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _red, width: 2),
      ),
    );
  }

  Widget _dropdown({
    required String hint,
    required IconData icon,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required String error,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down, color: _blue),
      hint: Text(hint, style: const TextStyle(color: _hint, fontSize: 15)),
      decoration: _decoration(icon),
      items: [
        for (final String s in items)
          DropdownMenuItem<String>(
            value: s,
            child: Text(s, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
      ],
      onChanged: onChanged,
      validator: (v) => v == null ? error : null,
    );
  }

  void _openSkillPicker() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext sheetContext) {
        return StatefulBuilder(
          builder: (BuildContext ctx, StateSetter setSheet) {
            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(ctx).size.height * 0.75,
              ),
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 44,
                        height: 5,
                        decoration: BoxDecoration(
                          color: _fieldBorder,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Pick your skills & interests',
                      style: TextStyle(
                        color: _navy,
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_skills.length} selected',
                      style: const TextStyle(color: _textGrey, fontSize: 13),
                    ),
                    const SizedBox(height: 14),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final String s in _skillOptions)
                              FilterChip(
                                label: Text(s),
                                selected: _skills.contains(s),
                                showCheckmark: false,
                                backgroundColor: Colors.white,
                                selectedColor: _blue,
                                side: const BorderSide(color: _fieldBorder),
                                labelStyle: TextStyle(
                                  color: _skills.contains(s)
                                      ? Colors.white
                                      : _navy,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.5,
                                ),
                                onSelected: (on) {
                                  // Update the sheet and the page behind it.
                                  setSheet(() {});
                                  setState(() {
                                    if (on) {
                                      _skills.add(s);
                                    } else {
                                      _skills.remove(s);
                                    }
                                  });
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _GradientButton(
                      label: 'Done',
                      icon: Icons.check,
                      onTap: () => Navigator.of(sheetContext).pop(),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _save() {
    setState(() => _tried = true);
    final bool valid = _formKey.currentState!.validate();
    if (!valid || _skills.isEmpty) return;

    // TODO: save the profile details to your backend / Firebase.

    // pushReplacement = the user cannot press Back to return to this page.
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenH = MediaQuery.of(context).size.height;
    final bool skillsError = _tried && _skills.isEmpty;

    return Scaffold(
      backgroundColor: _navy,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(filled: _filled),
              Container(
                width: double.infinity,
                constraints: BoxConstraints(minHeight: screenH * 0.65),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(22, 26, 22, 0),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const _SectionLabel(
                                icon: Icons.school_outlined,
                                text: 'Education',
                              ),
                              const SizedBox(height: 12),
                              _dropdown(
                                hint: 'Course / Degree',
                                icon: Icons.school_outlined,
                                value: _course,
                                items: _courses,
                                onChanged: (v) => setState(() => _course = v),
                                error: 'Please select your course',
                              ),
                              const SizedBox(height: 14),
                              _dropdown(
                                hint: 'Branch / Specialization',
                                icon: Icons.account_balance_outlined,
                                value: _branch,
                                items: _branches,
                                onChanged: (v) => setState(() => _branch = v),
                                error: 'Please select your branch',
                              ),
                              const SizedBox(height: 14),
                              _dropdown(
                                hint: 'Current Year',
                                icon: Icons.calendar_month_outlined,
                                value: _year,
                                items: _years,
                                onChanged: (v) => setState(() => _year = v),
                                error: 'Please select your current year',
                              ),
                              const SizedBox(height: 14),
                              _dropdown(
                                hint: 'Expected Graduation Year',
                                icon: Icons.event_available_outlined,
                                value: _gradYear,
                                items: _gradYears,
                                onChanged: (v) => setState(() => _gradYear = v),
                                error: 'Please select your graduation year',
                              ),
                              const SizedBox(height: 24),
                              const _SectionLabel(
                                icon: Icons.auto_awesome,
                                text: 'Skills & Interests',
                              ),
                              const SizedBox(height: 12),
                              InkWell(
                                onTap: _openSkillPicker,
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  height: 58,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _fieldBg,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: skillsError ? _red : _fieldBorder,
                                      width: skillsError ? 2 : 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.auto_awesome,
                                        color: _blue,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          _skills.isEmpty
                                              ? 'Tap to add your skills'
                                              : '${_skills.length} selected',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: _skills.isEmpty
                                                ? _hint
                                                : _navy,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: _blue.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: _blue,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (skillsError)
                                const Padding(
                                  padding: EdgeInsets.only(top: 8, left: 4),
                                  child: Text(
                                    'Please add at least one skill',
                                    style: TextStyle(
                                      color: _red,
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              if (_skills.isNotEmpty) ...[
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 4,
                                  children: [
                                    for (final String s in _skills)
                                      Chip(
                                        label: Text(s),
                                        backgroundColor: _blue.withOpacity(0.1),
                                        labelStyle: const TextStyle(
                                          color: _blue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        side: BorderSide.none,
                                        deleteIconColor: _blue,
                                        onDeleted: () =>
                                            setState(() => _skills.remove(s)),
                                      ),
                                  ],
                                ),
                              ],
                              const SizedBox(height: 24),
                              const _SectionLabel(
                                icon: Icons.link,
                                text: 'Profile links (Optional)',
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: _linkedinCtrl,
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.next,
                                // Replace this icon with the LinkedIn logo:
                                // Image.asset('assets/images/linkedin.png')
                                decoration: _decoration(
                                  Icons.work_outline,
                                  hint: 'LinkedIn Profile (Optional)',
                                ),
                              ),
                              const SizedBox(height: 14),
                              TextFormField(
                                controller: _githubCtrl,
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                // Replace this icon with the GitHub logo:
                                // Image.asset('assets/images/github.png')
                                decoration: _decoration(
                                  Icons.code,
                                  hint: 'GitHub Profile (Optional)',
                                ),
                              ),
                              const SizedBox(height: 28),
                              _GradientButton(
                                label: 'Save & Continue',
                                icon: Icons.arrow_forward,
                                onTap: _save,
                              ),
                              const SizedBox(height: 18),
                              const _NoteRow(),
                              const SizedBox(height: 14),
                            ],
                          ),
                        ),
                      ),
                      const _CampusIllustration(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Navy gradient top part with decorative circles and a progress bar.
class _Header extends StatelessWidget {
  final int filled;

  const _Header({required this.filled});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_navy, _navy2],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -40,
              top: -30,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06),
                ),
              ),
            ),
            Positioned(
              right: 50,
              bottom: -50,
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _blue2.withOpacity(0.18),
                ),
              ),
            ),
            Positioned(
              left: -30,
              bottom: 10,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _LogoRow(),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'STEP 2 OF 2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Complete Your Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'A few more details to personalize your CRADIX experience.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14.5,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: filled / _requiredCount,
                            minHeight: 8,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF8FC0FF),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '$filled / $_requiredCount done',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoRow extends StatelessWidget {
  const _LogoRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Replace this circle with your logo:
        // Image.asset('assets/images/logo.png', width: 44, height: 44)
        Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.school, color: _navy, size: 26),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CRADIX',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  'Learn  ·  Build  ·  Grow',
                  style: TextStyle(
                    color: Color(0xFFBFD3F7),
                    fontSize: 12.5,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final IconData icon;
  final String text;

  const _SectionLabel({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: _blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(icon, color: _blue, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _navy,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _GradientButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _GradientButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [_blue, _blue2],
        ),
        boxShadow: [
          BoxShadow(
            color: _blue.withOpacity(0.35),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onTap,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(icon, color: Colors.white, size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NoteRow extends StatelessWidget {
  const _NoteRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: _fieldBorder, thickness: 1)),
        Flexible(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'You can update these details anytime.',
              textAlign: TextAlign.center,
              style: TextStyle(color: _textGrey, fontSize: 12.5),
            ),
          ),
        ),
        Expanded(child: Divider(color: _fieldBorder, thickness: 1)),
      ],
    );
  }
}

// Soft blue campus picture at the bottom.
// Replace the whole Stack with your picture:
// Image.asset('assets/images/campus.png', width: double.infinity, fit: BoxFit.cover)
class _CampusIllustration extends StatelessWidget {
  const _CampusIllustration();

  @override
  Widget build(BuildContext context) {
    const Color soft = Color(0xFFB9CCEC);
    const Color mid = Color(0xFF7FA0DA);
    return Container(
      height: 130,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xFFE6EEFB)],
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: const [
          Positioned(
            left: -6,
            bottom: 0,
            child: Icon(Icons.park, color: mid, size: 84),
          ),
          Positioned(
            left: 52,
            bottom: 0,
            child: Icon(Icons.park, color: soft, size: 52),
          ),
          Positioned(
            right: -6,
            bottom: 0,
            child: Icon(Icons.park, color: mid, size: 90),
          ),
          Positioned(
            right: 56,
            bottom: 0,
            child: Icon(Icons.park, color: soft, size: 50),
          ),
          Positioned(
            bottom: 0,
            child: Icon(Icons.account_balance, color: soft, size: 96),
          ),
        ],
      ),
    );
  }
}
