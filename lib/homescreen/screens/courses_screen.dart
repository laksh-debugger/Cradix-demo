import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);
const Color _purple = Color(0xFF7E3FE4);
const Color _green = Color(0xFF2FB36B);

class _Course {
  final String title;
  final String platform;
  final bool completed;
  final double progress; // 0 to 100
  final String completedOn; // example: Aug 2025

  const _Course({
    required this.title,
    this.platform = '',
    this.completed = false,
    this.progress = 0,
    this.completedOn = '',
  });
}

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  // TODO: load these from the real logged-in user later.
  // These two are only samples. Edit or delete them.
  final List<_Course> _items = [
    const _Course(
      title: 'Flutter App Development',
      platform: 'Online course',
      progress: 40,
    ),
    const _Course(
      title: 'Data Structures and Algorithms',
      platform: 'College',
      completed: true,
      progress: 100,
      completedOn: 'Dec 2025',
    ),
  ];

  int _filter = 0; // 0 = All, 1 = In Progress, 2 = Completed

  int get _inProgressCount => _items.where((c) => !c.completed).length;
  int get _completedCount => _items.where((c) => c.completed).length;

  // Indexes of the courses that match the selected filter.
  List<int> get _visibleIndexes {
    final List<int> result = [];
    for (int i = 0; i < _items.length; i++) {
      final bool done = _items[i].completed;
      if (_filter == 0 || (_filter == 1 && !done) || (_filter == 2 && done)) {
        result.add(i);
      }
    }
    return result;
  }

  Future<void> _openForm({_Course? existing, int? index}) async {
    final _Course? result = await showModalBottomSheet<_Course>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _CourseForm(existing: existing),
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

  void _markCompleted(int index) {
    final _Course c = _items[index];
    setState(() {
      _items[index] = _Course(
        title: c.title,
        platform: c.platform,
        completed: true,
        progress: 100,
        completedOn: c.completedOn,
      );
    });
    // TODO: save the changes (backend / Firebase).
  }

  void _delete(int index) {
    setState(() => _items.removeAt(index));
    // TODO: save the changes (backend / Firebase).
  }

  @override
  Widget build(BuildContext context) {
    final List<int> visible = _visibleIndexes;

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
                      'Courses',
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _SummaryBox(
                                  value: '$_inProgressCount',
                                  label: 'In Progress',
                                  icon: Icons.play_circle_outline,
                                  color: _blue,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _SummaryBox(
                                  value: '$_completedCount',
                                  label: 'Completed',
                                  icon: Icons.check_circle_outline,
                                  color: _green,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _filterChip('All', 0),
                              _filterChip('In Progress', 1),
                              _filterChip('Completed', 2),
                            ],
                          ),
                          const SizedBox(height: 14),
                        ],
                      ),
                    ),
                    Expanded(
                      child: visible.isEmpty
                          ? const _EmptyState()
                          : ListView.builder(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              itemCount: visible.length,
                              itemBuilder: (context, position) {
                                final int index = visible[position];
                                return _CourseCard(
                                  course: _items[index],
                                  onEdit: () => _openForm(
                                    existing: _items[index],
                                    index: index,
                                  ),
                                  onComplete: () => _markCompleted(index),
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

  Widget _filterChip(String label, int value) {
    final bool selected = _filter == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      showCheckmark: false,
      onSelected: (_) => setState(() => _filter = value),
      selectedColor: _blue,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: selected ? Colors.white : _navy,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
      side: BorderSide(color: selected ? _blue : Colors.black12),
    );
  }
}

class _SummaryBox extends StatelessWidget {
  const _SummaryBox({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withOpacity(0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: _navy,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({
    required this.course,
    required this.onEdit,
    required this.onComplete,
    required this.onDelete,
  });

  final _Course course;
  final VoidCallback onEdit;
  final VoidCallback onComplete;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
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
          // Placeholder logo. Replace with Image.asset('assets/course.png')
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: _purple.withOpacity(0.14),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: _purple,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _navy,
                  ),
                ),
                if (course.platform.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    course.platform,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Colors.black54,
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                if (course.completed)
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      const _StatusChip(
                        icon: Icons.check_circle,
                        text: 'Completed',
                        color: _green,
                      ),
                      if (course.completedOn.isNotEmpty)
                        _StatusChip(
                          icon: Icons.calendar_today_outlined,
                          text: course.completedOn,
                          color: _blue,
                        ),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'In progress',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _blue,
                              ),
                            ),
                          ),
                          Text(
                            '${course.progress.round()}%',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _navy,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: course.progress / 100,
                          minHeight: 7,
                          backgroundColor: const Color(0xFFE3EEFF),
                          valueColor: const AlwaysStoppedAnimation(_blue),
                        ),
                      ),
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
              } else if (value == 'complete') {
                onComplete();
              } else {
                onDelete();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(value: 'edit', child: Text('Edit')),
              if (!course.completed)
                const PopupMenuItem<String>(
                  value: 'complete',
                  child: Text('Mark as completed'),
                ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: color,
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
            Icon(Icons.menu_book_outlined, size: 56, color: Colors.black26),
            SizedBox(height: 12),
            Text(
              'No courses here yet',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: _navy,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Tap "Add Course" to add a course you are taking or finished.',
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
            'Add Course',
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

class _CourseForm extends StatefulWidget {
  const _CourseForm({this.existing});

  final _Course? existing;

  @override
  State<_CourseForm> createState() => _CourseFormState();
}

class _CourseFormState extends State<_CourseForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _platform;
  late final TextEditingController _completedOn;
  late bool _completed;
  late double _progress;

  @override
  void initState() {
    super.initState();
    final _Course? c = widget.existing;
    _title = TextEditingController(text: c?.title ?? '');
    _platform = TextEditingController(text: c?.platform ?? '');
    _completedOn = TextEditingController(text: c?.completedOn ?? '');
    _completed = c?.completed ?? false;
    _progress = (c?.progress ?? 0).clamp(0, 100).toDouble();
  }

  @override
  void dispose() {
    _title.dispose();
    _platform.dispose();
    _completedOn.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(
      _Course(
        title: _title.text.trim(),
        platform: _platform.text.trim(),
        completed: _completed,
        progress: _completed ? 100 : _progress,
        completedOn: _completed ? _completedOn.text.trim() : '',
      ),
    );
  }

  InputDecoration _dec(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
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

  Widget _statusChip(String label, bool value) {
    final bool selected = _completed == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      showCheckmark: false,
      onSelected: (_) => setState(() => _completed = value),
      selectedColor: _blue,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: selected ? Colors.white : _navy,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
      side: BorderSide(color: selected ? _blue : Colors.black12),
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
                isEdit ? 'Edit Course' : 'Add Course',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: _navy,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _title,
                decoration: _dec('Course name'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Please enter the course name'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _platform,
                decoration: _dec(
                  'Platform / Provider (optional)',
                  hint: 'Example: Coursera, Udemy, College',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Status',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _navy,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _statusChip('In Progress', false),
                  _statusChip('Completed', true),
                ],
              ),
              const SizedBox(height: 12),
              if (_completed)
                TextFormField(
                  controller: _completedOn,
                  decoration: _dec(
                    'Completed on (optional)',
                    hint: 'Example: Aug 2025',
                  ),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Progress',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: _navy,
                            ),
                          ),
                        ),
                        Text(
                          '${_progress.round()}%',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: _blue,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _progress,
                      min: 0,
                      max: 100,
                      divisions: 20,
                      activeColor: _blue,
                      label: '${_progress.round()}%',
                      onChanged: (value) => setState(() => _progress = value),
                    ),
                  ],
                ),
              const SizedBox(height: 12),
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
                    isEdit ? 'Save Changes' : 'Add Course',
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
