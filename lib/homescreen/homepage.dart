import 'package:Cradix/homescreen/chat_screen.dart';
import 'package:Cradix/homescreen/cradix_drawer.dart';
import 'package:Cradix/homescreen/feed_content.dart';
import 'package:Cradix/homescreen/screens/campus_feed_screen.dart';
import 'package:Cradix/homescreen/screens/cover_letter_screen.dart';
import 'package:Cradix/homescreen/screens/create_post_screen.dart';
import 'package:Cradix/homescreen/screens/explore_screen.dart';
import 'package:Cradix/homescreen/screens/hackathon_buddy_screen.dart';
import 'package:Cradix/homescreen/screens/internship_screen.dart';
import 'package:Cradix/homescreen/screens/notifications_screen.dart';
import 'package:Cradix/homescreen/screens/profile_screen.dart';
import 'package:Cradix/homescreen/screens/profile_strength_screen.dart';
import 'package:Cradix/homescreen/screens/search_screen.dart';
import 'package:Cradix/homescreen/screens/student_passport_screen.dart';
import 'package:flutter/material.dart';

/// Usage:
/// Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _feedTab = 0; // For You / Campus / Companies
  int _navIndex = 0; // Home / Jobs / Chat / Profile

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      // Side drawer (hamburger menu) lives in cradix_drawer.dart
      drawer: const CradixDrawer(),
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _TopBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
                children: [
                  const _PassportCard(),
                  const SizedBox(height: 14),
                  const _CareerPulseCard(),
                  const SizedBox(height: 18),
                  const _QuickHub(),
                  const SizedBox(height: 18),
                  const _SectionTitle(
                    icon: Icons.groups_outlined,
                    title: 'Campus & Community Feed',
                  ),
                  const SizedBox(height: 12),
                  _FeedTabs(
                    selected: _feedTab,
                    onChanged: (i) => setState(() => _feedTab = i),
                  ),
                  const SizedBox(height: 12),
                  _feedTab == 0
                      ? const _PostCard()
                      : FeedContent(tab: _feedTab),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePostScreen()),
          );
        },
        backgroundColor: _C.primary,
        foregroundColor: Colors.white,
        elevation: 6,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _BottomBar(
        index: _navIndex,
        onChanged: (i) => setState(() => _navIndex = i),
      ),
    );
  }
}

// ---------------- Colors & helpers ----------------

class _C {
  static const primary = Color(0xFF1E63E9);
  static const bg = Color(0xFFF5F8FE);
  static const border = Color(0xFFE6EDF8);
  static const textDark = Color(0xFF0F1F3D);
  static const textGrey = Color(0xFF6B7A93);
  static const chipBg = Color(0xFFE3EEFF);
  static const green = Color(0xFF2FB36B);
}

BoxDecoration _cardDecoration({Color color = Colors.white}) => BoxDecoration(
  color: color,
  borderRadius: BorderRadius.circular(16),
  border: Border.all(color: _C.border),
  boxShadow: [
    BoxShadow(
      color: const Color(0xFF1E63E9).withOpacity(0.06),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ],
);

// ---------------- Top bar ----------------

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      child: Row(
        children: [
          // Menu button: opens the side drawer
          // Profile picture: tap it to open the side drawer
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              // Replace child with Image.asset / NetworkImage for a real photo
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: _C.primary,
                ),
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFFFFD9B8),
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SearchScreen()));
            },
            icon: const Icon(Icons.search, color: _C.textDark, size: 26),
          ), // IconButton
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
                  color: _C.textDark,
                  size: 26,
                ),
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF3B30),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------- Verified Student Passport ----------------
class _PassportCard extends StatelessWidget {
  const _PassportCard();

  // Opens your Student Passport Review page
  void _openReview(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const StudentPassportScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // GestureDetector = the whole card is tappable
    return GestureDetector(
      onTap: () => _openReview(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [Color(0xFF1148C4), Color(0xFF2B7BF2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: _C.primary.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Verified Student Passport',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(
                            Icons.verified_outlined,
                            color: Color(0xFF7DF0B5),
                            size: 18,
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Your academic & professional identity, verified.',
                        style: TextStyle(
                          color: Color(0xFFD5E4FF),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white54),
                  ),
                  child: const Text(
                    'Tier-1\nDuties',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      height: 1.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.14),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: _PassportStat(
                        icon: Icons.school_outlined,
                        label: 'CGPA',
                        value: '8.82',
                      ),
                    ),
                    _StatDivider(),
                    Expanded(
                      child: _PassportStat(
                        icon: Icons.event_available_outlined,
                        label: 'Attendance',
                        value: '92.4%',
                      ),
                    ),
                    _StatDivider(),
                    Expanded(
                      child: _PassportStat(
                        icon: Icons.track_changes_outlined,
                        label: 'Portfolio',
                        value: '12.4K',
                      ),
                    ),
                    _StatDivider(),
                    Expanded(
                      child: _PassportStat(
                        icon: Icons.emoji_events_outlined,
                        label: 'Post Ranking',
                        value: '84',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E3C9E).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF7DF0B5)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Color(0xFF7DF0B5),
                        size: 15,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Verified by TPO',
                        style: TextStyle(
                          color: Color(0xFFB7F7D6),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => _openReview(context),
                  child: const Row(
                    children: [
                      Text(
                        'Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      Icon(Icons.chevron_right, color: Colors.white, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) =>
      Container(width: 1, color: Colors.white24);
}

class _PassportStat extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _PassportStat({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white70, size: 18),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Color(0xFFD5E4FF), fontSize: 11),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// ---------------- Career Pulse ----------------
class _CareerPulseCard extends StatelessWidget {
  const _CareerPulseCard();

  // Opens the Profile Strength screen
  void _openProfileStrength(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileStrengthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _openProfileStrength(context),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: _cardDecoration(),
        child: Row(
          children: [
            SizedBox(
              width: 54,
              height: 54,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // (strokeCap removed: not available in Flutter 3.13.2)
                  const CircularProgressIndicator(
                    value: 0.86,
                    strokeWidth: 5,
                    backgroundColor: _C.chipBg,
                    valueColor: AlwaysStoppedAnimation(_C.primary),
                  ),
                  const Center(
                    child: Text(
                      '86%',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: _C.textDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.trending_up, size: 15, color: _C.primary),
                      SizedBox(width: 4),
                      Text(
                        'Career Pulse',
                        style: TextStyle(
                          color: _C.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Profile Strength',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: _C.textDark,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '4 Matching Internships · 2 Views',
                    style: TextStyle(color: _C.textGrey, fontSize: 12),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => _openProfileStrength(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: _C.chipBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.north_east_rounded,
                  color: _C.primary,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Quick Hub ----------------

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final bool showSeeAll;
  const _SectionTitle({
    required this.icon,
    required this.title,
    this.iconColor = _C.primary,
    this.showSeeAll = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: _C.textDark,
          ),
        ),
        const Spacer(),
        if (showSeeAll)
          InkWell(
            onTap: () {},
            child: const Row(
              children: [
                Text(
                  'See All',
                  style: TextStyle(
                    color: _C.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                Icon(Icons.chevron_right, color: _C.primary, size: 18),
              ],
            ),
          ),
      ],
    );
  }
}

class _QuickItem {
  final String label;
  final IconData icon;
  final Color color;
  final bool highlighted;
  const _QuickItem(
    this.label,
    this.icon,
    this.color, {
    this.highlighted = false,
  });
}

class _QuickHub extends StatelessWidget {
  const _QuickHub();

  static const _items = [
    _QuickItem(
      'Hackathon\nBuddy',
      Icons.emoji_events_rounded,
      Color(0xFFF59E0B),
    ),
    _QuickItem('Internships', Icons.work_rounded, Color(0xFF1E88E5)),
    _QuickItem('Campus\nFeed', Icons.chat_bubble_rounded, Color(0xFFFBBF24)),
    _QuickItem(
      'Cover Letter Generator',
      Icons.auto_awesome_rounded,
      Color(0xFF3B5BFF),
      highlighted: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SectionTitle(
          icon: Icons.bolt_rounded,
          title: 'Quick Hub',
          iconColor: Color(0xFFF59E0B),
          showSeeAll: true,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            for (int i = 0; i < _items.length; i++) ...[
              Expanded(child: _QuickTile(item: _items[i])),
              if (i != _items.length - 1) const SizedBox(width: 10),
            ],
          ],
        ),
      ],
    );
  }
}

class _QuickTile extends StatelessWidget {
  final _QuickItem item;
  const _QuickTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (item.label.startsWith('Hackathon')) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HackathonBuddyScreen()),
          );
        } else if (item.label == 'Internships') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const InternshipsScreen()),
          );
        } else if (item.label.startsWith('Campus')) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CampusFeedScreen()),
          );
        } else if (item.label.contains('Cover Letter')) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CoverLetterScreen()),
          );
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 120,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        decoration: _cardDecoration(
          color: item.highlighted ? const Color(0xFFEAF0FF) : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: item.highlighted
                    ? item.color
                    : item.color.withOpacity(0.14),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                item.icon,
                color: item.highlighted ? Colors.white : item.color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11.5,
                height: 1.2,
                fontWeight: FontWeight.w500,
                color: _C.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Feed tabs ----------------

class _FeedTabs extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;
  const _FeedTabs({required this.selected, required this.onChanged});

  static const _tabs = ['For You', 'Campus', 'Companies'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < _tabs.length; i++)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onChanged(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: selected == i ? _C.textDark : Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: selected == i ? _C.textDark : _C.border,
                  ),
                ),
                child: Text(
                  _tabs[i],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: selected == i ? Colors.white : _C.textGrey,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ---------------- Post card ----------------

class _PostCard extends StatelessWidget {
  const _PostCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFF1E88E5),
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Aarav Sharma',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: _C.textDark,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.verified, color: _C.primary, size: 15),
                      ],
                    ),
                    Text(
                      'B.Tech CSE · LPU',
                      style: TextStyle(color: _C.textGrey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: _C.chipBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Student Post',
                  style: TextStyle(
                    color: _C.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Just completed my Web development project \'EventEase\'. '
            'Built with React, Node.js and MongoDB with instant QR '
            'admission verification!',
            style: TextStyle(fontSize: 13.5, height: 1.4, color: _C.textDark),
          ),
          const SizedBox(height: 12),
          // Replace with: ClipRRect(child: Image.asset('assets/post.png'))
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 150,
              width: double.infinity,
              color: const Color(0xFF0F172A),
              child: const Icon(
                Icons.code_rounded,
                color: Color(0xFF38BDF8),
                size: 56,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Bottom navigation ----------------

class _BottomBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  const _BottomBar({required this.index, required this.onChanged});

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
                icon: Icons.home_rounded,
                label: 'Home',
                active: index == 0,
                onTap: () => onChanged(0),
              ),
            ),
            Expanded(
              child: _NavItem(
                icon: Icons.explore_outlined,
                label: 'Explore',
                active: index == 1,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ExploreScreen()),
                ),
              ),
            ),
            const SizedBox(width: 64), // space for the FAB notch
            Expanded(
              child: _NavItem(
                icon: Icons.chat_bubble_outline,
                label: 'Chat',
                badge: 3,
                active: index == 2,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChatScreen()),
                ),
              ),
            ),
            Expanded(
              child: _NavItem(
                icon: Icons.person_outline,
                label: 'Profile',
                active: index == 3,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                ),
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
    final color = active ? _C.primary : _C.textGrey;
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
