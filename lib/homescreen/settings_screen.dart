import 'package:Cradix/homescreen/screens/about_cradix_screen.dart';
import 'package:Cradix/homescreen/screens/help_support_screen.dart';
import 'package:Cradix/homescreen/screens/notifications_screen.dart';
import 'package:Cradix/homescreen/screens/privacy_security_screen.dart';
import 'package:Cradix/homescreen/screens/review_feedback_screen.dart';
import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);
const Color _textGrey = Color(0xFF6B7A99);
const Color _divider = Color(0xFFE9EEF8);

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _confirmLogout(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text('Log Out'),
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
              child: const Text(
                'Log Out',
                style: TextStyle(color: Color(0xFFE5365B)),
              ),
            ),
          ],
        );
      },
    );
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
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                  children: [
                    const _SectionLabel('Account'),
                    _Group(
                      children: [
                        _SettingsRow(
                          icon: Icons.person_outline,
                          iconColor: const Color(0xFF1E88E5),
                          iconBg: const Color(0xFFE3F2FD),
                          title: 'Personal Information',
                          subtitle: 'Name, email, phone, college details',
                          onTap: () {
                            // TODO: open Personal Information page
                          },
                        ),
                        _SettingsRow(
                          icon: Icons.shield_outlined,
                          iconColor: const Color(0xFF7C4DFF),
                          iconBg: const Color(0xFFEDE7FF),
                          title: 'Privacy & Security',
                          subtitle: 'Password, 2FA, account security',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PrivacySecurityScreen(),
                              ),
                            );
                          },
                        ),
                        _SettingsRow(
                          icon: Icons.notifications_none,
                          iconColor: const Color(0xFF12A769),
                          iconBg: const Color(0xFFE0F5EC),
                          title: 'Notifications',
                          subtitle: 'Event alerts, messages, updates',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const NotificationsScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    const _SectionLabel('App Preferences'),
                    _Group(
                      children: [
                        const _ThemeRow(),
                        _SettingsRow(
                          icon: Icons.language,
                          iconColor: _blue,
                          iconBg: const Color(0xFFE3F2FD),
                          title: 'Language',
                          subtitle: 'English',
                          onTap: () {
                            // TODO: open Language page
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    const _SectionLabel('Support & About'),
                    _Group(
                      children: [
                        _SettingsRow(
                          icon: Icons.headset_mic_outlined,
                          iconColor: _blue,
                          iconBg: const Color(0xFFE3F2FD),
                          title: 'Help & Support',
                          subtitle: 'FAQs, contact us, report a problem',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const HelpSupportScreen(),
                              ),
                            );
                          },
                        ),
                        _SettingsRow(
                          icon: Icons.info_outline,
                          iconColor: const Color(0xFF7C4DFF),
                          iconBg: const Color(0xFFEDE7FF),
                          title: 'About CRADIX',
                          subtitle: 'Version 1.0.0',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const AboutCradixScreen(),
                              ),
                            );
                          },
                        ),
                        _SettingsRow(
                          icon: Icons.star,
                          iconColor: const Color(0xFFF5A623),
                          iconBg: const Color(0xFFFFF3DC),
                          title: 'Review & Feedback',
                          subtitle: 'Rate CRADIX or share your suggestions',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const ReviewFeedbackScreen(),
                              ),
                            );
                          },
                        ),
                        _SettingsRow(
                          icon: Icons.logout,
                          iconColor: const Color(0xFFE5365B),
                          iconBg: const Color(0xFFFDE4EA),
                          title: 'Log Out',
                          subtitle: 'Sign out from your account',
                          onTap: () => _confirmLogout(context),
                        ),
                      ],
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
                  'Settings',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Manage your account and app preferences',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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

class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          color: _navy,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// White rounded card that holds several rows with thin dividers between them.
class _Group extends StatelessWidget {
  final List<Widget> children;

  const _Group({required this.children});

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [];
    for (int i = 0; i < children.length; i++) {
      items.add(children[i]);
      if (i != children.length - 1) {
        items.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 1, thickness: 1, color: _divider),
          ),
        );
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEEF2FA)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Material(
          color: Colors.white,
          child: Column(children: items),
        ),
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  const _IconBox({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: iconBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: iconColor, size: 26),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsRow({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            _IconBox(icon: icon, iconColor: iconColor, iconBg: iconBg),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _navy,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: _textGrey, fontSize: 12.5),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right, color: _blue),
          ],
        ),
      ),
    );
  }
}

// Theme row: Light / Dark / System selector.
// The toggle sits under the title (not beside it) so it fits every phone width.
class _ThemeRow extends StatefulWidget {
  const _ThemeRow();

  @override
  State<_ThemeRow> createState() => _ThemeRowState();
}

class _ThemeRowState extends State<_ThemeRow> {
  final List<String> _options = ['Light', 'Dark', 'System'];
  final List<String> _subtitles = ['Light mode', 'Dark mode', 'System default'];
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const _IconBox(
                icon: Icons.dark_mode_outlined,
                iconColor: _blue,
                iconBg: Color(0xFFE3F2FD),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Theme',
                      style: TextStyle(
                        color: _navy,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _subtitles[_selected],
                      style: const TextStyle(color: _textGrey, fontSize: 12.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFE8EFFC),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                for (int i = 0; i < _options.length; i++)
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() => _selected = i);
                        // TODO: really change the app theme (light / dark / system)
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        decoration: BoxDecoration(
                          color: _selected == i ? _blue : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            _options[i],
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: _selected == i ? Colors.white : _textGrey,
                            ),
                          ),
                        ),
                      ),
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
