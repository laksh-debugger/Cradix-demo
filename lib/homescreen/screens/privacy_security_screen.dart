import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);
const Color _red = Color(0xFFE53935);

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  bool _twoFactor = false;
  bool _loginAlerts = true;
  bool _showEmail = false;
  bool _showPhone = false;
  bool _recruiterSearch = true;
  String _visibility = 'Campus only';

  void _pickVisibility() {
    const options = ['Everyone', 'Campus only', 'Recruiters only', 'Only me'];
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Who can see my profile',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A2233),
                  ),
                ),
                const SizedBox(height: 8),
                for (final option in options)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(option),
                    trailing: option == _visibility
                        ? const Icon(Icons.check_circle, color: _blue)
                        : const Icon(
                            Icons.circle_outlined,
                            color: Color(0xFFB0B8C8),
                          ),
                    onTap: () {
                      setState(() => _visibility = option);
                      Navigator.pop(sheetContext);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmDelete() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text('Delete account?'),
          content: const Text(
            'This will permanently remove your profile, certificates and saved items. This cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                // TODO: delete the account (needs backend / Firebase)
              },
              child: const Text('Delete', style: TextStyle(color: _red)),
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
      body: Column(
        children: [
          _Header(onBack: () => Navigator.pop(context)),
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
                    const _SectionTitle('Account Security'),
                    _Card(
                      children: [
                        _NavTile(
                          icon: Icons.lock_outline,
                          iconColor: _blue,
                          iconBg: const Color(0xFFE3F0FF),
                          title: 'Change Password',
                          subtitle: 'Update your password regularly',
                          onTap: () {
                            // TODO: open Change Password screen
                          },
                        ),
                        const _Divider(),
                        _SwitchTile(
                          icon: Icons.shield_outlined,
                          iconColor: const Color(0xFF7C4DFF),
                          iconBg: const Color(0xFFEDE7FF),
                          title: 'Two-Factor Authentication',
                          subtitle: 'Extra security when you log in',
                          value: _twoFactor,
                          onChanged: (v) => setState(() => _twoFactor = v),
                        ),
                        const _Divider(),
                        _SwitchTile(
                          icon: Icons.notifications_active_outlined,
                          iconColor: const Color(0xFF16A36A),
                          iconBg: const Color(0xFFE0F6EC),
                          title: 'Login Alerts',
                          subtitle: 'Get notified of new sign-ins',
                          value: _loginAlerts,
                          onChanged: (v) => setState(() => _loginAlerts = v),
                        ),
                        const _Divider(),
                        _NavTile(
                          icon: Icons.devices_outlined,
                          iconColor: const Color(0xFFF59E0B),
                          iconBg: const Color(0xFFFFF3DC),
                          title: 'Active Sessions',
                          subtitle: 'Devices logged in to your account',
                          onTap: () {
                            // TODO: open Active Sessions screen
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    const _SectionTitle('Profile Privacy'),
                    _Card(
                      children: [
                        _NavTile(
                          icon: Icons.visibility_outlined,
                          iconColor: _blue,
                          iconBg: const Color(0xFFE3F0FF),
                          title: 'Profile Visibility',
                          subtitle: _visibility,
                          onTap: _pickVisibility,
                        ),
                        const _Divider(),
                        _SwitchTile(
                          icon: Icons.email_outlined,
                          iconColor: _blue,
                          iconBg: const Color(0xFFE3F0FF),
                          title: 'Show Email',
                          subtitle: 'Visible on your public profile',
                          value: _showEmail,
                          onChanged: (v) => setState(() => _showEmail = v),
                        ),
                        const _Divider(),
                        _SwitchTile(
                          icon: Icons.phone_outlined,
                          iconColor: _blue,
                          iconBg: const Color(0xFFE3F0FF),
                          title: 'Show Phone Number',
                          subtitle: 'Visible on your public profile',
                          value: _showPhone,
                          onChanged: (v) => setState(() => _showPhone = v),
                        ),
                        const _Divider(),
                        _SwitchTile(
                          icon: Icons.business_center_outlined,
                          iconColor: const Color(0xFF16A36A),
                          iconBg: const Color(0xFFE0F6EC),
                          title: 'Appear in Recruiter Search',
                          subtitle: 'Let companies find your profile',
                          value: _recruiterSearch,
                          onChanged: (v) =>
                              setState(() => _recruiterSearch = v),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    const _SectionTitle('Your Data'),
                    _Card(
                      children: [
                        _NavTile(
                          icon: Icons.download_outlined,
                          iconColor: _blue,
                          iconBg: const Color(0xFFE3F0FF),
                          title: 'Download My Data',
                          subtitle: 'Get a copy of your information',
                          onTap: () {
                            // TODO: request data download
                          },
                        ),
                        const _Divider(),
                        _NavTile(
                          icon: Icons.delete_outline,
                          iconColor: _red,
                          iconBg: const Color(0xFFFDE8E8),
                          title: 'Delete Account',
                          titleColor: _red,
                          subtitle: 'Permanently remove your account',
                          onTap: _confirmDelete,
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
  final VoidCallback onBack;
  const _Header({required this.onBack});

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
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Privacy & Security',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Protect your account and data',
                      style: TextStyle(color: Color(0xFFC9D6F2), fontSize: 13),
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
          color: Color(0xFF1A2233),
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

class _TileText extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color titleColor;
  const _TileText({
    required this.title,
    required this.subtitle,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 12.5, color: Color(0xFF6B7488)),
        ),
      ],
    );
  }
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final Color titleColor;
  final VoidCallback onTap;

  const _NavTile({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.titleColor = const Color(0xFF1A2233),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            _IconBox(icon: icon, color: iconColor, bg: iconBg),
            const SizedBox(width: 14),
            Expanded(
              child: _TileText(
                title: title,
                subtitle: subtitle,
                titleColor: titleColor,
              ),
            ),
            const Icon(Icons.chevron_right, color: _blue),
          ],
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          _IconBox(icon: icon, color: iconColor, bg: iconBg),
          const SizedBox(width: 14),
          Expanded(
            child: _TileText(
              title: title,
              subtitle: subtitle,
              titleColor: const Color(0xFF1A2233),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: _blue,
          ),
        ],
      ),
    );
  }
}
