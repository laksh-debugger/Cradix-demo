import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);

class _Edu {
  final String institution;
  final String degree;
  final String field;
  final String startYear;
  final String endYear;
  final String grade;

  const _Edu({
    required this.institution,
    required this.degree,
    this.field = '',
    this.startYear = '',
    this.endYear = '',
    this.grade = '',
  });
}

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  // TODO: load these from the real logged-in user later.
  final List<_Edu> _items = [
    const _Edu(
      institution: 'Graphic Era Hill University',
      degree: 'B.Tech',
      field: 'Computer Science & Engineering',
      startYear: '2024',
      endYear: '2028',
      grade: 'CGPA 8.82',
    ),
  ];

  Future<void> _openForm({_Edu? existing, int? index}) async {
    final _Edu? result = await showModalBottomSheet<_Edu>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _EduForm(existing: existing),
    );
    if (result == null || !mounted) return;
    setState(() {
      if (index == null) {
        _items.add(result);
      } else {
        _items[index] = result;
      }
    });
    // TODO: save the changes (backend / Firebase).
  }

  void _delete(int index) {
    setState(() => _items.removeAt(index));
    // TODO: save the changes (backend / Firebase).
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
                      'Education',
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
                      child: _items.isEmpty
                          ? const _EmptyState()
                          : ListView.builder(
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                20,
                                16,
                                16,
                              ),
                              itemCount: _items.length,
                              itemBuilder: (context, index) {
                                return _EduCard(
                                  item: _items[index],
                                  onEdit: () => _openForm(
                                    existing: _items[index],
                                    index: index,
                                  ),
                                  onDelete: () => _delete(index),
                                );
                              },
                            ),
                    ),
                    _AddBar(onAdd: () => _openForm()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EduCard extends StatelessWidget {
  const _EduCard({
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  final _Edu item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final String degreeLine = item.field.isEmpty
        ? item.degree
        : '${item.degree}  ·  ${item.field}';
    final String years = item.startYear.isEmpty && item.endYear.isEmpty
        ? ''
        : '${item.startYear.isEmpty ? '?' : item.startYear} - '
              '${item.endYear.isEmpty ? 'Present' : item.endYear}';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder logo. Replace with Image.asset('assets/college.png')
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFF14A38B).withOpacity(0.14),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.school_rounded,
              color: Color(0xFF14A38B),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.institution,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _navy,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  degreeLine,
                  style: const TextStyle(fontSize: 12.5, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    if (years.isNotEmpty)
                      _Chip(icon: Icons.calendar_today_outlined, text: years),
                    if (item.grade.isNotEmpty)
                      _Chip(icon: Icons.grade_outlined, text: item.grade),
                  ],
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black45),
            onSelected: (value) {
              if (value == 'edit') {
                onEdit();
              } else {
                onDelete();
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem<String>(value: 'edit', child: Text('Edit')),
              PopupMenuItem<String>(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: _blue),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: _blue,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.school_outlined, size: 56, color: Colors.black26),
            SizedBox(height: 12),
            Text(
              'No education added yet',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: _navy,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Tap "Add Education" to add your college or school.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.5, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddBar extends StatelessWidget {
  const _AddBar({required this.onAdd});

  final VoidCallback onAdd;

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
        child: ElevatedButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add, size: 20),
          label: const Text(
            'Add Education',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: _blue,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- Add / Edit form (bottom sheet) ----------------

class _EduForm extends StatefulWidget {
  const _EduForm({this.existing});

  final _Edu? existing;

  @override
  State<_EduForm> createState() => _EduFormState();
}

class _EduFormState extends State<_EduForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _institution;
  late final TextEditingController _degree;
  late final TextEditingController _field;
  late final TextEditingController _start;
  late final TextEditingController _end;
  late final TextEditingController _grade;

  @override
  void initState() {
    super.initState();
    final _Edu? e = widget.existing;
    _institution = TextEditingController(text: e?.institution ?? '');
    _degree = TextEditingController(text: e?.degree ?? '');
    _field = TextEditingController(text: e?.field ?? '');
    _start = TextEditingController(text: e?.startYear ?? '');
    _end = TextEditingController(text: e?.endYear ?? '');
    _grade = TextEditingController(text: e?.grade ?? '');
  }

  @override
  void dispose() {
    _institution.dispose();
    _degree.dispose();
    _field.dispose();
    _start.dispose();
    _end.dispose();
    _grade.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(
      _Edu(
        institution: _institution.text.trim(),
        degree: _degree.text.trim(),
        field: _field.text.trim(),
        startYear: _start.text.trim(),
        endYear: _end.text.trim(),
        grade: _grade.text.trim(),
      ),
    );
  }

  InputDecoration _dec(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      counterText: '',
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

  @override
  Widget build(BuildContext context) {
    final bool isEdit = widget.existing != null;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isEdit ? 'Edit Education' : 'Add Education',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: _navy,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _institution,
                decoration: _dec('College / School'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Please enter the college or school'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _degree,
                decoration: _dec('Degree', hint: 'Example: B.Tech, 12th, 10th'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Please enter the degree'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _field,
                decoration: _dec('Branch / Stream (optional)'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _start,
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      decoration: _dec('Start year'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _end,
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      decoration: _dec('End year'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _grade,
                decoration: _dec('Grade (optional)', hint: 'Example: CGPA 8.5'),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _blue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    isEdit ? 'Save Changes' : 'Add',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
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
