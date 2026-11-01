import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  final List<_Faq> _faqs = const [
    _Faq(
      'How do I verify my Student Passport?',
      'Open the menu, tap Student Passport and follow the steps. You will need your college email and roll number. Verification usually takes a short while.',
    ),
    _Faq(
      'How do I apply for an internship?',
      'Go to the Internships tab, open any listing and tap Apply. Make sure your profile and CV are complete before applying.',
    ),
    _Faq(
      'How do I find a hackathon team?',
      'Open Hackathon Buddy from the Quick Hub on Home. You can browse students, send team requests and accept invites.',
    ),
    _Faq(
      'How can I improve my Career Pulse score?',
      'Complete your profile, add certificates and projects, and stay active on the campus feed. Tap the Career Pulse card on Home to see tips.',
    ),
    _Faq(
      'I forgot my password. What should I do?',
      'On the sign-in screen tap Forgot password and enter your registered email. We will send you a reset link.',
    ),
    _Faq(
      'How do I delete my account?',
      'Go to Settings, then Privacy & Security, and choose Delete Account. This cannot be undone, so download your data first.',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<_Faq> shown = _faqs
        .where(
          (f) =>
              f.question.toLowerCase().contains(_query.toLowerCase()) ||
              f.answer.toLowerCase().contains(_query.toLowerCase()),
        )
        .toList();

    return Scaffold(
      backgroundColor: _navy,
      body: Column(
        children: [
          _Header(onBack: () => Navigator.of(context).pop()),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                children: [
                  // Search box
                  Container(
                    decoration: BoxDecoration(
                      color: _bg,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (v) => setState(() => _query = v),
                      decoration: const InputDecoration(
                        hintText: 'Search for help...',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.black45,
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.black45),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),

                  const _SectionTitle('Contact Us'),
                  _Card(
                    children: [
                      _ContactTile(
                        icon: Icons.chat_bubble_outline,
                        color: Colors.green,
                        title: 'Live Chat',
                        subtitle: 'Chat with our support team',
                        onTap: () {
                          // TODO: open live chat / Chats screen
                        },
                      ),
                      const _Divider(),
                      _ContactTile(
                        icon: Icons.mail_outline,
                        color: _blue,
                        title: 'Email Support',
                        subtitle: 'support@cradix.app',
                        onTap: () {
                          // TODO: open email app (needs url_launcher package)
                        },
                      ),
                      const _Divider(),
                      _ContactTile(
                        icon: Icons.phone_outlined,
                        color: Colors.orange,
                        title: 'Call Us',
                        subtitle: 'Mon - Sat, 10 AM to 6 PM',
                        onTap: () {
                          // TODO: open phone dialer (needs url_launcher package)
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),

                  const _SectionTitle('Frequently Asked Questions'),
                  if (shown.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: Text(
                          'No results found. Try different words.',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    )
                  else
                    _Card(
                      children: [
                        for (int i = 0; i < shown.length; i++) ...[
                          _FaqTile(faq: shown[i]),
                          if (i != shown.length - 1) const _Divider(),
                        ],
                      ],
                    ),
                  const SizedBox(height: 22),

                  const _SectionTitle('Something not working?'),
                  _Card(
                    children: [
                      _ContactTile(
                        icon: Icons.bug_report_outlined,
                        color: Colors.red,
                        title: 'Report a Problem',
                        subtitle: 'Tell us what went wrong',
                        onTap: () {
                          // TODO: open Report a Problem page
                        },
                      ),
                      const _Divider(),
                      _ContactTile(
                        icon: Icons.lightbulb_outline,
                        color: Colors.purple,
                        title: 'Suggest a Feature',
                        subtitle: 'Share your ideas with us',
                        onTap: () {
                          // TODO: open Feedback page
                        },
                      ),
                    ],
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

class _Faq {
  final String question;
  final String answer;

  const _Faq(this.question, this.answer);
}

class _Header extends StatelessWidget {
  final VoidCallback onBack;

  const _Header({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 16, 20),
        child: Row(
          children: [
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            const SizedBox(width: 4),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Help & Support',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'FAQs, contact us, report a problem',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
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

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: _navy,
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final List<Widget> children;

  const _Card({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(children: children),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, indent: 14, endIndent: 14, color: _bg);
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: _blue),
          ],
        ),
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  final _Faq faq;

  const _FaqTile({required this.faq});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 14),
        childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        iconColor: _blue,
        collapsedIconColor: _blue,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Text(
          faq.question,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A2E),
          ),
        ),
        children: [
          Text(
            faq.answer,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
