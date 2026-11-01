import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _blue2 = Color(0xFF4A8BF5);
const Color _bg = Color(0xFFF5F8FE);
const Color _fieldBg = Color(0xFFF6F8FC);
const Color _fieldBorder = Color(0xFFDDE5F3);
const Color _hint = Color(0xFF9AA7BF);
const Color _textGrey = Color(0xFF6B7A93);
const Color _green = Color(0xFF1FA971);
const Color _red = Color(0xFFE53935);

const List<String> _dayNames = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

const List<String> _dayShort = [
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun',
];

// Name, first study hour (24h clock), icon.
const List<String> _slotNames = ['Morning', 'Afternoon', 'Evening'];
const List<int> _slotStart = [7, 14, 17];
const List<IconData> _slotIcons = [
  Icons.wb_sunny_outlined,
  Icons.wb_twilight,
  Icons.nights_stay_outlined,
];

const List<Color> _subjectColors = [
  Color(0xFF1E63E9),
  Color(0xFF6C3FE0),
  Color(0xFF1FA971),
  Color(0xFFF59E0B),
  Color(0xFFE5486E),
  Color(0xFF2F8BEA),
];

class _Session {
  final String subject;
  final String time;
  final Color color;

  const _Session(this.subject, this.time, this.color);
}

class _DayPlan {
  final String day;
  final List<_Session> sessions;

  const _DayPlan(this.day, this.sessions);
}

class StudyPlannerScreen extends StatefulWidget {
  const StudyPlannerScreen({super.key});

  @override
  State<StudyPlannerScreen> createState() => _StudyPlannerScreenState();
}

class _StudyPlannerScreenState extends State<StudyPlannerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scroll = ScrollController();
  final TextEditingController _goalCtrl = TextEditingController();
  final TextEditingController _subjectCtrl = TextEditingController();

  final List<String> _subjects = [];
  final Set<int> _days = {0, 1, 2, 3, 4};
  double _hours = 2;
  int _slot = 2;

  bool _tried = false; // true after Create My Plan is pressed once
  bool _showPlan = false;
  List<_DayPlan> _plan = [];
  final Set<String> _done = {};

  @override
  void dispose() {
    _scroll.dispose();
    _goalCtrl.dispose();
    _subjectCtrl.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _hint, fontSize: 14.5),
      prefixIcon: Icon(icon, color: _blue, size: 22),
      filled: true,
      fillColor: _fieldBg,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      errorStyle: const TextStyle(
        color: _red,
        fontSize: 12.5,
        fontWeight: FontWeight.w600,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _fieldBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _blue, width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _red, width: 2),
      ),
    );
  }

  void _addSubject() {
    final String s = _subjectCtrl.text.trim();
    if (s.isEmpty) return;
    if (!_subjects.contains(s)) {
      setState(() {
        _subjects.add(s);
        _showPlan = false;
      });
    }
    _subjectCtrl.clear();
  }

  // Turns 14 into "2:00 PM".
  String _fmt(int hour24) {
    final int h = hour24 % 24;
    final String ampm = h >= 12 ? 'PM' : 'AM';
    int h12 = h % 12;
    if (h12 == 0) h12 = 12;
    return '$h12:00 $ampm';
  }

  // Builds the timetable from the user's choices.
  // TODO: replace this with a real AI call for a smarter plan.
  List<_DayPlan> _buildPlan() {
    final List<_DayPlan> result = [];
    final int perDay = _hours.round();
    final int start = _slotStart[_slot];
    int counter = 0; // keeps subjects rotating evenly across days

    final List<int> sortedDays = _days.toList()..sort();
    for (final int d in sortedDays) {
      final List<_Session> sessions = [];
      for (int i = 0; i < perDay; i++) {
        final int subjectIndex = counter % _subjects.length;
        counter++;
        sessions.add(
          _Session(
            _subjects[subjectIndex],
            '${_fmt(start + i)} - ${_fmt(start + i + 1)}',
            _subjectColors[subjectIndex % _subjectColors.length],
          ),
        );
      }
      result.add(_DayPlan(_dayNames[d], sessions));
    }
    return result;
  }

  void _create() {
    setState(() => _tried = true);
    final bool valid = _formKey.currentState!.validate();
    if (!valid || _subjects.isEmpty || _days.isEmpty) return;

    setState(() {
      _plan = _buildPlan();
      _done.clear();
      _showPlan = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOut,
        );
      }
    });
  }

  int get _totalSessions {
    int total = 0;
    for (final _DayPlan d in _plan) {
      total += d.sessions.length;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final int total = _totalSessions;
    final double progress = total == 0 ? 0 : _done.length / total;

    return Scaffold(
      backgroundColor: _navy,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _Header(),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: _bg,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                  child: ListView(
                    controller: _scroll,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                    children: [
                      const _IntroBanner(),
                      const SizedBox(height: 18),
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: _Card(
                          title: 'Your goal',
                          icon: Icons.flag_outlined,
                          children: [
                            TextFormField(
                              controller: _goalCtrl,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: _decoration(
                                'e.g. Semester exams, Placement prep',
                                Icons.flag_outlined,
                              ),
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? 'Please enter your goal'
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      _Card(
                        title: 'Subjects',
                        icon: Icons.menu_book_outlined,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _subjectCtrl,
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (_) => _addSubject(),
                                  decoration: _decoration(
                                    'Add a subject (e.g. Maths)',
                                    Icons.add_circle_outline,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: _addSubject,
                                borderRadius: BorderRadius.circular(14),
                                child: Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: _blue,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (_subjects.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                for (final String s in _subjects)
                                  Chip(
                                    label: Text(s),
                                    backgroundColor: _blue.withOpacity(0.1),
                                    labelStyle: const TextStyle(
                                      color: _blue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    side: BorderSide.none,
                                    deleteIconColor: _blue,
                                    onDeleted: () => setState(() {
                                      _subjects.remove(s);
                                      _showPlan = false;
                                    }),
                                  ),
                              ],
                            ),
                          ],
                          if (_tried && _subjects.isEmpty)
                            const _ErrorText('Please add at least one subject'),
                        ],
                      ),
                      const SizedBox(height: 14),
                      _Card(
                        title: 'Study days',
                        icon: Icons.calendar_month_outlined,
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (int i = 0; i < _dayShort.length; i++)
                                FilterChip(
                                  label: Text(_dayShort[i]),
                                  selected: _days.contains(i),
                                  showCheckmark: false,
                                  backgroundColor: Colors.white,
                                  selectedColor: _blue,
                                  side: const BorderSide(color: _fieldBorder),
                                  labelStyle: TextStyle(
                                    color: _days.contains(i)
                                        ? Colors.white
                                        : _navy,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.5,
                                  ),
                                  onSelected: (on) => setState(() {
                                    if (on) {
                                      _days.add(i);
                                    } else {
                                      _days.remove(i);
                                    }
                                    _showPlan = false;
                                  }),
                                ),
                            ],
                          ),
                          if (_tried && _days.isEmpty)
                            const _ErrorText('Please pick at least one day'),
                        ],
                      ),
                      const SizedBox(height: 14),
                      _Card(
                        title: 'Study time',
                        icon: Icons.timer_outlined,
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Hours per day',
                                  style: TextStyle(
                                    color: _textGrey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Text(
                                '${_hours.round()} hr',
                                style: const TextStyle(
                                  color: _blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: _hours,
                            min: 1,
                            max: 6,
                            divisions: 5,
                            activeColor: _blue,
                            inactiveColor: _fieldBorder,
                            onChanged: (v) => setState(() {
                              _hours = v;
                              _showPlan = false;
                            }),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Best time to study',
                            style: TextStyle(color: _textGrey, fontSize: 14),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (int i = 0; i < _slotNames.length; i++)
                                ChoiceChip(
                                  avatar: Icon(
                                    _slotIcons[i],
                                    size: 18,
                                    color: _slot == i ? Colors.white : _blue,
                                  ),
                                  label: Text(_slotNames[i]),
                                  selected: _slot == i,
                                  showCheckmark: false,
                                  backgroundColor: Colors.white,
                                  selectedColor: _blue,
                                  side: const BorderSide(color: _fieldBorder),
                                  labelStyle: TextStyle(
                                    color: _slot == i ? Colors.white : _navy,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.5,
                                  ),
                                  onSelected: (_) => setState(() {
                                    _slot = i;
                                    _showPlan = false;
                                  }),
                                ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      _GradientButton(
                        label: 'Create My Plan',
                        icon: Icons.auto_awesome,
                        onTap: _create,
                      ),
                      if (_showPlan) ...[
                        const SizedBox(height: 26),
                        Row(
                          children: [
                            const Expanded(
                              child: _SectionTitle('Your weekly plan'),
                            ),
                            TextButton(
                              onPressed: () => setState(_done.clear),
                              child: const Text(
                                'Reset',
                                style: TextStyle(
                                  color: _blue,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _goalCtrl.text.trim(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: _textGrey,
                            fontSize: 13.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  minHeight: 8,
                                  backgroundColor: _fieldBorder,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        _green,
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${_done.length} / $total done',
                              style: const TextStyle(
                                color: _textGrey,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        for (int d = 0; d < _plan.length; d++) ...[
                          _DayCard(
                            plan: _plan[d],
                            dayIndex: d,
                            done: _done,
                            onToggle: (key) => setState(() {
                              if (_done.contains(key)) {
                                _done.remove(key);
                              } else {
                                _done.add(key);
                              }
                            }),
                          ),
                          const SizedBox(height: 12),
                        ],
                        const _TipsCard(),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 16, 18),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const SizedBox(width: 4),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Study Planner',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'A personalized study schedule',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 12.5),
                ),
              ],
            ),
          ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.calendar_month_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class _IntroBanner extends StatelessWidget {
  const _IntroBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_blue, _blue2],
        ),
        boxShadow: [
          BoxShadow(
            color: _blue.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Study smarter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Pick your subjects and days. We will build a weekly timetable.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.event_note_outlined,
              color: Colors.white,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: _navy,
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _ErrorText extends StatelessWidget {
  final String text;

  const _ErrorText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 4),
      child: Text(
        text,
        style: const TextStyle(
          color: _red,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _Card({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: _navy.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: _blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: _blue, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _navy,
                    fontSize: 16.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
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
                Icon(icon, color: Colors.white, size: 22),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DayCard extends StatelessWidget {
  final _DayPlan plan;
  final int dayIndex;
  final Set<String> done;
  final void Function(String key) onToggle;

  const _DayCard({
    required this.plan,
    required this.dayIndex,
    required this.done,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _navy.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  plan.day,
                  style: const TextStyle(
                    color: _navy,
                    fontSize: 16.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${plan.sessions.length} hr',
                  style: const TextStyle(
                    color: _blue,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          for (int i = 0; i < plan.sessions.length; i++)
            _SessionRow(
              session: plan.sessions[i],
              checked: done.contains('$dayIndex-$i'),
              onTap: () => onToggle('$dayIndex-$i'),
            ),
        ],
      ),
    );
  }
}

class _SessionRow extends StatelessWidget {
  final _Session session;
  final bool checked;
  final VoidCallback onTap;

  const _SessionRow({
    required this.session,
    required this.checked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 38,
              decoration: BoxDecoration(
                color: session.color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.subject,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: checked ? _textGrey : _navy,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      decoration: checked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    session.time,
                    style: const TextStyle(color: _textGrey, fontSize: 12.5),
                  ),
                ],
              ),
            ),
            Icon(
              checked ? Icons.check_circle : Icons.radio_button_unchecked,
              color: checked ? _green : _fieldBorder,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}

class _TipsCard extends StatelessWidget {
  const _TipsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _blue.withOpacity(0.07),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tips_and_updates_outlined, color: _blue, size: 22),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Study tips',
                  style: TextStyle(
                    color: _navy,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          _TipLine('Take a 10 minute break after each hour.'),
          _TipLine('Study the hardest subject when you feel fresh.'),
          _TipLine('Keep your phone away while studying.'),
          _TipLine('Revise on the weekend what you learned this week.'),
        ],
      ),
    );
  }
}

class _TipLine extends StatelessWidget {
  final String text;

  const _TipLine(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(Icons.check_circle, color: _green, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _textGrey,
                fontSize: 13.5,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
