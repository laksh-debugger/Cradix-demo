import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.85,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                children: [
                  // ---- Close button ----
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        color: _D.textDark,
                        size: 26,
                      ),
                    ),
                  ),

                  // ---- Profile header ----
                  const _DrawerProfile(),
                  const SizedBox(height: 18),

                  // ---- Edit My Profile ----
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: open edit profile screen
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: _D.chipBg,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.manage_accounts,
                            color: _D.primary,
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Edit My Profile',
                              style: TextStyle(
                                color: _D.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Icon(Icons.chevron_right, color: _D.primary),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Divider(color: _D.border, height: 1),
                  const SizedBox(height: 6),

                  // ---- Menu items ----
                  _DrawerItem(
                    icon: Icons.badge_outlined,
                    title: 'Student Passport',
                    subtitle: 'Academic verification & performance',
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: open Student Passport screen
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.auto_awesome,
                    title: 'AI Tools',
                    subtitle: 'CV Generator & career tools',
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: open AI Tools screen
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.bookmark,
                    title: 'Saved Items',
                    subtitle: 'Saved internships and posts',
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: open Saved Items screen
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.calendar_month,
                    title: 'Events & Hackathons',
                    subtitle: 'Competitions and campus events',
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: open Events screen
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.workspace_premium,
                    title: 'Certificates & Achievements',
                    subtitle: 'Earned certificates and badges',
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: open Certificates screen once you add it:
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (_) => const CertificatesScreen()));
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.settings,
                    title: 'Settings',
                    subtitle: 'Account preferences',
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: open Settings screen
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.help,
                    title: 'Help & Support',
                    subtitle: 'FAQs and contact support',
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: open Help screen
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.shield,
                    title: 'Privacy & Terms',
                    subtitle: 'Policies and legal information',
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: open Privacy screen
                    },
                  ),
                  const SizedBox(height: 6),
                  const Divider(color: _D.border, height: 1),

                  // ---- Logout ----
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: add your logout logic here
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            color: Color(0xFFE53935),
                            size: 24,
                          ),
                          SizedBox(width: 14),
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Color(0xFFE53935),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
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

// ---------------- Colors ----------------

class _D {
  static const primary = Color(0xFF1E63E9);
  static const navy = Color(0xFF0B2E73);
  static const border = Color(0xFFE6EDF8);
  static const textDark = Color(0xFF0F1F3D);
  static const textGrey = Color(0xFF6B7A93);
  static const chipBg = Color(0xFFE3EEFF);
}

// ---------------- Profile header ----------------

class _DrawerProfile extends StatelessWidget {
  const _DrawerProfile();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        // Replace with: CircleAvatar(radius: 30, backgroundImage: AssetImage('assets/profile.jpg'))
        CircleAvatar(
          radius: 30,
          backgroundColor: Color(0xFF1E88E5),
          child: Icon(Icons.person, color: Colors.white, size: 34),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      'Aarav Sharma',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: _D.textDark,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.verified_outlined, color: _D.primary, size: 17),
                ],
              ),
              SizedBox(height: 2),
              Text(
                'B.Tech CSE · LPU',
                style: TextStyle(color: _D.textGrey, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------- Menu item ----------------

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final VoidCallback onTap;
  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        child: Row(
          children: [
            SizedBox(width: 34, child: Icon(icon, color: _D.navy, size: 26)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600,
                      color: _D.textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: _D.textGrey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: _D.textGrey, size: 22),
          ],
        ),
      ),
    );
  }
}
