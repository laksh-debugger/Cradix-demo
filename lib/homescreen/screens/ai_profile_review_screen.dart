import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);
const Color _purple = Color(0xFF7E3FE4);
const Color _green = Color(0xFF2FB36B);
const Color _orange = Color(0xFFF5A623);

class _Tip {
  final String title;
  final String detail;

  const _Tip(this.title, this.detail);
}

// TODO: replace this sample data with the real AI result later.
const int _sampleScore = 75;

const List<String> _sampleStrengths = [
  'Your education details are complete',
  'You have added technical skills',
  'You have at least one project listed',
  'Your profile photo and basic details are filled in',
];

const List<_Tip> _sampleTips = [
  _Tip(
    'Add your LinkedIn and GitHub links',
    'Recruiters check these first. Add them in About Me.',
  ),
  _Tip(
    'Write a longer introduction',
    'A short, clear intro about your goals makes your profile stand out.',
  ),
  _Tip(
    'Add one more project',
    'Two or three projects with a tech stack show real skills.',
  ),
  _Tip(
    'Upload a certificate',
    'Certificates and achievements build trust with recruiters.',
  ),
];

class AiProfileReviewScreen extends StatefulWidget {
  const AiProfileReviewScreen({super.key});

  @override
  State<AiProfileReviewScreen> createState() => _AiProfileReviewScreenState();
}

class _AiProfileReviewScreenState extends State<AiProfileReviewScreen> {
  bool _loading = false;
  bool _done = false;

  Future<void> _runReview() async {
    setState(() {
      _loading = true;
      _done = false;
    });

    // TODO: call the real AI service here and use its result.
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() {
      _loading = false;
      _done = true;
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
                      'AI Profile Review',
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
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                        child: _buildBody(),
                      ),
                    ),
                    _BottomBar(
                      label: _done ? 'Review Again' : 'Start AI Review',
                      loading: _loading,
                      onTap: _runReview,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const _LoadingCard();
    }
    if (_done) {
      return Column(
        children: [
          const _ScoreCard(score: _sampleScore),
          _ResultCard(
            title: 'Strengths',
            subtitle: 'What your profile does well',
            icon: Icons.thumb_up_alt_outlined,
            color: _green,
            child: Column(
              children: [
                for (final String item in _sampleStrengths)
                  _StrengthRow(text: item),
              ],
            ),
          ),
          _ResultCard(
            title: 'Suggestions',
            subtitle: 'Small steps to improve your profile',
            icon: Icons.lightbulb_outline,
            color: _orange,
            child: Column(
              children: [for (final _Tip tip in _sampleTips) _TipRow(tip: tip)],
            ),
          ),
        ],
      );
    }
    return const _IntroCard();
  }
}

// ---------------- Intro ----------------

class _IntroCard extends StatelessWidget {
  const _IntroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: _purple.withOpacity(0.14),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome, color: _purple, size: 36),
          ),
          const SizedBox(height: 16),
          const Text(
            'Get your AI profile review',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: _navy,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'AI will check your profile and tell you what is strong, '
            'what is missing, and how to get noticed by recruiters.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, height: 1.35, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

// ---------------- Loading ----------------

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: _cardDecoration(),
      child: const Column(
        children: [
          SizedBox(
            width: 44,
            height: 44,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation(_purple),
            ),
          ),
          SizedBox(height: 18),
          Text(
            'Analysing your profile...',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _navy,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'This only takes a moment.',
            style: TextStyle(fontSize: 12.5, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

// ---------------- Score ----------------

class _ScoreCard extends StatelessWidget {
  const _ScoreCard({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    final String message = score >= 80
        ? 'Excellent! Your profile is very strong.'
        : score >= 60
        ? 'Good start. A few changes will make it stronger.'
        : 'Your profile needs more details.';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          SizedBox(
            width: 92,
            height: 92,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: score / 100,
                  strokeWidth: 9,
                  backgroundColor: const Color(0xFFE3EEFF),
                  valueColor: const AlwaysStoppedAnimation(_blue),
                ),
                Center(
                  child: Text(
                    '$score%',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: _navy,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile Score',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _navy,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.3,
                    color: Colors.black54,
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

// ---------------- Result sections ----------------

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.child,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _navy,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _StrengthRow extends StatelessWidget {
  const _StrengthRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: _green, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, height: 1.3, color: _navy),
            ),
          ),
        ],
      ),
    );
  }
}

class _TipRow extends StatelessWidget {
  const _TipRow({required this.tip});

  final _Tip tip;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline, color: _orange, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _navy,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  tip.detail,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.3,
                    color: Colors.black54,
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

// ---------------- Bottom button ----------------

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.label,
    required this.loading,
    required this.onTap,
  });

  final String label;
  final bool loading;
  final VoidCallback onTap;

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
          onPressed: loading ? null : onTap,
          icon: const Icon(Icons.auto_awesome, size: 18),
          label: Text(
            label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: _blue,
            foregroundColor: Colors.white,
            disabledBackgroundColor: _blue.withOpacity(0.4),
            disabledForegroundColor: Colors.white70,
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

BoxDecoration _cardDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.06),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ],
  );
}
