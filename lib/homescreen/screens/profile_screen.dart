import 'package:Cradix/homescreen/chat_screen.dart';
import 'package:Cradix/homescreen/privacy_settings_screen.dart';
import 'package:Cradix/homescreen/screens/about_me_screen.dart';
import 'package:Cradix/homescreen/screens/ai_profile_review_screen.dart';
import 'package:Cradix/homescreen/screens/ai_tools_screen.dart';
import 'package:Cradix/homescreen/screens/certificates_screen.dart';
import 'package:Cradix/homescreen/screens/courses_screen.dart';
import 'package:Cradix/homescreen/screens/cv_generator_screen.dart';
import 'package:Cradix/homescreen/screens/edit_profile_screen.dart';
import 'package:Cradix/homescreen/screens/education_screen.dart';
import 'package:Cradix/homescreen/screens/experience_screen.dart';
import 'package:Cradix/homescreen/screens/explore_screen.dart';
import 'package:Cradix/homescreen/screens/notifications_screen.dart';
import 'package:Cradix/homescreen/screens/saved_items_screen.dart';
import 'package:Cradix/homescreen/screens/skills_portfolio_screen.dart';
import 'package:Cradix/homescreen/settings_screen.dart';
import 'package:flutter/material.dart';

/// Open it with:
/// Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _P.navy,
      extendBody: true,
      body: Column(
        children: [
          const _Header(),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              child: Container(
                color: _P.bg,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
                  children: const [
                    _ProfileCard(),
                    SizedBox(height: 14),
                    _StrengthCard(),
                    SizedBox(height: 14),
                    _MenuGrid(),
                    SizedBox(height: 4),
                    _CvBanner(),
                    SizedBox(height: 14),
                    _QuickStats(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: _P.primary,
        foregroundColor: Colors.white,
        elevation: 6,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const _ProfileBottomBar(),
    );
  }
}

// ---------------- Colors & helpers ----------------

class _P {
  static const primary = Color(0xFF1E63E9);
  static const navy = Color(0xFF0B2E73);
  static const bg = Color(0xFFF5F8FE);
  static const border = Color(0xFFE6EDF8);
  static const textDark = Color(0xFF0B2A6B);
  static const textGrey = Color(0xFF6B7A93);
  static const chipBg = Color(0xFFE3EEFF);
  static const green = Color(0xFF2FB36B);
  static const orange = Color(0xFFF5A623);
}

BoxDecoration _card() => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(16),
  border: Border.all(color: _P.border),
  boxShadow: [
    BoxShadow(
      color: const Color(0xFF1E63E9).withOpacity(0.06),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ],
);

// ---------------- Header ----------------

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0B3A8C), Color(0xFF0B2E73)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 8, 22),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Your journey. Your profile. Your future.',
                      style: TextStyle(
                        color: Color(0xFFD5E2FA),
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
                icon: const Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const NotificationsScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF3B30),
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- Profile card ----------------

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _card(),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Replace the CircleAvatar child with: backgroundImage: AssetImage('assets/profile.jpg')
              SizedBox(
                width: 88,
                height: 88,
                child: Stack(
                  children: [
                    Container(
                      width: 84,
                      height: 84,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _P.primary.withOpacity(0.35),
                          width: 2,
                        ),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: Color(0xFF1E88E5),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 46,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 2,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: _P.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 14,
                        ),
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
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Pranav Kabdal',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: _P.textDark,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          customBorder: const CircleBorder(),
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: const BoxDecoration(
                              color: _P.chipBg,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.share_outlined,
                              color: _P.primary,
                              size: 19,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      '@pranavk',
                      style: TextStyle(color: _P.textGrey, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    const _InfoRow(
                      icon: Icons.school,
                      text: 'Graphic Era Hill University',
                      bold: true,
                    ),
                    const _InfoRow(
                      icon: Icons.computer,
                      text: 'B.Tech Computer Science & Engineering',
                    ),
                    const _InfoRow(
                      icon: Icons.location_on,
                      text: 'Dehradun, Uttarakhand  ·  3rd Year',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.edit, size: 16),
              label: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _P.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 12,
                ),
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool bold;
  const _InfoRow({required this.icon, required this.text, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 15, color: _P.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.5,
                height: 1.2,
                color: bold ? _P.textDark : _P.textGrey,
                fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Profile strength ----------------

class _StrengthCard extends StatelessWidget {
  const _StrengthCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _card(),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 88,
                height: 88,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const CircularProgressIndicator(
                      value: 0.75,
                      strokeWidth: 8,
                      backgroundColor: _P.chipBg,
                      valueColor: AlwaysStoppedAnimation(_P.primary),
                    ),
                    const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '75%',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: _P.textDark,
                            ),
                          ),
                          Text(
                            'Profile Complete',
                            style: TextStyle(fontSize: 8.5, color: _P.textGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Profile Strength',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _P.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: const LinearProgressIndicator(
                        value: 0.75,
                        minHeight: 8,
                        backgroundColor: _P.chipBg,
                        valueColor: AlwaysStoppedAnimation(_P.primary),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              _CheckItem('Personal Information'),
                              _CheckItem('Education'),
                              _CheckItem('Projects & Portfolio'),
                              _CheckItem('Courses'),
                            ],
                          ),
                        ),
                        SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            children: [
                              _CheckItem('Experience'),
                              _CheckItem('Certificates & Achievements'),
                              _CheckItem('AI Profile Review', done: false),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome, color: _P.primary, size: 24),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Complete your profile to get better opportunities!',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: _P.textDark,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _P.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Update Profile',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, size: 14),
                    ],
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

class _CheckItem extends StatelessWidget {
  final String text;
  final bool done;
  const _CheckItem(this.text, {this.done = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            done ? Icons.check_circle : Icons.error,
            size: 16,
            color: done ? _P.green : _P.orange,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 11,
                height: 1.2,
                color: _P.textGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Menu grid ----------------

class _Menu {
  final String title, sub;
  final IconData icon;
  final Color color;
  const _Menu(this.title, this.sub, this.icon, this.color);
}

class _MenuGrid extends StatelessWidget {
  const _MenuGrid();

  static const _items = [
    _Menu(
      'About Me',
      'Introduction and career goals',
      Icons.person,
      Color(0xFF1E63E9),
    ),
    _Menu(
      'Education',
      'College and academic details',
      Icons.school_rounded,
      Color(0xFF14A38B),
    ),
    _Menu(
      'Skills, Projects and Portfolio',
      'Technical skills, projects and your work',
      Icons.code_rounded,
      Color(0xFF7E57C2),
    ),
    _Menu(
      'Certificates & Achievements',
      'Courses, awards and wins',
      Icons.workspace_premium,
      Color(0xFF1E63E9),
    ),
    _Menu(
      'Experience',
      'Internships and work history',
      Icons.work_rounded,
      Color(0xFF1E63E9),
    ),
    _Menu(
      'Courses',
      'Enrolled and completed courses',
      Icons.menu_book_rounded,
      Color(0xFF7E3FE4),
    ),
    _Menu(
      'Saved Items',
      'Your saved opportunities',
      Icons.bookmark,
      Color(0xFF1E63E9),
    ),
    _Menu(
      'Privacy & Settings',
      'Visibility and account controls',
      Icons.shield,
      Color(0xFF1E63E9),
    ),
    _Menu(
      'AI Profile Review',
      'Get personalized suggestions',
      Icons.auto_awesome,
      Color(0xFF7E3FE4),
    ),
    _Menu(
      'AI Tools',
      'Use AI to learn, build and grow',
      Icons.smart_toy,
      Color(0xFF1E63E9),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < _items.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _MenuCard(item: _items[i])),
                  const SizedBox(width: 10),
                  Expanded(child: _MenuCard(item: _items[i + 1])),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

// Opens the right page for each menu card.
// To connect a new card: add one more "case" below.
void _openMenuScreen(BuildContext context, String title) {
  Widget? screen;
  switch (title) {
    case 'About Me':
      screen = const AboutMeScreen();
      break;
    case 'Education':
      screen = const EducationScreen();
      break;
    case 'Skills, Projects and Portfolio':
      screen = const SkillsPortfolioScreen();
      break;
    case 'Certificates & Achievements':
      screen = const CertificatesScreen();
      break;
    case 'Experience':
      screen = const ExperienceScreen();
      break;
    case 'Courses':
      screen = const CoursesScreen();
      break;
    case 'Saved Items':
      screen = const SavedItemsScreen();
      break;
    case 'Privacy & Settings':
      screen = const PrivacySettingsScreen();
      break;
    case 'AI Profile Review':
      screen = const AiProfileReviewScreen();
      break;
    case 'AI Tools':
      screen = const AiToolsScreen();
      break;
    // TODO: add the other cards here, one by one
  }
  if (screen == null) return;
  final Widget target = screen;
  Navigator.push(context, MaterialPageRoute(builder: (context) => target));
}

class _MenuCard extends StatelessWidget {
  final _Menu item;
  const _MenuCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openMenuScreen(context, item.title),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: _card(),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.14),
                shape: BoxShape.circle,
              ),
              child: Icon(item.icon, color: item.color, size: 22),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.2,
                      fontWeight: FontWeight.w700,
                      color: _P.textDark,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.sub,
                    style: const TextStyle(
                      fontSize: 10.5,
                      height: 1.25,
                      color: _P.textGrey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: _P.primary, size: 20),
          ],
        ),
      ),
    );
  }
}

// ---------------- Generate CV ----------------

class _CvBanner extends StatelessWidget {
  const _CvBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFDCE9FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF1E88E5), Color(0xFF1E63E9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Icon(
              Icons.description_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Generate My CV',
                  style: TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                    color: _P.textDark,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Create a professional resume with AI and download instantly.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.25,
                    color: _P.textGrey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CvGeneratorScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _P.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_awesome, size: 14),
                SizedBox(width: 4),
                Text(
                  'Generate CV',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Quick stats ----------------

class _Stat {
  final String value, label;
  final IconData icon;
  final Color color;
  const _Stat(this.value, this.label, this.icon, this.color);
}

class _QuickStats extends StatelessWidget {
  const _QuickStats();

  static const _stats = [
    _Stat('12', 'Jobs\nApplied', Icons.work_rounded, Color(0xFF1E63E9)),
    _Stat('8', 'Internships\nApplied', Icons.school_rounded, Color(0xFF14A38B)),
    _Stat(
      '4',
      'Hackathons\nJoined',
      Icons.emoji_events_rounded,
      Color(0xFF7E3FE4),
    ),
    _Stat(
      '3',
      'Courses\nCompleted',
      Icons.menu_book_rounded,
      Color(0xFF7E3FE4),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _card(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart_rounded, color: _P.primary, size: 22),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Quick Stats',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _P.textDark,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Row(
                  children: [
                    Text(
                      'View Details',
                      style: TextStyle(
                        color: _P.primary,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward, color: _P.primary, size: 15),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int i = 0; i < _stats.length; i++) ...[
                  Expanded(child: _StatItem(stat: _stats[i])),
                  if (i != _stats.length - 1)
                    const VerticalDivider(
                      color: _P.border,
                      width: 1,
                      thickness: 1,
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final _Stat stat;
  const _StatItem({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: stat.color.withOpacity(0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(stat.icon, color: stat.color, size: 19),
          ),
          const SizedBox(height: 8),
          Text(
            stat.value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: _P.textDark,
            ),
          ),
          Text(
            stat.label,
            style: const TextStyle(
              fontSize: 10.5,
              height: 1.2,
              color: _P.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Bottom navigation ----------------

class _ProfileBottomBar extends StatelessWidget {
  const _ProfileBottomBar();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: 64,
        child: Row(
          children: [
            Expanded(
              child: _NavItem(
                icon: Icons.home_outlined,
                label: 'Home',
                // Go all the way back to the home screen
                onTap: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
              ),
            ),
            Expanded(
              child: _NavItem(
                icon: Icons.explore_outlined,
                label: 'Explore',
                onTap: () {
                  final nav = Navigator.of(context);
                  nav.popUntil((route) => route.isFirst);
                  nav.push(
                    MaterialPageRoute(builder: (_) => const ExploreScreen()),
                  );
                },
              ),
            ),
            const SizedBox(width: 64), // space for the FAB notch
            Expanded(
              child: _NavItem(
                icon: Icons.chat_bubble_outline,
                label: 'Chat',
                badge: 3,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatScreen()),
                  );
                },
              ),
            ),
            Expanded(
              child: _NavItem(
                icon: Icons.person,
                label: 'Profile',
                active: true,
                onTap: () {},
              ),
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
  final bool active;
  final int badge;
  final VoidCallback onTap;
  const _NavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
    this.badge = 0,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? _P.primary : _P.textGrey;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, color: color, size: 26),
              if (badge > 0)
                Positioned(
                  right: -8,
                  top: -6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF3B30),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$badge',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
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
              fontSize: 12,
              color: color,
              fontWeight: active ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
