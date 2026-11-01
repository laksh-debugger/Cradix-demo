import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _blue2 = Color(0xFF4A8BF5);
const Color _bg = Color(0xFFF5F8FE);
const Color _fieldBg = Color(0xFFF6F8FC);
const Color _fieldBorder = Color(0xFFDDE5F3);
const Color _hint = Color(0xFF9AA7BF);
const Color _textGrey = Color(0xFF6B7A93);
const Color _red = Color(0xFFE53935);

class _Template {
  final String name;
  final Color color;

  const _Template(this.name, this.color);
}

const List<_Template> _templates = [
  _Template('Classic', Color(0xFF0B2E73)),
  _Template('Modern', Color(0xFF1E63E9)),
  _Template('Fresh', Color(0xFF1FA971)),
  _Template('Bold', Color(0xFF6C3FE0)),
];

class CvGeneratorScreen extends StatefulWidget {
  const CvGeneratorScreen({super.key});

  @override
  State<CvGeneratorScreen> createState() => _CvGeneratorScreenState();
}

class _CvGeneratorScreenState extends State<CvGeneratorScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scroll = ScrollController();

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _cityCtrl = TextEditingController();
  final TextEditingController _summaryCtrl = TextEditingController();
  final TextEditingController _collegeCtrl = TextEditingController();
  final TextEditingController _courseCtrl = TextEditingController();
  final TextEditingController _eduYearCtrl = TextEditingController();
  final TextEditingController _cgpaCtrl = TextEditingController();
  final TextEditingController _skillCtrl = TextEditingController();
  final TextEditingController _projTitleCtrl = TextEditingController();
  final TextEditingController _projDescCtrl = TextEditingController();

  final List<String> _skills = [];
  int _template = 1;
  bool _tried = false; // true after Generate CV is pressed once
  bool _showCv = false;

  @override
  void dispose() {
    _scroll.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _cityCtrl.dispose();
    _summaryCtrl.dispose();
    _collegeCtrl.dispose();
    _courseCtrl.dispose();
    _eduYearCtrl.dispose();
    _cgpaCtrl.dispose();
    _skillCtrl.dispose();
    _projTitleCtrl.dispose();
    _projDescCtrl.dispose();
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

  String? _required(String? v, String message) {
    if (v == null || v.trim().isEmpty) return message;
    return null;
  }

  void _addSkill() {
    final String s = _skillCtrl.text.trim();
    if (s.isEmpty) return;
    if (_skills.contains(s)) {
      _skillCtrl.clear();
      return;
    }
    setState(() {
      _skills.add(s);
      _showCv = false;
    });
    _skillCtrl.clear();
  }

  void _generate() {
    setState(() => _tried = true);
    final bool valid = _formKey.currentState!.validate();
    if (!valid || _skills.isEmpty) return;

    // TODO: send the details to your AI / backend to polish the text.
    setState(() => _showCv = true);

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

  @override
  Widget build(BuildContext context) {
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
                      const _SectionTitle('Choose a template'),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          for (int i = 0; i < _templates.length; i++)
                            _TemplateChip(
                              template: _templates[i],
                              selected: _template == i,
                              onTap: () => setState(() => _template = i),
                            ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            _SectionCard(
                              title: 'Personal details',
                              icon: Icons.person_outline,
                              children: [
                                TextFormField(
                                  controller: _nameCtrl,
                                  textCapitalization: TextCapitalization.words,
                                  textInputAction: TextInputAction.next,
                                  decoration: _decoration(
                                    'Full Name',
                                    Icons.person_outline,
                                  ),
                                  validator: (v) =>
                                      _required(v, 'Please enter your name'),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _emailCtrl,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: _decoration(
                                    'Email Address',
                                    Icons.mail_outline,
                                  ),
                                  validator: (v) {
                                    final String t = (v ?? '').trim();
                                    if (t.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!t.contains('@') || !t.contains('.')) {
                                      return 'Enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _phoneCtrl,
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  decoration: _decoration(
                                    'Phone Number',
                                    Icons.phone_outlined,
                                  ),
                                  validator: (v) => _required(
                                    v,
                                    'Please enter your phone number',
                                  ),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _cityCtrl,
                                  textInputAction: TextInputAction.next,
                                  decoration: _decoration(
                                    'City (Optional)',
                                    Icons.location_on_outlined,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _summaryCtrl,
                                  maxLines: 3,
                                  textInputAction: TextInputAction.newline,
                                  decoration: _decoration(
                                    'Short summary about you (Optional)',
                                    Icons.notes_outlined,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            _SectionCard(
                              title: 'Education',
                              icon: Icons.school_outlined,
                              children: [
                                TextFormField(
                                  controller: _collegeCtrl,
                                  textInputAction: TextInputAction.next,
                                  decoration: _decoration(
                                    'College Name',
                                    Icons.school_outlined,
                                  ),
                                  validator: (v) =>
                                      _required(v, 'Please enter your college'),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _courseCtrl,
                                  textInputAction: TextInputAction.next,
                                  decoration: _decoration(
                                    'Course (e.g. B.Tech CSE)',
                                    Icons.menu_book_outlined,
                                  ),
                                  validator: (v) =>
                                      _required(v, 'Please enter your course'),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _eduYearCtrl,
                                  textInputAction: TextInputAction.next,
                                  decoration: _decoration(
                                    'Years (e.g. 2022 - 2026)',
                                    Icons.calendar_month_outlined,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _cgpaCtrl,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  decoration: _decoration(
                                    'CGPA (Optional)',
                                    Icons.grade_outlined,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            _SectionCard(
                              title: 'Skills',
                              icon: Icons.bolt_outlined,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _skillCtrl,
                                        textInputAction: TextInputAction.done,
                                        onSubmitted: (_) => _addSkill(),
                                        decoration: _decoration(
                                          'Add a skill (e.g. Flutter)',
                                          Icons.add_circle_outline,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: _addSkill,
                                      borderRadius: BorderRadius.circular(14),
                                      child: Container(
                                        width: 52,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          color: _blue,
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
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
                                          backgroundColor: _blue.withOpacity(
                                            0.1,
                                          ),
                                          labelStyle: const TextStyle(
                                            color: _blue,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          side: BorderSide.none,
                                          deleteIconColor: _blue,
                                          onDeleted: () => setState(() {
                                            _skills.remove(s);
                                            _showCv = false;
                                          }),
                                        ),
                                    ],
                                  ),
                                ],
                                if (_tried && _skills.isEmpty)
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
                              ],
                            ),
                            const SizedBox(height: 14),
                            _SectionCard(
                              title: 'Project (Optional)',
                              icon: Icons.folder_outlined,
                              children: [
                                TextFormField(
                                  controller: _projTitleCtrl,
                                  textInputAction: TextInputAction.next,
                                  decoration: _decoration(
                                    'Project title',
                                    Icons.rocket_launch_outlined,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _projDescCtrl,
                                  maxLines: 3,
                                  decoration: _decoration(
                                    'What did you build?',
                                    Icons.description_outlined,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                      _GradientButton(
                        label: 'Generate CV',
                        icon: Icons.auto_awesome,
                        onTap: _generate,
                      ),
                      if (_showCv) ...[
                        const SizedBox(height: 26),
                        const _SectionTitle('Your CV'),
                        const SizedBox(height: 12),
                        _CvPreview(
                          accent: _templates[_template].color,
                          name: _nameCtrl.text.trim(),
                          email: _emailCtrl.text.trim(),
                          phone: _phoneCtrl.text.trim(),
                          city: _cityCtrl.text.trim(),
                          summary: _summaryCtrl.text.trim(),
                          college: _collegeCtrl.text.trim(),
                          course: _courseCtrl.text.trim(),
                          eduYear: _eduYearCtrl.text.trim(),
                          cgpa: _cgpaCtrl.text.trim(),
                          skills: _skills,
                          projectTitle: _projTitleCtrl.text.trim(),
                          projectDesc: _projDescCtrl.text.trim(),
                        ),
                        const SizedBox(height: 16),
                        _OutlineButton(
                          label: 'Download PDF',
                          icon: Icons.download_outlined,
                          onTap: () {
                            // TODO: save the CV as a PDF
                          },
                        ),
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
                  'CV Generator',
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
                  'Create a professional resume in minutes',
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
              Icons.description_outlined,
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
                  'Build your CV',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Fill in your details, pick a template and get a clean CV.',
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
              Icons.badge_outlined,
              color: Colors.white,
              size: 38,
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

class _TemplateChip extends StatelessWidget {
  final _Template template;
  final bool selected;
  final VoidCallback onTap;

  const _TemplateChip({
    required this.template,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? template.color : _fieldBorder,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: template.color,
                shape: BoxShape.circle,
              ),
              child: selected
                  ? const Icon(Icons.check, color: Colors.white, size: 12)
                  : null,
            ),
            const SizedBox(width: 8),
            Text(
              template.name,
              style: const TextStyle(
                color: _navy,
                fontWeight: FontWeight.w700,
                fontSize: 13.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
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

class _OutlineButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _OutlineButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(27),
        border: Border.all(color: _blue, width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(27),
          onTap: onTap,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: _blue, size: 22),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: const TextStyle(
                    color: _blue,
                    fontSize: 16,
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

// The generated CV, drawn like a paper page.
class _CvPreview extends StatelessWidget {
  final Color accent;
  final String name;
  final String email;
  final String phone;
  final String city;
  final String summary;
  final String college;
  final String course;
  final String eduYear;
  final String cgpa;
  final List<String> skills;
  final String projectTitle;
  final String projectDesc;

  const _CvPreview({
    required this.accent,
    required this.name,
    required this.email,
    required this.phone,
    required this.city,
    required this.summary,
    required this.college,
    required this.course,
    required this.eduYear,
    required this.cgpa,
    required this.skills,
    required this.projectTitle,
    required this.projectDesc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _navy.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: accent,
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 14,
                    runSpacing: 6,
                    children: [
                      _ContactItem(icon: Icons.mail_outline, text: email),
                      _ContactItem(icon: Icons.phone_outlined, text: phone),
                      if (city.isNotEmpty)
                        _ContactItem(
                          icon: Icons.location_on_outlined,
                          text: city,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (summary.isNotEmpty) ...[
                    _CvHeading('SUMMARY', accent),
                    Text(
                      summary,
                      style: const TextStyle(
                        color: _navy,
                        fontSize: 13.5,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  _CvHeading('EDUCATION', accent),
                  Text(
                    college,
                    style: const TextStyle(
                      color: _navy,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    course,
                    style: const TextStyle(color: _textGrey, fontSize: 13.5),
                  ),
                  if (eduYear.isNotEmpty || cgpa.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        [
                          if (eduYear.isNotEmpty) eduYear,
                          if (cgpa.isNotEmpty) 'CGPA: $cgpa',
                        ].join('   ·   '),
                        style: const TextStyle(color: _textGrey, fontSize: 13),
                      ),
                    ),
                  const SizedBox(height: 16),
                  _CvHeading('SKILLS', accent),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final String s in skills)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: accent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            s,
                            style: TextStyle(
                              color: accent,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (projectTitle.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _CvHeading('PROJECT', accent),
                    Text(
                      projectTitle,
                      style: const TextStyle(
                        color: _navy,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (projectDesc.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        projectDesc,
                        style: const TextStyle(
                          color: _textGrey,
                          fontSize: 13.5,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 15),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 12.5),
          ),
        ),
      ],
    );
  }
}

class _CvHeading extends StatelessWidget {
  final String text;
  final Color color;

  const _CvHeading(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(height: 1.5, color: color.withOpacity(0.25)),
          ),
        ],
      ),
    );
  }
}
