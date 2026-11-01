import 'package:Cradix/homescreen/screens/ai_tools_screen.dart';
import 'package:Cradix/homescreen/screens/certificates_screen.dart';
import 'package:Cradix/homescreen/screens/edit_profile_screen.dart';
import 'package:Cradix/homescreen/screens/hackathon_buddy_screen.dart';
import 'package:Cradix/homescreen/screens/help_support_screen.dart';
import 'package:Cradix/homescreen/screens/privacy_terms_screen.dart';
import 'package:Cradix/homescreen/screens/saved_items_screen.dart';
import 'package:Cradix/homescreen/screens/student_passport_screen.dart';
import 'package:Cradix/homescreen/settings_screen.dart';
import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _textDark = Color(0xFF0F1F3D);
const Color _textGrey = Color(0xFF6B7A93);
const Color _line = Color(0xFFE6EDF8);
const Color _red = Color(0xFFE5365B);

/// The side menu (hamburger menu).
/// Usage inside a Scaffold:  drawer: const CradixDrawer(),
class CradixDrawer extends StatelessWidget {
  const CradixDrawer({super.key});

  // Closes the drawer, then opens the page.
  void _go(BuildContext context, Widget page) {
    final NavigatorState navigator = Navigator.of(context);
    navigator.pop();
    navigator.push(MaterialPageRoute(builder: (_) => page));
  }

  // Closes the drawer only (used for items that have no page yet).
  void _closeOnly(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _confirmLogout(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text('Logout'),
          content: const Text(
            'Are you sure you want to sign out of your account?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                // TODO: sign the user out and go to the login screen
              },
              child: const Text('Logout', style: TextStyle(color: _red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      backgroundColor: Colors.white,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 16),
          children: [
            _DrawerHeader(onClose: () => Navigator.of(context).pop()),
            // "Edit My Profile" highlighted row
            _EditProfileRow(
              onTap: () => _go(context, const EditProfileScreen()),
            ),
            const _Divider(),
            _DrawerItem(
              icon: Icons.badge_outlined,
              title: 'Student Passport',
              subtitle: 'Academic verification & performance',
              onTap: () => _go(context, const StudentPassportScreen()),
            ),
            _DrawerItem(
              icon: Icons.auto_awesome,
              title: 'AI Tools',
              subtitle: 'CV Generator & career tools',
              onTap: () {
                Navigator.pop(context); // close the drawer first
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AiToolsScreen()),
                );
              },
            ),
            _DrawerItem(
              icon: Icons.bookmark,
              title: 'Saved Items',
              subtitle: 'Saved internships and posts',
              onTap: () {
                Navigator.pop(context); // close the drawer first
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SavedItemsScreen()),
                );
              },
            ),
            _DrawerItem(
              icon: Icons.calendar_month_outlined,
              title: 'Events & Hackathons',
              subtitle: 'Competitions and campus events',
              onTap: () => _go(context, const HackathonBuddyScreen()),
            ),
            _DrawerItem(
              icon: Icons.workspace_premium,
              title: 'Certificates & Achievements',
              subtitle: 'Earned certificates and badges',
              onTap: () => _go(context, const CertificatesScreen()),
            ),
            _DrawerItem(
              icon: Icons.settings,
              title: 'Settings',
              subtitle: 'Account preferences',
              onTap: () => _go(context, const SettingsScreen()),
            ),
            _DrawerItem(
              icon: Icons.help,
              title: 'Help & Support',
              subtitle: 'FAQs and contact support',
              onTap: () => _go(context, const HelpSupportScreen()),
            ),
            _DrawerItem(
              icon: Icons.shield,
              title: 'Privacy & Terms',
              subtitle: 'Policies and legal information',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrivacyTermsScreen()),
                );
              },
            ),
            // New drawer items go here. Copy one _DrawerItem block above,
            // change the icon, title, subtitle and the page name.
            const _Divider(),
            InkWell(
              onTap: () => _confirmLogout(context),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    Icon(Icons.logout, color: _red, size: 22),
                    SizedBox(width: 16),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: _red,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
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

class _DrawerHeader extends StatelessWidget {
  final VoidCallback onClose;

  const _DrawerHeader({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 8, 16),
      child: Row(
        children: [
          // Replace the Icon with your photo:
          // CircleAvatar(radius: 24, backgroundImage: AssetImage('assets/images/profile.png'))
          const CircleAvatar(
            radius: 24,
            backgroundColor: Color(0xFFE3EEFF),
            child: Icon(Icons.person_rounded, color: _blue, size: 28),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Pranav Kabdal',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: _textDark,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.verified, color: _blue, size: 16),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  'B.Tech CSE • Graphic Era Hill University',
                  style: TextStyle(color: _textGrey, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: _navy),
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}

class _EditProfileRow extends StatelessWidget {
  final VoidCallback onTap;

  const _EditProfileRow({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: const Color(0xFFE8F0FE),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                Icon(Icons.manage_accounts, color: _blue, size: 22),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Edit My Profile',
                    style: TextStyle(
                      color: _blue,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Icon(Icons.chevron_right, color: _blue, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Divider(height: 1, color: _line),
    );
  }
}

// One row of the side drawer
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
        child: Row(
          children: [
            Icon(icon, color: _navy, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _textDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: _textGrey, fontSize: 11.5),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right, color: _textGrey, size: 20),
          ],
        ),
      ),
    );
  }
}
