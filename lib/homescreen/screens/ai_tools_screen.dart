import 'package:Cradix/homescreen/screens/career_guidance_screen.dart';
import 'package:Cradix/homescreen/screens/cover_letter_screen.dart';
import 'package:Cradix/homescreen/screens/cv_generator_screen.dart';
import 'package:Cradix/homescreen/screens/explore_screen.dart';
import 'package:Cradix/homescreen/screens/interview_prep_screen.dart';
import 'package:Cradix/homescreen/screens/notifications_screen.dart';
import 'package:Cradix/homescreen/screens/profile_review_screen.dart';
import 'package:Cradix/homescreen/screens/profile_screen.dart';
import 'package:Cradix/homescreen/screens/search_screen.dart';
import 'package:Cradix/homescreen/screens/study_planner_screen.dart';
import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);
const Color _textGrey = Color(0xFF6B7A93);
const Color _red = Color(0xFFE53935);

class _Tool {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color boxColor;

  const _Tool({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.boxColor,
  });
}

const List<_Tool> _tools = [
  _Tool(
    title: 'Career Guidance AI',
    subtitle: 'Get personalized career suggestions and roadmap.',
    icon: Icons.explore_outlined,
    iconColor: Color(0xFF1FA971),
    boxColor: Color(0xFFDFF5EA),
  ),
  _Tool(
    title: 'CV Generator',
    subtitle: 'Create a professional resume in minutes.',
    icon: Icons.description_outlined,
    iconColor: Color(0xFF6C3FE0),
    boxColor: Color(0xFFE9E1FB),
  ),
  _Tool(
    title: 'Cover Letter',
    subtitle: 'Write customized cover letters for your applications.',
    icon: Icons.mail_outline,
    iconColor: Color(0xFFF59E0B),
    boxColor: Color(0xFFFFF0CC),
  ),
  _Tool(
    title: 'Interview Prep',
    subtitle: 'Get mock questions and answers.',
    icon: Icons.groups_outlined,
    iconColor: Color(0xFF2F8BEA),
    boxColor: Color(0xFFDCEBFB),
  ),
  _Tool(
    title: 'Profile Review',
    subtitle: 'Improve your profile and get expert feedback.',
    icon: Icons.how_to_reg_outlined,
    iconColor: Color(0xFFE5486E),
    boxColor: Color(0xFFFFE0E8),
  ),
  _Tool(
    title: 'Study Planner',
    subtitle: 'Create a personalized study schedule.',
    icon: Icons.calendar_month_outlined,
    iconColor: Color(0xFF6C3FE0),
    boxColor: Color(0xFFE9E1FB),
  ),
];

class AiToolsScreen extends StatelessWidget {
  const AiToolsScreen({super.key});

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
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                    children: [
                      const _AssistantBanner(),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'AI Tools',
                              style: TextStyle(
                                color: _navy,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // TODO: open the full list of AI tools
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'View All',
                                    style: TextStyle(
                                      color: _blue,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.5,
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: _blue,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      for (final _Tool t in _tools) ...[
                        _ToolCard(
                          icon: t.icon,
                          iconColor: t.iconColor,
                          boxColor: t.boxColor,
                          title: t.title,
                          subtitle: t.subtitle,
                          onTap: () {
                            if (t.title == 'Career Guidance AI') {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const CareerGuidanceScreen(),
                                ),
                              );
                            } else if (t.title == 'CV Generator') {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const CvGeneratorScreen(),
                                ),
                              );
                            } else if (t.title == 'Cover Letter') {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const CoverLetterScreen(),
                                ),
                              );
                            } else if (t.title == 'Interview Prep') {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const InterviewPrepScreen(),
                                ),
                              );
                            } else if (t.title == 'Profile Review') {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const ProfileReviewScreen(),
                                ),
                              );
                            } else if (t.title == 'Study Planner') {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const StudyPlannerScreen(),
                                ),
                              );
                            } else {
                              // TODO: open the ${t.title} page
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                      ],
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Recent Tools',
                              style: TextStyle(
                                color: _navy,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // TODO: clear the recent tools list
                            },
                            child: const Text(
                              'Clear',
                              style: TextStyle(
                                color: _blue,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      _ToolCard(
                        icon: Icons.description_outlined,
                        iconColor: const Color(0xFF6C3FE0),
                        boxColor: const Color(0xFFE9E1FB),
                        title: 'CV Generator',
                        subtitle: 'Used 2 days ago',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const CvGeneratorScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: _blue,
        shape: const CircleBorder(),
        onPressed: () {
          // TODO: open the "+" create page
        },
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        padding: EdgeInsets.zero,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              Expanded(
                child: _BottomItem(
                  icon: Icons.home_outlined,
                  label: 'Home',
                  onTap: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ),
              Expanded(
                child: _BottomItem(
                  icon: Icons.explore_outlined,
                  label: 'Explore',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ExploreScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 72),
              Expanded(
                child: _BottomItem(
                  icon: Icons.chat_bubble_outline,
                  label: 'Chat',
                  badge: 2,
                  onTap: () {
                    // TODO: open the Chats screen
                  },
                ),
              ),
              Expanded(
                child: _BottomItem(
                  icon: Icons.person_outline,
                  label: 'Profile',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
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
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
      child: Row(
        children: [
          // Replace this circle with the user photo:
          // Image.asset('assets/images/user.png')
          Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: _blue,
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              backgroundColor: Color(0xFFDCE6F8),
              child: Icon(Icons.person, color: _navy, size: 30),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Tools',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Smarter tools for your academic & career journey',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 12.5),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SearchScreen()));
            },
            icon: const Icon(Icons.search, color: Colors.white, size: 28),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 28,
                ),
                Positioned(
                  right: 2,
                  top: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: _red,
                      shape: BoxShape.circle,
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

class _AssistantBanner extends StatelessWidget {
  const _AssistantBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E63E9), Color(0xFF4FA3F7)],
        ),
        boxShadow: [
          BoxShadow(
            color: _blue.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.white, size: 18),
                    SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        'Your AI Assistant',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Ask. Learn. Grow.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Get instant help with your doubts, resume, interview prep and more.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Replace this robot icon with your robot picture:
          // Image.asset('assets/images/robot.png', width: 90)
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.smart_toy, color: Colors.white, size: 52),
          ),
        ],
      ),
    );
  }
}

class _ToolCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color boxColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ToolCard({
    required this.icon,
    required this.iconColor,
    required this.boxColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _navy.withOpacity(0.07),
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
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: boxColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: iconColor, size: 30),
                ),
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
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _textGrey,
                          fontSize: 13,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: _blue, size: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final int? badge;

  const _BottomItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, color: _textGrey, size: 26),
              if (badge != null)
                Positioned(
                  right: -8,
                  top: -6,
                  child: Container(
                    width: 17,
                    height: 17,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: _red,
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: _textGrey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
