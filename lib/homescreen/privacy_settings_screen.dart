import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);
const Color _red = Color(0xFFE5484D);

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  // TODO: load and save these from the real logged-in user later.
  String _visibility = 'Everyone';
  bool _showEmail = false;
  bool _showPhone = false;
  bool _showAcademics = true;
  bool _recruiterSearch = true;
  bool _allowMessages = true;
  bool _showOnline = true;

  static const List<String> _visibilityOptions = [
    'Everyone',
    'Campus only',
    'Only me',
  ];

  static const Map<String, String> _visibilityHelp = {
    'Everyone': 'Students and recruiters can see your profile.',
    'Campus only': 'Only students from your college can see your profile.',
    'Only me': 'Nobody else can see your profile.',
  };

  void _showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _confirmDelete() async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete account?'),
        content: const Text(
          'Your profile, posts and saved items will be removed. '
          'This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: _red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      // TODO: delete the real account (backend / Firebase), then go to login.
      _showMessage('Account deletion is not connected yet');
    }
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
                      'Privacy & Settings',
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
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    20,
                    16,
                    20 + MediaQuery.of(context).padding.bottom,
                  ),
                  child: Column(
                    children: [
                      _buildVisibilityCard(),
                      _buildControlsCard(),
                      _buildAccountCard(),
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

  // ---------------- Profile visibility ----------------

  Widget _buildVisibilityCard() {
    return _SectionCard(
      title: 'Profile Visibility',
      subtitle: 'Choose who can see your profile',
      icon: Icons.visibility_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _visibilityOptions.map((option) {
              final bool selected = _visibility == option;
              return ChoiceChip(
                label: Text(option),
                selected: selected,
                showCheckmark: false,
                onSelected: (_) => setState(() => _visibility = option),
                selectedColor: _blue,
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  color: selected ? Colors.white : _navy,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                side: BorderSide(color: selected ? _blue : Colors.black12),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          Text(
            _visibilityHelp[_visibility] ?? '',
            style: const TextStyle(fontSize: 12.5, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  // ---------------- Privacy controls ----------------

  Widget _buildControlsCard() {
    return _SectionCard(
      title: 'Privacy Controls',
      subtitle: 'Decide what others can see and do',
      icon: Icons.lock_outline,
      child: Column(
        children: [
          _SwitchRow(
            title: 'Show email address',
            subtitle: 'Visible on your profile',
            value: _showEmail,
            onChanged: (v) => setState(() => _showEmail = v),
          ),
          _SwitchRow(
            title: 'Show phone number',
            subtitle: 'Visible on your profile',
            value: _showPhone,
            onChanged: (v) => setState(() => _showPhone = v),
          ),
          _SwitchRow(
            title: 'Show CGPA and attendance',
            subtitle: 'Shown on your Student Passport',
            value: _showAcademics,
            onChanged: (v) => setState(() => _showAcademics = v),
          ),
          _SwitchRow(
            title: 'Appear in recruiter search',
            subtitle: 'Recruiters can find you for opportunities',
            value: _recruiterSearch,
            onChanged: (v) => setState(() => _recruiterSearch = v),
          ),
          _SwitchRow(
            title: 'Allow messages',
            subtitle: 'Other students and recruiters can chat with you',
            value: _allowMessages,
            onChanged: (v) => setState(() => _allowMessages = v),
          ),
          _SwitchRow(
            title: 'Show online status',
            subtitle: 'Let others see when you are active',
            value: _showOnline,
            onChanged: (v) => setState(() => _showOnline = v),
            isLast: true,
          ),
        ],
      ),
    );
  }

  // ---------------- Account ----------------

  Widget _buildAccountCard() {
    return _SectionCard(
      title: 'Account',
      subtitle: 'Manage your account',
      icon: Icons.manage_accounts_outlined,
      child: Column(
        children: [
          _ActionRow(
            icon: Icons.key_outlined,
            title: 'Change password',
            onTap: () {
              // TODO: open the change password screen
            },
          ),
          _ActionRow(
            icon: Icons.block_outlined,
            title: 'Blocked users',
            onTap: () {
              // TODO: open the blocked users screen
            },
          ),
          _ActionRow(
            icon: Icons.download_outlined,
            title: 'Download my data',
            onTap: () {
              // TODO: request a copy of the user's data
              _showMessage('This feature is not connected yet');
            },
          ),
          _ActionRow(
            icon: Icons.delete_outline,
            title: 'Delete account',
            color: _red,
            showArrow: false,
            isLast: true,
            onTap: _confirmDelete,
          ),
        ],
      ),
    );
  }
}

// ---------------- Helper widgets ----------------

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.child,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: _blue, size: 20),
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

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.isLast = false,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: _navy,
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
              const SizedBox(width: 8),
              Switch(value: value, activeColor: _blue, onChanged: onChanged),
            ],
          ),
        ),
        if (!isLast) const Divider(height: 1, color: Color(0xFFE6EDF8)),
      ],
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.title,
    required this.onTap,
    this.color = _navy,
    this.showArrow = true,
    this.isLast = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color color;
  final bool showArrow;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: Row(
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ),
                if (showArrow)
                  const Icon(Icons.chevron_right, color: _blue, size: 20),
              ],
            ),
          ),
        ),
        if (!isLast) const Divider(height: 1, color: Color(0xFFE6EDF8)),
      ],
    );
  }
}
