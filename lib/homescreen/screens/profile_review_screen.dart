import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _blue2 = Color(0xFF4A8BF5);
const Color _bg = Color(0xFFF5F8FE);
const Color _fieldBorder = Color(0xFFDDE5F3);
const Color _textGrey = Color(0xFF6B7A93);
const Color _green = Color(0xFF1FA971);
const Color _orange = Color(0xFFF59E0B);
const Color _red = Color(0xFFE53935);

class _Item {
  final String title;
  final String tip; // shown when this item is missing
  final IconData icon;
  final int points;

  const _Item(this.title, this.tip, this.icon, this.points);
}

// The points add up to 100.
const List<_Item> _items = [
  _Item(
    'Profile photo',
    'Add a clear, friendly photo. Profiles with photos get noticed more.',
    Icons.account_circle_outlined,
    10,
  ),
  _Item(
    'Headline',
    'Write one line about you, like "Flutter developer | B.Tech CSE".',
    Icons.title,
    10,
  ),
  _Item(
    'About section',
    'Add 3-4 lines about what you study, what you build and what you want next.',
    Icons.notes_outlined,
    15,
  ),
  _Item(
    'Education details',
    'Add your college, course and year so recruiters can find you.',
    Icons.school_outlined,
    10,
  ),
  _Item(
    '5 or more skills',
    'List at least 5 skills. Recruiters search by skills.',
    Icons.bolt_outlined,
    15,
  ),
  _Item(
    'At least 2 projects',
    'Add 2 projects with a short description. Projects are the strongest proof.',
    Icons.rocket_launch_outlined,
    20,
  ),
  _Item(
    'Certificates',
    'Upload any course, hackathon or event certificates you have earned.',
    Icons.workspace_premium_outlined,
    10,
  ),
  _Item(
    'GitHub or LinkedIn link',
    'Add a link so recruiters can see more of your work.',
    Icons.link,
    10,
  ),
];

class ProfileReviewScreen extends StatefulWidget {
  const ProfileReviewScreen({super.key});

  @override
  State<ProfileReviewScreen> createState() => _ProfileReviewScreenState();
}

class _ProfileReviewScreenState extends State<ProfileReviewScreen> {
  final ScrollController _scroll = ScrollController();

  // Sample starting ticks (photo, education, skills).
  // TODO: fill these from the user's real profile data.
  final Set<int> _have = {0, 3, 4};
  bool _showResult = false;

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  int get _score {
    int total = 0;
    for (final int i in _have) {
      total += _items[i].points;
    }
    return total;
  }

  Color _scoreColor(int score) {
    if (score >= 80) return _green;
    if (score >= 50) return _orange;
    return _red;
  }

  String _scoreLabel(int score) {
    if (score >= 80) return 'Excellent profile';
    if (score >= 50) return 'Good start';
    return 'Needs work';
  }

  void _review() {
    // TODO: send the profile to your AI for deeper feedback.
    setState(() => _showResult = true);

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
    final int score = _score;
    final List<int> missing = [
      for (int i = 0; i < _items.length; i++)
        if (!_have.contains(i)) i,
    ];

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
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                    children: [
                      const _IntroBanner(),
                      const SizedBox(height: 20),
                      const _SectionTitle('What does your profile have?'),
                      const SizedBox(height: 4),
                      const Text(
                        'Tick everything you have already added.',
                        style: TextStyle(color: _textGrey, fontSize: 13),
                      ),
                      const SizedBox(height: 12),
                      for (int i = 0; i < _items.length; i++) ...[
                        _CheckCard(
                          item: _items[i],
                          checked: _have.contains(i),
                          onTap: () => setState(() {
                            if (_have.contains(i)) {
                              _have.remove(i);
                            } else {
                              _have.add(i);
                            }
                            _showResult = false;
                          }),
                        ),
                        const SizedBox(height: 10),
                      ],
                      const SizedBox(height: 12),
                      _GradientButton(
                        label: 'Review My Profile',
                        icon: Icons.fact_check_outlined,
                        onTap: _review,
                      ),
                      if (_showResult) ...[
                        const SizedBox(height: 26),
                        _ScoreCard(
                          score: score,
                          color: _scoreColor(score),
                          label: _scoreLabel(score),
                        ),
                        const SizedBox(height: 20),
                        if (missing.isNotEmpty) ...[
                          const _SectionTitle('Improve next'),
                          const SizedBox(height: 12),
                          for (final int i in missing) ...[
                            _TipCard(item: _items[i]),
                            const SizedBox(height: 10),
                          ],
                        ] else
                          const _AllDoneCard(),
                        const SizedBox(height: 10),
                        _OutlineButton(
                          label: 'Edit My Profile',
                          icon: Icons.edit_outlined,
                          onTap: () {
                            // TODO: open the Edit Profile screen
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
                  'Profile Review',
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
                  'Improve your profile and get feedback',
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
              Icons.how_to_reg_outlined,
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
                  'Get noticed',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'A complete profile helps recruiters find you faster.',
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
              Icons.verified_user_outlined,
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

class _CheckCard extends StatelessWidget {
  final _Item item;
  final bool checked;
  final VoidCallback onTap;

  const _CheckCard({
    required this.item,
    required this.checked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: checked ? _green : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: _navy.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(item.icon, color: _blue, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      color: _navy,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  checked ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: checked ? _green : _fieldBorder,
                  size: 28,
                ),
              ],
            ),
          ),
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

// Big circle with the score in the middle.
class _ScoreCard extends StatelessWidget {
  final int score;
  final Color color;
  final String label;

  const _ScoreCard({
    required this.score,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: _navy.withOpacity(0.1),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 104,
            height: 104,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 104,
                  height: 104,
                  child: CircularProgressIndicator(
                    value: score / 100,
                    strokeWidth: 9,
                    backgroundColor: _fieldBorder,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$score%',
                      style: TextStyle(
                        color: color,
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Text(
                      'complete',
                      style: TextStyle(color: _textGrey, fontSize: 11.5),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Finish the steps below to make your profile stronger.',
                  style: TextStyle(
                    color: _textGrey,
                    fontSize: 13.5,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  final _Item item;

  const _TipCard({required this.item});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _orange.withOpacity(0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: _orange, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _navy,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: _green.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '+${item.points}%',
                        style: const TextStyle(
                          color: _green,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.tip,
                  style: const TextStyle(
                    color: _textGrey,
                    fontSize: 13.5,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AllDoneCard extends StatelessWidget {
  const _AllDoneCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          Icon(Icons.celebration_outlined, color: _green, size: 28),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Great job! Your profile has everything recruiters look for.',
              style: TextStyle(
                color: _navy,
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
