import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);

class AboutCradixScreen extends StatelessWidget {
  const AboutCradixScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                children: [
                  // Logo + name + version
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 84,
                          height: 84,
                          decoration: BoxDecoration(
                            color: _blue,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: _blue.withOpacity(0.3),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          // Placeholder logo. Replace the Icon with:
                          // Image.asset('assets/images/logo.png')
                          child: const Icon(
                            Icons.school_rounded,
                            color: Colors.white,
                            size: 44,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'CRADIX',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: _navy,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Version 1.0.0',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Description card
                  _Card(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'CRADIX is a campus recruitment and student network app. '
                          'It connects students with internships, hackathons, '
                          'companies and each other, so you can build your profile, '
                          'grow your skills and get hired.',
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.5,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),

                  const _SectionTitle('What You Can Do'),
                  _Card(
                    children: const [
                      _FeatureTile(
                        icon: Icons.verified_user_outlined,
                        color: _blue,
                        title: 'Student Passport',
                        subtitle: 'Verify your identity and college',
                      ),
                      _Divider(),
                      _FeatureTile(
                        icon: Icons.work_outline,
                        color: Colors.orange,
                        title: 'Internships & Jobs',
                        subtitle: 'Find and apply to opportunities',
                      ),
                      _Divider(),
                      _FeatureTile(
                        icon: Icons.groups_outlined,
                        color: Colors.purple,
                        title: 'Hackathon Buddy',
                        subtitle: 'Team up with other students',
                      ),
                      _Divider(),
                      _FeatureTile(
                        icon: Icons.trending_up,
                        color: Colors.green,
                        title: 'Career Pulse',
                        subtitle: 'Track and improve your profile strength',
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),

                  const _SectionTitle('Legal & Links'),
                  _Card(
                    children: [
                      _LinkTile(
                        icon: Icons.description_outlined,
                        title: 'Terms of Service',
                        onTap: () {
                          // TODO: open Privacy & Terms page
                        },
                      ),
                      const _Divider(),
                      _LinkTile(
                        icon: Icons.privacy_tip_outlined,
                        title: 'Privacy Policy',
                        onTap: () {
                          // TODO: open Privacy & Terms page
                        },
                      ),
                      const _Divider(),
                      _LinkTile(
                        icon: Icons.code,
                        title: 'Open Source Licenses',
                        onTap: () {
                          // TODO: could use Flutter's showLicensePage(context: context)
                        },
                      ),
                      const _Divider(),
                      _LinkTile(
                        icon: Icons.language,
                        title: 'Visit Our Website',
                        onTap: () {
                          // TODO: open website (needs url_launcher package)
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  const Center(
                    child: Text(
                      'Made with care for students',
                      style: TextStyle(fontSize: 12, color: Colors.black45),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Center(
                    child: Text(
                      '\u00A9 2026 CRADIX. All rights reserved.',
                      style: TextStyle(fontSize: 11.5, color: Colors.black38),
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
                    'About CRADIX',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'App info, version and legal',
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

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const _FeatureTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  style: const TextStyle(fontSize: 11.5, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _LinkTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: _blue, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: _blue),
          ],
        ),
      ),
    );
  }
}
