import 'package:Cradix/homescreen/screens/certificates_screen.dart';
import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);
const Color _green = Color(0xFF12A769);
const Color _orange = Color(0xFFF59E0B);
const Color _textGrey = Color(0xFF6B7A99);

// Change this number to change the percentage everywhere (0.86 = 86%).
const double _strength = 0.86;

class ProfileStrengthScreen extends StatelessWidget {
  const ProfileStrengthScreen({super.key});

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
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        children: [
                          const _StrengthCard(),
                          const SizedBox(height: 20),
                          const _SectionTitle(
                            icon: Icons.check,
                            color: _green,
                            title: 'Completed',
                            subtitle:
                                "You've completed these sections. Great job!",
                          ),
                          const SizedBox(height: 12),
                          _SectionTile(
                            item: const _SectionItem(
                              icon: Icons.person_outline,
                              iconColor: Color(0xFF1E88E5),
                              iconBg: Color(0xFFE3F2FD),
                              title: 'Basic Information',
                              subtitle: 'Name, email, phone, location, bio and profile photo',
                              done: true,
                            ),
                            onTap: () {
                              // TODO: open Basic Information page
                            },
                          ),
                          _SectionTile(
                            item: const _SectionItem(
                              icon: Icons.school_outlined,
                              iconColor: Color(0xFF12A769),
                              iconBg: Color(0xFFE0F5EC),
                              title: 'Education Details',
                              subtitle: 'College, degree, branch, graduation year, CGPA',
                              done: true,
                            ),
                            onTap: () {
                              // TODO: open Education Details page
                            },
                          ),
                          _SectionTile(
                            item: const _SectionItem(
                              icon: Icons.code,
                              iconColor: Color(0xFF7C4DFF),
                              iconBg: Color(0xFFEDE7FF),
                              title: 'Skills',
                              subtitle: 'Technical skills, soft skills, proficiency levels',
                              done: true,
                            ),
                            onTap: () {
                              // TODO: open Skills page
                            },
                          ),
                          _SectionTile(
                            item: const _SectionItem(
                              icon: Icons.work_outline,
                              iconColor: Color(0xFFF59E0B),
                              iconBg: Color(0xFFFFF1DB),
                              title: 'Experience',
                              subtitle:
                                  'Internships, work experience, volunteering',
                              done: true,
                            ),
                            onTap: () {
                              // TODO: open Experience page
                            },
                          ),
                          const SizedBox(height: 8),
                          const Divider(height: 1, color: Color(0xFFE6ECF7)),
                          const SizedBox(height: 16),
                          const _SectionTitle(
                            icon: Icons.priority_high,
                            color: _orange,
                            title: 'Needs Attention',
                            subtitle: 'Complete these sections to boost your profile strength.',
                          ),
                          const SizedBox(height: 12),
                          _SectionTile(
                            item: const _SectionItem(
                              icon: Icons.folder_open,
                              iconColor: Color(0xFF1E88E5),
                              iconBg: Color(0xFFE0F2FE),
                              title: 'Projects & Portfolio',
                              subtitle: 'Add your projects, GitHub link, live demos or portfolio',
                              done: false,
                            ),
                            onTap: () {
                              // TODO: open Projects & Portfolio page
                            },
                          ),
                          _SectionTile(
                            item: const _SectionItem(
                              icon: Icons.workspace_premium_outlined,
                              iconColor: Color(0xFF7C4DFF),
                              iconBg: Color(0xFFEDE7FF),
                              title: 'Certifications & Achievements',
                              subtitle:
                                  'Add certificates, hackathon results, awards',
                              done: false,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CertificatesScreen(),
                                ),
                              );
                            },
                          ),
                          _SectionTile(
                            item: const _SectionItem(
                              icon: Icons.description_outlined,
                              iconColor: Color(0xFF1E88E5),
                              iconBg: Color(0xFFE0F2FE),
                              title: 'Resume & Career Preferences',
                              subtitle: 'Upload resume, set preferred roles & work location',
                              done: false,
                            ),
                            onTap: () {
                              // TODO: open Resume & Career Preferences page
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _blue,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {
                            // TODO: open Edit Profile page
                          },
                          icon: const Icon(Icons.edit_outlined),
                          label: const Text(
                            'Update Profile',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const Expanded(
            child: Text(
              'Profile Strength',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          // Replace the Icon with your photo:
          // CircleAvatar(radius: 22, backgroundImage: AssetImage('assets/images/profile.png'))
          const CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xFFFFE0B2),
            child: Icon(Icons.person, color: _navy),
          ),
        ],
      ),
    );
  }
}

class _StrengthCard extends StatelessWidget {
  const _StrengthCard();

  @override
  Widget build(BuildContext context) {
    final int percent = (_strength * 100).round();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE6ECF7)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            height: 110,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 110,
                  height: 110,
                  child: CircularProgressIndicator(
                    value: _strength,
                    strokeWidth: 9,
                    backgroundColor: const Color(0xFFDCE6F7),
                    valueColor: const AlwaysStoppedAnimation<Color>(_blue),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$percent%',
                      style: const TextStyle(
                        color: _navy,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Text(
                      'Complete',
                      style: TextStyle(color: _textGrey, fontSize: 12),
                    ),
                  ],
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
                  'Your Profile Strength',
                  style: TextStyle(
                    color: _navy,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'A stronger profile gets you better opportunities!',
                  style: TextStyle(color: _textGrey, fontSize: 13),
                ),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: _strength,
                    minHeight: 8,
                    backgroundColor: const Color(0xFFDCE6F7),
                    valueColor: const AlwaysStoppedAnimation<Color>(_blue),
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

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const _SectionTitle({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(icon, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: _navy,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40, top: 4),
          child: Text(
            subtitle,
            style: const TextStyle(color: _textGrey, fontSize: 13),
          ),
        ),
      ],
    );
  }
}

class _SectionItem {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final bool done;

  const _SectionItem({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.done,
  });
}

class _SectionTile extends StatelessWidget {
  final _SectionItem item;
  final VoidCallback onTap;

  const _SectionTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEF2FA)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: item.iconBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(item.icon, color: item.iconColor, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
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
                        item.subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: _textGrey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: item.done ? _green : _orange,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item.done ? Icons.check : Icons.priority_high,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const Icon(Icons.chevron_right, color: _textGrey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
