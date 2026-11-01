import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _blue2 = Color(0xFF4A8BF5);
const Color _bg = Color(0xFFF5F8FE);
const Color _fieldBg = Color(0xFFF6F8FC);
const Color _fieldBorder = Color(0xFFDDE5F3);
const Color _hint = Color(0xFF9AA7BF);
const Color _textGrey = Color(0xFF6B7A93);
const Color _red = Color(0xFFE53935);

const List<String> _tones = ['Professional', 'Friendly', 'Confident'];

class CoverLetterScreen extends StatefulWidget {
  const CoverLetterScreen({super.key});

  @override
  State<CoverLetterScreen> createState() => _CoverLetterScreenState();
}

class _CoverLetterScreenState extends State<CoverLetterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scroll = ScrollController();

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _companyCtrl = TextEditingController();
  final TextEditingController _roleCtrl = TextEditingController();
  final TextEditingController _managerCtrl = TextEditingController();
  final TextEditingController _eduCtrl = TextEditingController();
  final TextEditingController _skillsCtrl = TextEditingController();
  final TextEditingController _whyCtrl = TextEditingController();

  int _tone = 0;
  bool _showLetter = false;
  String _letter = '';

  @override
  void dispose() {
    _scroll.dispose();
    _nameCtrl.dispose();
    _companyCtrl.dispose();
    _roleCtrl.dispose();
    _managerCtrl.dispose();
    _eduCtrl.dispose();
    _skillsCtrl.dispose();
    _whyCtrl.dispose();
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

  // Builds the letter from what the user typed.
  // TODO: replace this with a real AI call to write a better letter.
  String _buildLetter() {
    final String name = _nameCtrl.text.trim();
    final String company = _companyCtrl.text.trim();
    final String role = _roleCtrl.text.trim();
    final String manager = _managerCtrl.text.trim();
    final String edu = _eduCtrl.text.trim();
    final String skills = _skillsCtrl.text.trim();
    final String why = _whyCtrl.text.trim();

    final String greeting = manager.isEmpty
        ? 'Dear Hiring Manager,'
        : 'Dear $manager,';

    String opening;
    if (_tone == 1) {
      opening =
          'I was so excited to see the $role opening at $company, and I would love to be part of your team.';
    } else if (_tone == 2) {
      opening =
          'I am a strong fit for the $role role at $company, and I would like to show you why.';
    } else {
      opening =
          'I am writing to express my interest in the $role position at $company.';
    }

    final StringBuffer b = StringBuffer();
    b.writeln(greeting);
    b.writeln();
    b.writeln(opening);
    b.writeln();
    b.writeln(
      'I am currently studying $edu, and I have built skills in $skills. I enjoy learning fast and turning what I learn into real work.',
    );
    if (why.isNotEmpty) {
      b.writeln();
      b.writeln('What draws me to $company: $why');
    }
    b.writeln();
    b.writeln(
      'Thank you for your time and consideration. I would be glad to discuss how I can contribute to $company.',
    );
    b.writeln();
    b.writeln('Sincerely,');
    b.write(name);
    return b.toString();
  }

  void _generate() {
    final bool valid = _formKey.currentState!.validate();
    if (!valid) return;

    setState(() {
      _letter = _buildLetter();
      _showLetter = true;
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

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: _letter));
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Cover letter copied')));
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
                      const _SectionTitle('Choose a tone'),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (int i = 0; i < _tones.length; i++)
                            ChoiceChip(
                              label: Text(_tones[i]),
                              selected: _tone == i,
                              showCheckmark: false,
                              backgroundColor: Colors.white,
                              selectedColor: _blue,
                              side: const BorderSide(color: _fieldBorder),
                              labelStyle: TextStyle(
                                color: _tone == i ? Colors.white : _navy,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.5,
                              ),
                              onSelected: (_) => setState(() {
                                _tone = i;
                                _showLetter = false;
                              }),
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
                              title: 'The job',
                              icon: Icons.work_outline,
                              children: [
                                TextFormField(
                                  controller: _companyCtrl,
                                  textCapitalization: TextCapitalization.words,
                                  textInputAction: TextInputAction.next,
                                  decoration: _decoration(
                                    'Company Name',
                                    Icons.business_outlined,
                                  ),
                                  validator: (v) =>
                                      _required(v, 'Please enter the company'),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _roleCtrl,
                                  textCapitalization: TextCapitalization.words,
                                  textInputAction: TextInputAction.next,
                                  decoration: _decoration(
                                    'Role (e.g. Flutter Intern)',
                                    Icons.badge_outlined,
                                  ),
                                  validator: (v) =>
                                      _required(v, 'Please enter the role'),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _managerCtrl,
                                  textCapitalization: TextCapitalization.words,
                                  textInputAction: TextInputAction.next,
                                  decoration: _decoration(
                                    'Hiring manager name (Optional)',
                                    Icons.person_search_outlined,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            _SectionCard(
                              title: 'About you',
                              icon: Icons.person_outline,
                              children: [
                                TextFormField(
                                  controller: _nameCtrl,
                                  textCapitalization: TextCapitalization.words,
                                  textInputAction: TextInputAction.next,
                                  decoration: _decoration(
                                    'Your Full Name',
                                    Icons.person_outline,
                                  ),
                                  validator: (v) =>
                                      _required(v, 'Please enter your name'),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _eduCtrl,
                                  textInputAction: TextInputAction.next,
                                  decoration: _decoration(
                                    'Course & college (e.g. B.Tech CSE at LPU)',
                                    Icons.school_outlined,
                                  ),
                                  validator: (v) => _required(
                                    v,
                                    'Please enter your course and college',
                                  ),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _skillsCtrl,
                                  textInputAction: TextInputAction.next,
                                  decoration: _decoration(
                                    'Key skills (e.g. Flutter, Dart, Firebase)',
                                    Icons.bolt_outlined,
                                  ),
                                  validator: (v) =>
                                      _required(v, 'Please enter your skills'),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _whyCtrl,
                                  maxLines: 3,
                                  decoration: _decoration(
                                    'Why this company? (Optional)',
                                    Icons.favorite_border,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                      _GradientButton(
                        label: 'Generate Letter',
                        icon: Icons.auto_awesome,
                        onTap: _generate,
                      ),
                      if (_showLetter) ...[
                        const SizedBox(height: 26),
                        const _SectionTitle('Your cover letter'),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
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
                          child: SelectableText(
                            _letter,
                            style: const TextStyle(
                              color: _navy,
                              fontSize: 14.5,
                              height: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _OutlineButton(
                          label: 'Copy Letter',
                          icon: Icons.copy_outlined,
                          onTap: _copy,
                        ),
                        const SizedBox(height: 10),
                        _OutlineButton(
                          label: 'Download PDF',
                          icon: Icons.download_outlined,
                          onTap: () {
                            // TODO: save the letter as a PDF
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
                  'Cover Letter',
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
                  'Customized letters for your applications',
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
              Icons.mail_outline,
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
                  'Stand out',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Add the job details and get a clean cover letter in seconds.',
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
              Icons.drafts_outlined,
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
