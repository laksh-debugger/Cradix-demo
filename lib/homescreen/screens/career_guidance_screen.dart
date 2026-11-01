import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _blue2 = Color(0xFF4A8BF5);
const Color _bg = Color(0xFFF5F8FE);
const Color _textGrey = Color(0xFF6B7A93);
const Color _fieldBorder = Color(0xFFDDE5F3);
const Color _red = Color(0xFFE53935);

class _Career {
  final String title;
  final String note;
  final IconData icon;
  final Color color;

  const _Career(this.title, this.note, this.icon, this.color);
}

// Sample suggestions. Replace with real AI results later.
const Map<String, List<_Career>> _careersByInterest = {
  'Software': [
    _Career(
      'Software Developer',
      'Build apps and websites',
      Icons.code,
      Color(0xFF1E63E9),
    ),
    _Career(
      'Backend Engineer',
      'Servers, APIs and databases',
      Icons.storage_outlined,
      Color(0xFF6C3FE0),
    ),
  ],
  'Data & AI': [
    _Career(
      'Data Analyst',
      'Turn data into decisions',
      Icons.bar_chart,
      Color(0xFF1FA971),
    ),
    _Career(
      'ML Engineer',
      'Train and ship AI models',
      Icons.psychology_outlined,
      Color(0xFFE5486E),
    ),
  ],
  'Design': [
    _Career(
      'UI/UX Designer',
      'Design apps people love',
      Icons.brush_outlined,
      Color(0xFFF59E0B),
    ),
  ],
  'Business': [
    _Career(
      'Product Manager',
      'Lead products from idea to launch',
      Icons.rocket_launch_outlined,
      Color(0xFF2F8BEA),
    ),
    _Career(
      'Business Analyst',
      'Connect business and tech',
      Icons.insights_outlined,
      Color(0xFF6C3FE0),
    ),
  ],
  'Marketing': [
    _Career(
      'Digital Marketer',
      'Grow brands online',
      Icons.campaign_outlined,
      Color(0xFFE5486E),
    ),
  ],
  'Cyber Security': [
    _Career(
      'Security Analyst',
      'Protect systems from attacks',
      Icons.shield_outlined,
      Color(0xFF1FA971),
    ),
  ],
};

const List<String> _years = [
  '1st Year',
  '2nd Year',
  '3rd Year',
  '4th Year',
  'Graduated',
];

class CareerGuidanceScreen extends StatefulWidget {
  const CareerGuidanceScreen({super.key});

  @override
  State<CareerGuidanceScreen> createState() => _CareerGuidanceScreenState();
}

class _CareerGuidanceScreenState extends State<CareerGuidanceScreen> {
  final ScrollController _scroll = ScrollController();
  final TextEditingController _questionCtrl = TextEditingController();

  final Set<String> _interests = {};
  String? _year;
  bool _showResult = false;
  bool _tried = false; // true after the button is pressed once

  @override
  void dispose() {
    _scroll.dispose();
    _questionCtrl.dispose();
    super.dispose();
  }

  List<_Career> _careers() {
    final List<_Career> list = [];
    for (final String i in _interests) {
      list.addAll(_careersByInterest[i] ?? const []);
    }
    return list;
  }

  void _getRoadmap() {
    setState(() => _tried = true);
    if (_interests.isEmpty || _year == null) return;

    // TODO: send the interests and year to your AI / backend
    // and show the real answer instead of this sample data.
    setState(() => _showResult = true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
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
                      const SizedBox(height: 20),
                      const _SectionTitle('What are you interested in?'),
                      const SizedBox(height: 4),
                      const Text(
                        'Pick one or more.',
                        style: TextStyle(color: _textGrey, fontSize: 13),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final String name in _careersByInterest.keys)
                            FilterChip(
                              label: Text(name),
                              selected: _interests.contains(name),
                              showCheckmark: false,
                              backgroundColor: Colors.white,
                              selectedColor: _blue,
                              side: const BorderSide(color: _fieldBorder),
                              labelStyle: TextStyle(
                                color: _interests.contains(name)
                                    ? Colors.white
                                    : _navy,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.5,
                              ),
                              onSelected: (on) {
                                setState(() {
                                  if (on) {
                                    _interests.add(name);
                                  } else {
                                    _interests.remove(name);
                                  }
                                  _showResult = false;
                                });
                              },
                            ),
                        ],
                      ),
                      if (_tried && _interests.isEmpty)
                        const _ErrorText('Please pick at least one interest'),
                      const SizedBox(height: 20),
                      const _SectionTitle('Which year are you in?'),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: (_tried && _year == null)
                                ? _red
                                : _fieldBorder,
                            width: (_tried && _year == null) ? 2 : 1,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _year,
                            isExpanded: true,
                            hint: const Text(
                              'Select your year',
                              style: TextStyle(color: _textGrey),
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: _blue,
                            ),
                            items: [
                              for (final String y in _years)
                                DropdownMenuItem<String>(
                                  value: y,
                                  child: Text(y),
                                ),
                            ],
                            onChanged: (v) => setState(() {
                              _year = v;
                              _showResult = false;
                            }),
                          ),
                        ),
                      ),
                      if (_tried && _year == null)
                        const _ErrorText('Please select your year'),
                      const SizedBox(height: 22),
                      _GradientButton(
                        label: 'Get My Roadmap',
                        icon: Icons.auto_awesome,
                        onTap: _getRoadmap,
                      ),
                      if (_showResult) ...[
                        const SizedBox(height: 26),
                        const _SectionTitle('Careers that fit you'),
                        const SizedBox(height: 12),
                        for (final _Career c in _careers()) ...[
                          _CareerCard(career: c),
                          const SizedBox(height: 10),
                        ],
                        const SizedBox(height: 14),
                        _SectionTitle('Your roadmap  ·  $_year'),
                        const SizedBox(height: 12),
                        const _RoadmapStep(
                          number: 1,
                          title: 'Build the basics',
                          text: 'Learn the core skills for your chosen field with one good course.',
                        ),
                        const _RoadmapStep(
                          number: 2,
                          title: 'Make 2-3 projects',
                          text: 'Projects prove your skills. Put them on GitHub or your profile.',
                        ),
                        const _RoadmapStep(
                          number: 3,
                          title: 'Join hackathons & events',
                          text: 'Meet teammates, learn fast and earn certificates.',
                        ),
                        const _RoadmapStep(
                          number: 4,
                          title: 'Apply for internships',
                          text: 'Use your CV and profile to apply on Cradix early.',
                          isLast: true,
                        ),
                      ],
                      const SizedBox(height: 24),
                      const _SectionTitle('Have a question?'),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 4, 6, 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: _fieldBorder),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _questionCtrl,
                                decoration: const InputDecoration(
                                  hintText: 'Ask about any career...',
                                  hintStyle: TextStyle(color: _textGrey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // TODO: send the question to your AI
                              },
                              icon: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: _blue,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                  'Career Guidance AI',
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
                  'Personal career suggestions and roadmap',
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
              Icons.explore_outlined,
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
                  'Find your path',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Tell us what you like and we will suggest careers and a simple plan.',
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
            child: const Icon(Icons.route, color: Colors.white, size: 38),
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

class _CareerCard extends StatelessWidget {
  final _Career career;

  const _CareerCard({required this.career});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: career.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(career.icon, color: career.color, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  career.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _navy,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  career.note,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: _textGrey, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoadmapStep extends StatelessWidget {
  final int number;
  final String title;
  final String text;
  final bool isLast;

  const _RoadmapStep({
    required this.number,
    required this.title,
    required this.text,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 34,
            child: Column(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: _blue,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$number',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(child: Container(width: 2, color: _fieldBorder)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: _navy,
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    text,
                    style: const TextStyle(
                      color: _textGrey,
                      fontSize: 13.5,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
