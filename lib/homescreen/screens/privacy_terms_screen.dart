import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);
const Color _ink = Color(0xFF1A2233);
const Color _muted = Color(0xFF6B7488);

class _Section {
  final String heading;
  final String body;
  const _Section(this.heading, this.body);
}

class _LegalDoc {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color bg;
  final List<_Section> sections;
  const _LegalDoc({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.bg,
    required this.sections,
  });
}

// NOTE: This is placeholder text. Replace it with your real legal text.
const List<_LegalDoc> _docs = [
  _LegalDoc(
    title: 'Privacy Policy',
    subtitle: 'How we collect and use your data',
    icon: Icons.privacy_tip_outlined,
    color: _blue,
    bg: Color(0xFFE3F0FF),
    sections: [
      _Section(
        '1. Information we collect',
        'We collect the details you give us when you sign up, such as your name, email, college and roll number. We also collect your activity in the app, like applications, saved items and posts.',
      ),
      _Section(
        '2. How we use your information',
        'We use your information to verify your student identity, show you relevant internships and events, and improve Cradix.',
      ),
      _Section(
        '3. Sharing your information',
        'Your profile may be visible to recruiters and your campus, based on your privacy settings. We do not sell your personal data.',
      ),
      _Section(
        '4. Your choices',
        'You can change who sees your profile, download your data, or delete your account from Settings > Privacy & Security.',
      ),
    ],
  ),
  _LegalDoc(
    title: 'Terms of Service',
    subtitle: 'Rules for using Cradix',
    icon: Icons.description_outlined,
    color: Color(0xFF7C4DFF),
    bg: Color(0xFFEDE7FF),
    sections: [
      _Section(
        '1. Accepting the terms',
        'By creating an account or using Cradix, you agree to these terms.',
      ),
      _Section(
        '2. Your account',
        'You must give correct information and keep your password safe. You are responsible for activity on your account.',
      ),
      _Section(
        '3. Acceptable use',
        'Do not post false information, spam, or anything illegal or harmful. We may remove content or suspend accounts that break these rules.',
      ),
      _Section(
        '4. Changes',
        'We may update these terms from time to time. If you keep using Cradix after an update, you accept the new terms.',
      ),
    ],
  ),
  _LegalDoc(
    title: 'Community Guidelines',
    subtitle: 'Keep Cradix safe and respectful',
    icon: Icons.groups_outlined,
    color: Color(0xFF16A36A),
    bg: Color(0xFFE0F6EC),
    sections: [
      _Section(
        'Be respectful',
        'Treat other students and recruiters with respect. No bullying, hate speech or harassment.',
      ),
      _Section(
        'Be honest',
        'Share real achievements, certificates and experience. Fake credentials can lead to account removal.',
      ),
      _Section(
        'Stay safe',
        'Never share passwords or OTPs. Report any suspicious job offer or message to our support team.',
      ),
    ],
  ),
  _LegalDoc(
    title: 'Data & Cookies',
    subtitle: 'How your data is stored',
    icon: Icons.storage_outlined,
    color: Color(0xFFF59E0B),
    bg: Color(0xFFFFF3DC),
    sections: [
      _Section(
        'Storage',
        'Your data is stored securely and only kept as long as your account is active, unless the law says otherwise.',
      ),
      _Section(
        'Analytics',
        'We may collect basic usage data (like which screens are opened) to find bugs and improve the app.',
      ),
      _Section(
        'Deleting your data',
        'When you delete your account, your personal data is removed from our systems within a reasonable time.',
      ),
    ],
  ),
];

class PrivacyTermsScreen extends StatelessWidget {
  const PrivacyTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _navy,
      body: Column(
        children: [
          _Header(
            title: 'Privacy & Terms',
            subtitle: 'Policies and legal information',
            onBack: () => Navigator.pop(context),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: _bg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
                  children: [
                    const _SectionTitle('Legal'),
                    _Card(
                      children: [
                        for (int i = 0; i < _docs.length; i++) ...[
                          if (i > 0) const _Divider(),
                          _NavTile(
                            doc: _docs[i],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      _LegalDocScreen(doc: _docs[i]),
                                ),
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 22),
                    const _SectionTitle('Questions?'),
                    _Card(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              const _IconBox(
                                icon: Icons.mail_outline,
                                color: _blue,
                                bg: Color(0xFFE3F0FF),
                              ),
                              const SizedBox(width: 14),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Contact us',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: _ink,
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    // TODO: put your real support email here
                                    Text(
                                      'support@cradix.app',
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        color: _muted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    const Center(
                      child: Text(
                        'Last updated: October 2026',
                        style: TextStyle(fontSize: 12, color: _muted),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegalDocScreen extends StatelessWidget {
  final _LegalDoc doc;
  const _LegalDocScreen({required this.doc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _navy,
      body: Column(
        children: [
          _Header(
            title: doc.title,
            subtitle: doc.subtitle,
            onBack: () => Navigator.pop(context),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: _bg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
                  children: [
                    _Card(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (final s in doc.sections) ...[
                                Text(
                                  s.heading,
                                  style: const TextStyle(
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w700,
                                    color: _ink,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  s.body,
                                  style: const TextStyle(
                                    fontSize: 13.5,
                                    height: 1.5,
                                    color: _muted,
                                  ),
                                ),
                                const SizedBox(height: 18),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onBack;
  const _Header({
    required this.title,
    required this.subtitle,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 20, 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFFC9D6F2),
                        fontSize: 13,
                      ),
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
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: _ink,
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
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 76,
      endIndent: 16,
      color: Color(0xFFEDF1F7),
    );
  }
}

class _IconBox extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color bg;
  const _IconBox({required this.icon, required this.color, required this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: color, size: 22),
    );
  }
}

class _NavTile extends StatelessWidget {
  final _LegalDoc doc;
  final VoidCallback onTap;
  const _NavTile({required this.doc, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            _IconBox(icon: doc.icon, color: doc.color, bg: doc.bg),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    doc.subtitle,
                    style: const TextStyle(fontSize: 12.5, color: _muted),
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
