import 'package:Cradix/homescreen/screens/explore_screen.dart';
import 'package:Cradix/homescreen/screens/profile_screen.dart';
import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);
const Color _textGrey = Color(0xFF6B7A99);
const Color _border = Color(0xFFE9EEF8);

class CertificatesScreen extends StatelessWidget {
  const CertificatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _navy,
      extendBody: true,
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
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
                  children: [
                    const _ProfileCard(),
                    const SizedBox(height: 14),
                    const _StatsCard(),
                    const SizedBox(height: 20),
                    _SectionRow(
                      title: 'My Certificates',
                      actionText: 'View all',
                      onAction: () {
                        // TODO: open the full certificates list
                      },
                    ),
                    const SizedBox(height: 10),
                    _CertificateCard(
                      cert: const _Cert(
                        icon: Icons.article_outlined,
                        color: Color(0xFF1E63E9),
                        bg: Color(0xFFE3F2FD),
                        title: 'Python Programming',
                        issuer: 'CodeAcademy',
                        date: '12 Mar 2025',
                      ),
                      onTap: () {
                        // TODO: open certificate details
                      },
                    ),
                    _CertificateCard(
                      cert: const _Cert(
                        icon: Icons.laptop_mac,
                        color: Color(0xFF7C4DFF),
                        bg: Color(0xFFEDE7FF),
                        title: 'Web Development Bootcamp',
                        issuer: 'TechLearn',
                        date: '28 Jan 2025',
                      ),
                      onTap: () {
                        // TODO: open certificate details
                      },
                    ),
                    _CertificateCard(
                      cert: const _Cert(
                        icon: Icons.psychology_outlined,
                        color: Color(0xFF0E9F8E),
                        bg: Color(0xFFDDF6F1),
                        title: 'AI & Machine Learning',
                        issuer: 'SkillForge',
                        date: '15 Dec 2024',
                      ),
                      onTap: () {
                        // TODO: open certificate details
                      },
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(left: 2, bottom: 10),
                      child: Text(
                        'Achievements & Badges',
                        style: TextStyle(
                          color: _navy,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _BadgeTile(
                          icon: Icons.emoji_events,
                          colorA: const Color(0xFF9B6BFF),
                          colorB: const Color(0xFF5B2DD1),
                          label: 'Hackathon\nFinalist',
                          onTap: () {
                            // TODO: open badge details
                          },
                        ),
                        const SizedBox(width: 8),
                        _BadgeTile(
                          icon: Icons.school,
                          colorA: const Color(0xFF4DA3FF),
                          colorB: const Color(0xFF1E63E9),
                          label: 'Top\nLearner',
                          onTap: () {
                            // TODO: open badge details
                          },
                        ),
                        const SizedBox(width: 8),
                        _BadgeTile(
                          icon: Icons.code,
                          colorA: const Color(0xFF3FD18B),
                          colorB: const Color(0xFF12894F),
                          label: 'Project\nBuilder',
                          onTap: () {
                            // TODO: open badge details
                          },
                        ),
                        const SizedBox(width: 8),
                        _BadgeTile(
                          icon: Icons.groups,
                          colorA: const Color(0xFFFFB84D),
                          colorB: const Color(0xFFF57C00),
                          label: 'Team\nPlayer',
                          onTap: () {
                            // TODO: open badge details
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _AddCertificateBanner(
                      onTap: () {
                        // TODO: open Add Certificate / upload page
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: open the "+" quick actions
        },
        backgroundColor: _blue,
        foregroundColor: Colors.white,
        elevation: 6,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const _BottomBar(),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 18),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Certificates & Achievements',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Showcase your milestones',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _cardDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    border: Border.all(color: _border),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ],
  );
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          // Replace the Icon with your photo:
          // CircleAvatar(radius: 30, backgroundImage: AssetImage('assets/images/profile.png'))
          const CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xFFE3EEFF),
            child: Icon(Icons.person, color: _blue, size: 34),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pranav Kabdal',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _navy,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'B.Tech CSE · 3rd Year',
                  style: TextStyle(color: _textGrey, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3EEFF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified, color: _blue, size: 15),
                      SizedBox(width: 4),
                      Text(
                        'Profile verified',
                        style: TextStyle(
                          color: _blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: _textGrey),
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      decoration: _cardDecoration(),
      child: const Row(
        children: [
          _Stat(
            icon: Icons.description_outlined,
            color: Color(0xFF1E63E9),
            bg: Color(0xFFE3F2FD),
            value: '06',
            label: 'Certificates',
          ),
          _StatDivider(),
          _Stat(
            icon: Icons.emoji_events_outlined,
            color: Color(0xFF7C4DFF),
            bg: Color(0xFFEDE7FF),
            value: '04',
            label: 'Achievements',
          ),
          _StatDivider(),
          _Stat(
            icon: Icons.star_outline,
            color: Color(0xFF12A769),
            bg: Color(0xFFE0F5EC),
            value: '08',
            label: 'Skills',
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 40, color: _border);
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color bg;
  final String value;
  final String label;

  const _Stat({
    required this.icon,
    required this.color,
    required this.bg,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 19),
            ),
            const SizedBox(width: 6),
            Expanded(
              // FittedBox shrinks the text a little on very narrow phones.
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        color: _navy,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      label,
                      style: const TextStyle(color: _textGrey, fontSize: 11.5),
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

class _SectionRow extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback onAction;

  const _SectionRow({
    required this.title,
    required this.actionText,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              title,
              style: const TextStyle(
                color: _navy,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: onAction,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  actionText,
                  style: const TextStyle(
                    color: _blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Icon(Icons.chevron_right, color: _blue, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Cert {
  final IconData icon;
  final Color color;
  final Color bg;
  final String title;
  final String issuer;
  final String date;

  const _Cert({
    required this.icon,
    required this.color,
    required this.bg,
    required this.title,
    required this.issuer,
    required this.date,
  });
}

class _CertificateCard extends StatelessWidget {
  final _Cert cert;
  final VoidCallback onTap;

  const _CertificateCard({required this.cert, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: _cardDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Replace this box with the certificate logo if you want:
                // Image.asset('assets/images/certificate.png')
                SizedBox(
                  width: 62,
                  height: 62,
                  child: Stack(
                    children: [
                      Container(
                        width: 62,
                        height: 62,
                        decoration: BoxDecoration(
                          color: cert.bg,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(cert.icon, color: cert.color, size: 32),
                      ),
                      const Positioned(
                        right: 2,
                        bottom: 2,
                        child: Icon(
                          Icons.workspace_premium,
                          color: Color(0xFFF5A623),
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cert.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _navy,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Issued by ${cert.issuer}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _textGrey,
                          fontSize: 12.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Wrap puts the button on its own line on narrow phones.
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                size: 14,
                                color: _textGrey,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Completed on ${cert.date}',
                                style: const TextStyle(
                                  color: _textGrey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3EEFF),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Text(
                              'View Certificate',
                              style: TextStyle(
                                color: _blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.chevron_right, color: _textGrey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BadgeTile extends StatelessWidget {
  final IconData icon;
  final Color colorA;
  final Color colorB;
  final String label;
  final VoidCallback onTap;

  const _BadgeTile({
    required this.icon,
    required this.colorA,
    required this.colorB,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: _cardDecoration(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [colorA, colorB],
                      ),
                    ),
                    child: Icon(icon, color: Colors.white, size: 26),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(
                      color: _navy,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AddCertificateBanner extends StatelessWidget {
  final VoidCallback onTap;

  const _AddCertificateBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF1E63E9), Color(0xFF2F7BFF)],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.22),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.cloud_upload_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add a Certificate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Upload a certificate or achievement',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70, fontSize: 12.5),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      elevation: 10,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: 62,
        child: Row(
          children: [
            _NavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              selected: false,
              onTap: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
            ),
            _NavItem(
              icon: Icons.explore_outlined,
              label: 'Explore',
              selected: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ExploreScreen()),
                );
              },
            ),
            const SizedBox(width: 64), // space for the round "+" button
            _NavItem(
              icon: Icons.chat_bubble_outline,
              label: 'Chat',
              selected: false,
              badge: 3,
              onTap: () {
                // TODO: open Chat screen
              },
            ),
            _NavItem(
              icon: Icons.person,
              label: 'Profile',
              selected: true,
              onTap: () {
                // Already in the Profile area. Tap = go back to Profile.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final int badge;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.badge = 0,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = selected ? _blue : const Color(0xFF8A97B3);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, color: color, size: 24),
                if (badge > 0)
                  Positioned(
                    right: -8,
                    top: -5,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE53935),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$badge',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
