import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);

const List<String> _types = [
  'Internship',
  'Full-time',
  'Part-time',
  'Freelance',
  'Volunteer',
];

class _Exp {
  final String role;
  final String company;
  final String type;
  final String startDate; // example: Jun 2025
  final String endDate; // empty when currently working here
  final bool current;
  final String location;
  final String description;

  const _Exp({
    required this.role,
    required this.company,
    required this.type,
    this.startDate = '',
    this.endDate = '',
    this.current = false,
    this.location = '',
    this.description = '',
  });
}

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  // TODO: load these from the real logged-in user later.
  // This first entry is only a sample. Edit or delete it.
  final List<_Exp> _items = [
    const _Exp(
      role: 'Flutter Developer Intern',
      company: 'Your Company Name',
      type: 'Internship',
      startDate: 'Jun 2025',
      endDate: 'Aug 2025',
      location: 'Dehradun',
      description: 'Built app screens and fixed bugs in a mobile app.',
    ),
  ];

  Future<void> _openForm({_Exp? existing, int? index}) async {
    final _Exp? result = await showModalBottomSheet<_Exp>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _ExpForm(existing: existing),
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
                      'Experience',
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
                                return _ExpCard(
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

class _ExpCard extends StatelessWidget {
  const _ExpCard({
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  final _Exp item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final String end = item.current
        ? 'Present'
        : (item.endDate.isEmpty ? '' : item.endDate);
    final String duration = item.startDate.isEmpty && end.isEmpty
        ? ''
        : '${item.startDate.isEmpty ? '?' : item.startDate} - '
              '${end.isEmpty ? '?' : end}';

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
          // Placeholder logo. Replace with Image.asset('assets/company.png')
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: _blue.withOpacity(0.14),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.work_rounded, color: _blue, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.role,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _navy,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.company}  ·  ${item.type}',
                  style: const TextStyle(fontSize: 12.5, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    if (duration.isNotEmpty)
                      _Chip(
                        icon: Icons.calendar_today_outlined,
                        text: duration,
                      ),
                    if (item.location.isNotEmpty)
                      _Chip(
                        icon: Icons.location_on_outlined,
                        text: item.location,
                      ),
                  ],
                ),
                if (item.description.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 12.5,
                      height: 1.3,
                      color: Colors.black54,
                    ),
                  ),
                ],
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
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: _blue,
              ),
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
            Icon(Icons.work_outline, size: 56, color: Colors.black26),
            SizedBox(height: 12),
            Text(
              'No experience added yet',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: _navy,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Tap "Add Experience" to add an internship or job.',
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
            'Add Experience',
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

class _ExpForm extends StatefulWidget {
  const _ExpForm({this.existing});

  final _Exp? existing;

  @override
  State<_ExpForm> createState() => _ExpFormState();
}

class _ExpFormState extends State<_ExpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _role;
  late final TextEditingController _company;
  late final TextEditingController _start;
  late final TextEditingController _end;
  late final TextEditingController _location;
  late final TextEditingController _description;
  late String _type;
  late bool _current;

  @override
  void initState() {
    super.initState();
    final _Exp? e = widget.existing;
    _role = TextEditingController(text: e?.role ?? '');
    _company = TextEditingController(text: e?.company ?? '');
    _start = TextEditingController(text: e?.startDate ?? '');
    _end = TextEditingController(text: e?.endDate ?? '');
    _location = TextEditingController(text: e?.location ?? '');
    _description = TextEditingController(text: e?.description ?? '');
    _type = e?.type ?? _types.first;
    _current = e?.current ?? false;
  }

  @override
  void dispose() {
    _role.dispose();
    _company.dispose();
    _start.dispose();
    _end.dispose();
    _location.dispose();
    _description.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(
      _Exp(
        role: _role.text.trim(),
        company: _company.text.trim(),
        type: _type,
        startDate: _start.text.trim(),
        endDate: _current ? '' : _end.text.trim(),
        current: _current,
        location: _location.text.trim(),
        description: _description.text.trim(),
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
                isEdit ? 'Edit Experience' : 'Add Experience',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: _navy,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _role,
                decoration: _dec(
                  'Role / Title',
                  hint: 'Example: Flutter Developer Intern',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Please enter your role'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _company,
                decoration: _dec('Company / Organisation'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Please enter the company'
                    : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _type,
                isExpanded: true,
                decoration: _dec('Type'),
                items: _types
                    .map(
                      (t) => DropdownMenuItem<String>(value: t, child: Text(t)),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _type = value);
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _start,
                      decoration: _dec('Start', hint: 'Jun 2025'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _end,
                      enabled: !_current,
                      decoration: _dec('End', hint: 'Aug 2025'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Switch(
                    value: _current,
                    activeColor: _blue,
                    onChanged: (value) => setState(() => _current = value),
                  ),
                  const SizedBox(width: 4),
                  const Expanded(
                    child: Text(
                      'I currently work here',
                      style: TextStyle(fontSize: 13.5, color: _navy),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _location,
                decoration: _dec('Location (optional)'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _description,
                minLines: 3,
                maxLines: 5,
                maxLength: 300,
                decoration: _dec(
                  'Description (optional)',
                  hint: 'What did you work on?',
                ),
              ),
              const SizedBox(height: 16),
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
