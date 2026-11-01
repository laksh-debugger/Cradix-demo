import 'package:Cradix/homescreen/screens/campus_companies.dart';
import 'package:Cradix/homescreen/screens/internship_screen.dart';
import 'package:Cradix/homescreen/screens/profile_screen.dart';
import 'package:flutter/material.dart';

// ---------- Colors used on this screen (private to this file) ----------
const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);
const Color _dark = Color(0xFF0F1F3D);
const Color _grey = Color(0xFF6B7A93);
const Color _border = Color(0xFFE6EDF8);
const Color _chipBg = Color(0xFFE3EEFF);
const Color _green = Color(0xFF12A150);

final List<BoxShadow> _softShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.05),
    blurRadius: 10,
    offset: const Offset(0, 3),
  ),
];

BoxDecoration _cardBox({Color color = Colors.white, double radius = 18}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: _border),
    boxShadow: _softShadow,
  );
}

// =====================================================================
//                         CAMPUS FEED SCREEN
// =====================================================================
class CampusFeedScreen extends StatefulWidget {
  const CampusFeedScreen({super.key});

  @override
  State<CampusFeedScreen> createState() => _CampusFeedScreenState();
}

class _CampusFeedScreenState extends State<CampusFeedScreen> {
  int _tab = 0; // For You / Campus / Companies
  int _sub = 0; // All / Events / News / Community

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Column(
        children: [
          const _Header(),
          Expanded(
            child: Container(
              color: _navy,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(26),
                ),
                child: Container(
                  color: const Color(0xFFF7F9FE),
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(14, 14, 14, 28),
                    children: [
                      _SearchRow(
                        hint: _tab == 2
                            ? 'Search companies, events, jobs, internships...'
                            : 'Search posts, events, news, people...',
                      ),
                      const SizedBox(height: 14),
                      _TopTabs(
                        selected: _tab,
                        onSelected: (i) => setState(() {
                          _tab = i;
                          _sub = 0;
                        }),
                      ),
                      const SizedBox(height: 10),
                      _SubFilters(
                        items: _tab == 2
                            ? const [
                                'All',
                                'Hiring',
                                'Events',
                                'Webinars',
                                'Challenges',
                                'Updates',
                              ]
                            : const ['All', 'Events', 'News', 'Community'],
                        showFilter: _tab != 2,
                        selected: _sub,
                        onSelected: (i) => setState(() => _sub = i),
                      ),
                      const SizedBox(height: 14),
                      if (_tab == 2)
                        const CampusCompaniesView()
                      else ...[
                        const _LiveCard(),
                        const SizedBox(height: 14),

                        // ---------- Latest Campus News ----------
                        _SectionCard(
                          icon: Icons.newspaper_rounded,
                          iconColor: _blue,
                          title: 'Latest Campus News',
                          onViewAll: () {
                            // TODO: open the full news page
                          },
                          children: const [
                            _NewsTile(
                              icon: Icons.campaign_rounded,
                              color: Color(0xFFF59E0B),
                              tag: 'Official Update',
                              title: 'Placement Drive Registration Open',
                              subtitle:
                                  'Training & Placement Cell · Updated today',
                            ),
                            _NewsTile(
                              icon: Icons.description_rounded,
                              color: Color(0xFF1E88E5),
                              tag: 'College Notice',
                              title: 'Exam Schedule & Academic Calendar',
                              subtitle: 'College Administration · Oct 24, 2025',
                            ),
                            _NewsTile(
                              icon: Icons.groups_rounded,
                              color: Color(0xFF7C4DFF),
                              tag: 'Club Update',
                              title: 'New Club Activities & Registrations',
                              subtitle: 'Student Clubs · Oct 22, 2025',
                            ),
                          ],
                        ),

                        // ---------- Upcoming Events ----------
                        _SectionCard(
                          icon: Icons.calendar_month_rounded,
                          iconColor: _blue,
                          title: 'Upcoming Events',
                          onViewAll: () {
                            // TODO: open the events page
                          },
                          children: const [
                            _EventTile(
                              icon: Icons.code_rounded,
                              colors: [Color(0xFF0B2E73), Color(0xFF1E63E9)],
                              title: 'Campus Hackathon 2026',
                              status: 'Registration Open',
                              date: 'Oct 30 · 9:00 AM',
                              place: 'Main Auditorium',
                            ),
                            _EventTile(
                              icon: Icons.music_note_rounded,
                              colors: [Color(0xFF7C4DFF), Color(0xFFE91E63)],
                              title: 'Creative Fest & Open Mic',
                              date: 'Nov 2 · 4:00 PM',
                              place: 'Central Lawn',
                            ),
                          ],
                        ),

                        // ---------- Community Feed ----------
                        _SectionCard(
                          icon: Icons.groups_outlined,
                          iconColor: _blue,
                          title: 'Community Feed',
                          onViewAll: () {
                            // TODO: open the full community feed
                          },
                          children: const [
                            _PostCard(
                              name: 'Rohan Mehta',
                              info: 'B.Tech CSE · 2 hours ago · My Campus',
                              text:
                                  'Just completed my latest web development project! '
                                  'Built with React and Node.js. Excited to share what '
                                  'I\'ve learned and connect with other developers.',
                              likes: 124,
                              comments: 12,
                              avatarColor: Color(0xFF8D6E63),
                              hasImage: true,
                            ),
                            _PostCard(
                              name: 'Priya Sharma',
                              info: 'B.Sc. CS · 4 hours ago · My Campus',
                              text:
                                  'Our college tech club is hosting a coding workshop! '
                                  'Don\'t miss this opportunity to learn, build and '
                                  'grow together.',
                              likes: 89,
                              comments: 6,
                              avatarColor: Color(0xFFD7A07A),
                              attachment: _EventAttachment(),
                            ),
                          ],
                        ),

                        // ---------- Trending ----------
                        _SectionCard(
                          icon: Icons.local_fire_department_rounded,
                          iconColor: const Color(0xFFFF6A00),
                          title: 'Trending on Campus',
                          onViewAll: () {
                            // TODO: open the trending page
                          },
                          children: const [
                            _TrendTile(
                              tag: '#CampusHackathon',
                              posts: '1.2k posts',
                              icon: Icons.code_rounded,
                              colors: [Color(0xFF0B2E73), Color(0xFF1E63E9)],
                            ),
                            _TrendTile(
                              tag: '#PlacementDrive',
                              posts: '856 posts',
                              icon: Icons.business_center_rounded,
                              colors: [Color(0xFF3B2A6B), Color(0xFF7C4DFF)],
                            ),
                            _TrendTile(
                              tag: '#CollegeFest',
                              posts: '642 posts',
                              icon: Icons.celebration_rounded,
                              colors: [Color(0xFF6B1E4F), Color(0xFFE91E63)],
                            ),
                            _TrendTile(
                              tag: '#StudentProjects',
                              posts: '521 posts',
                              icon: Icons.laptop_mac_rounded,
                              colors: [Color(0xFF0F3D3E), Color(0xFF1FA67A)],
                              last: true,
                            ),
                          ],
                        ),

                        // ---------- Quick Links ----------
                        _SectionCard(
                          icon: Icons.link_rounded,
                          iconColor: _blue,
                          title: 'Quick Links',
                          onViewAll: () {
                            // TODO: open all quick links
                          },
                          children: const [
                            _LinkTile(
                              icon: Icons.event_available_outlined,
                              label: 'My Events & Registrations',
                            ),
                            _LinkTile(
                              icon: Icons.push_pin_outlined,
                              label: 'Notice Board',
                            ),
                            _LinkTile(
                              icon: Icons.language_rounded,
                              label: 'College Website',
                            ),
                            _LinkTile(
                              icon: Icons.contact_phone_outlined,
                              label: 'Important Contacts',
                              last: true,
                            ),
                          ],
                        ),

                        // ---------- Submit card ----------
                        _SubmitCard(
                          onTap: () {
                            // TODO: open the "Submit to Campus Feed" page
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // ---------- Round blue "+" button in the centre ----------
      floatingActionButton: FloatingActionButton(
        backgroundColor: _blue,
        onPressed: () {
          // TODO: open the "create post" page
        },
        child: const Icon(Icons.add, size: 32, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // ---------- Bottom bar ----------
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              Expanded(
                child: _NavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  selected: true,
                  onTap: () =>
                      Navigator.of(context).popUntil((route) => route.isFirst),
                ),
              ),
              Expanded(
                child: _NavItem(
                  icon: Icons.work_outline,
                  label: 'Internships',
                  selected: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InternshipsScreen(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 64), // space for the "+" button
              Expanded(
                child: _NavItem(
                  icon: Icons.chat_bubble_outline,
                  label: 'Chat',
                  selected: false,
                  badge: 3,
                  onTap: () {
                    // TODO: open the Chat screen
                  },
                ),
              ),
              Expanded(
                child: _NavItem(
                  icon: Icons.person_outline,
                  label: 'Profile',
                  selected: false,
                  onTap: () {
                    Navigator.push(
                      context,
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

// =====================================================================
//                              HEADER
// =====================================================================
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _navy,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 10, 16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white54),
                  color: Colors.white.withOpacity(0.08),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Campus Feed',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Connect • Share • Grow Together',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white70, fontSize: 12.5),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  // TODO: open search
                },
                icon: const Icon(Icons.search, color: Colors.white, size: 26),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    onPressed: () {
                      // TODO: open notifications
                    },
                    icon: const Icon(
                      Icons.notifications_none,
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
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
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

// =====================================================================
//                      SEARCH + CAMPUS PICKER
// =====================================================================
class _SearchRow extends StatelessWidget {
  final String hint;

  const _SearchRow({required this.hint});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: _border),
              boxShadow: _softShadow,
            ),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: _blue),
                hintText: hint,
                hintMaxLines: 1,
                hintStyle: TextStyle(color: _grey, fontSize: 13),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            // TODO: open campus picker
          },
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: _border),
              boxShadow: _softShadow,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, color: _navy, size: 20),
                SizedBox(width: 2),
                Text(
                  'My Campus',
                  style: TextStyle(
                    color: _dark,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: _grey, size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
//                  TABS: For You / Campus / Companies
// =====================================================================
class _TopTabs extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelected;

  const _TopTabs({required this.selected, required this.onSelected});

  static const List<String> _tabs = ['For You', 'Campus', 'Companies'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final bool on = i == selected;
          return InkWell(
            borderRadius: BorderRadius.circular(21),
            onTap: () => onSelected(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: on ? _blue : Colors.white,
                borderRadius: BorderRadius.circular(21),
                border: Border.all(color: on ? _blue : _border),
                boxShadow: on ? null : _softShadow,
              ),
              child: Text(
                _tabs[i],
                style: TextStyle(
                  color: on ? Colors.white : _dark,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// =====================================================================
//                SUB FILTERS: All / Events / News / Community
// =====================================================================
class _SubFilters extends StatelessWidget {
  final List<String> items;
  final bool showFilter;
  final int selected;
  final ValueChanged<int> onSelected;

  const _SubFilters({
    required this.items,
    required this.showFilter,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final bool on = i == selected;
                return InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () => onSelected(i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: on ? _blue : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: on ? _blue : _border),
                    ),
                    child: Text(
                      items[i],
                      style: TextStyle(
                        color: on ? Colors.white : _dark,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        if (showFilter) ...[
          const SizedBox(width: 8),
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              // TODO: open filter sheet
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _chipBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.tune, color: _navy, size: 22),
            ),
          ),
        ],
      ],
    );
  }
}

// =====================================================================
//                           LIVE NOW CARD
// =====================================================================
class _LiveCard extends StatelessWidget {
  const _LiveCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD5EEDD)),
        gradient: const LinearGradient(
          colors: [Color(0xFFE6F8EC), Color(0xFFF4FBF7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LIVE NOW pill
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCDF0DA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle, color: _green, size: 8),
                      SizedBox(width: 5),
                      Text(
                        'LIVE NOW',
                        style: TextStyle(
                          color: _green,
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Design & Tech Meetup',
                  style: TextStyle(
                    color: _dark,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const _MiniInfo(Icons.groups_outlined, 'Innovation Club'),
                const _MiniInfo(Icons.access_time, 'Today • 11:00 AM'),
                const _MiniInfo(Icons.location_on_outlined, 'Seminar Hall'),
                const SizedBox(height: 8),
                const Text(
                  'Connect with creators, share ideas and explore new projects.',
                  style: TextStyle(color: Color(0xFF2A6B4A), fontSize: 12.5),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    // Three overlapping avatars (placeholders)
                    // TODO: replace with real profile photos
                    const SizedBox(
                      width: 62,
                      height: 28,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            child: _MiniAvatar(Color(0xFFD7A07A)),
                          ),
                          Positioned(
                            left: 17,
                            child: _MiniAvatar(Color(0xFF8D6E63)),
                          ),
                          Positioned(
                            left: 34,
                            child: _MiniAvatar(Color(0xFF5C6BC0)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Flexible(
                      child: Text(
                        '+124 attending',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: _grey, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 128,
            child: Column(
              children: [
                // Placeholder photo with a play button
                // TODO: replace with Image.asset('assets/images/meetup.jpg')
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF0B2E73), Color(0xFF3A6FD8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(
                          Icons.groups_rounded,
                          color: Colors.white24,
                          size: 64,
                        ),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            color: _navy,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: join the live event
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _green,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text(
                      'Join Now',
                      style: TextStyle(fontWeight: FontWeight.w600),
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

class _MiniInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MiniInfo(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Icon(icon, size: 15, color: _grey),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: _grey, fontSize: 12.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniAvatar extends StatelessWidget {
  final Color color;

  const _MiniAvatar(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 12,
        backgroundColor: color,
        child: const Icon(Icons.person, color: Colors.white, size: 14),
      ),
    );
  }
}

// =====================================================================
//                        SECTION CARD WRAPPER
// =====================================================================
class _SectionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onViewAll;
  final List<Widget> children;

  const _SectionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onViewAll,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: _cardBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _dark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap: onViewAll,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        color: _blue,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.chevron_right, color: _blue, size: 18),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}

// ---------------- One news row ----------------
class _NewsTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String tag;
  final String title;
  final String subtitle;

  const _NewsTile({
    required this.icon,
    required this.color,
    required this.tag,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      color: color,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _dark,
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: _grey, fontSize: 11.5),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: _grey, size: 20),
        ],
      ),
    );
  }
}

// Placeholder thumbnail (gradient box with an icon)
// TODO: replace with Image.asset('assets/images/your_image.jpg')
class _Thumb extends StatelessWidget {
  final IconData icon;
  final List<Color> colors;
  final double width;
  final double height;

  const _Thumb({
    required this.icon,
    required this.colors,
    this.width = 56,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Icon(icon, color: Colors.white70, size: 26),
    );
  }
}

// ---------------- One upcoming event row ----------------
class _EventTile extends StatelessWidget {
  final IconData icon;
  final List<Color> colors;
  final String title;
  final String? status;
  final String date;
  final String place;

  const _EventTile({
    required this.icon,
    required this.colors,
    required this.title,
    required this.date,
    required this.place,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FE),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _Thumb(icon: icon, colors: colors, width: 62, height: 72),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _dark,
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (status != null) ...[
                  const SizedBox(height: 3),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCDF0DA),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      status!,
                      style: const TextStyle(
                        color: _green,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                _MiniInfo(Icons.calendar_today_outlined, date),
                _MiniInfo(Icons.location_on_outlined, place),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: _grey, size: 20),
        ],
      ),
    );
  }
}

// ---------------- One trending row ----------------
class _TrendTile extends StatelessWidget {
  final String tag;
  final String posts;
  final IconData icon;
  final List<Color> colors;
  final bool last;

  const _TrendTile({
    required this.tag,
    required this.posts,
    required this.icon,
    required this.colors,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: open this hashtag page
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: last
              ? null
              : const Border(bottom: BorderSide(color: _border)),
        ),
        child: Row(
          children: [
            _Thumb(icon: icon, colors: colors, width: 52, height: 46),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tag,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _dark,
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    posts,
                    style: const TextStyle(color: _grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: _grey, size: 20),
          ],
        ),
      ),
    );
  }
}

// ---------------- One quick link row ----------------
class _LinkTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool last;

  const _LinkTile({required this.icon, required this.label, this.last = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: open this link
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: last
              ? null
              : const Border(bottom: BorderSide(color: _border)),
        ),
        child: Row(
          children: [
            Icon(icon, color: _navy, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: _dark, fontSize: 13.5),
              ),
            ),
            const Icon(Icons.chevron_right, color: _grey, size: 20),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
//                          COMMUNITY POST CARD
// =====================================================================
class _PostCard extends StatefulWidget {
  final String name;
  final String info;
  final String text;
  final int likes;
  final int comments;
  final Color avatarColor;
  final bool hasImage;
  final Widget? attachment;

  const _PostCard({
    required this.name,
    required this.info,
    required this.text,
    required this.likes,
    required this.comments,
    required this.avatarColor,
    this.hasImage = false,
    this.attachment,
  });

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
  bool _liked = false;
  bool _saved = false;

  @override
  Widget build(BuildContext context) {
    final int likeCount = widget.likes + (_liked ? 1 : 0);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // TODO: replace with a real profile photo
              CircleAvatar(
                radius: 22,
                backgroundColor: widget.avatarColor,
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: _dark,
                              fontSize: 14.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.verified, color: _blue, size: 15),
                      ],
                    ),
                    Text(
                      widget.info,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: _grey, fontSize: 11.5),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz, color: _grey),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.text,
            style: const TextStyle(color: _dark, fontSize: 13, height: 1.35),
          ),
          if (widget.hasImage) ...[
            const SizedBox(height: 10),
            const _PostImage(),
          ],
          if (widget.attachment != null) ...[
            const SizedBox(height: 10),
            widget.attachment!,
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              InkWell(
                onTap: () => setState(() => _liked = !_liked),
                child: Row(
                  children: [
                    Icon(
                      _liked ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 22,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$likeCount',
                      style: const TextStyle(color: _grey, fontSize: 12.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              InkWell(
                onTap: () {
                  // TODO: open comments
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.chat_bubble_outline,
                      color: _grey,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.comments}',
                      style: const TextStyle(color: _grey, fontSize: 12.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              InkWell(
                onTap: () {
                  // TODO: share this post
                },
                child: const Row(
                  children: [
                    Icon(Icons.share_outlined, color: _grey, size: 20),
                    SizedBox(width: 4),
                    Text(
                      'Share',
                      style: TextStyle(color: _grey, fontSize: 12.5),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () => setState(() => _saved = !_saved),
                child: Icon(
                  _saved ? Icons.bookmark : Icons.bookmark_border,
                  color: _saved ? _blue : _grey,
                  size: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Placeholder for the post photo (laptop picture with "+2")
// TODO: replace with ClipRRect(child: Image.asset('assets/images/post1.jpg'))
class _PostImage extends StatelessWidget {
  const _PostImage();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF1E3A5F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            const Center(
              child: Icon(
                Icons.laptop_mac_rounded,
                color: Color(0xFF38BDF8),
                size: 56,
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '+2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Event card inside Priya's post
class _EventAttachment extends StatelessWidget {
  const _EventAttachment();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F8FE),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          // TODO: replace with Image.asset('assets/images/workshop.png')
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'CODE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'WORKSHOP',
                  style: TextStyle(
                    color: Color(0xFF38BDF8),
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Coding Workshop',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _dark,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Tech Club · Nov 1, 2025 · 10:00 AM',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: _grey, fontSize: 11),
                ),
                SizedBox(height: 2),
                Text(
                  'Lab Block',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: _grey, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          ElevatedButton(
            onPressed: () {
              // TODO: register for the workshop
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _blue,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              minimumSize: const Size(0, 32),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Register Now',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//                       "SUBMIT TO CAMPUS FEED"
// =====================================================================
class _SubmitCard extends StatelessWidget {
  final VoidCallback onTap;

  const _SubmitCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFFE8F0FF), Color(0xFFF4F8FF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFD0E0FF)),
            ),
            child: const Icon(Icons.event_note_rounded, color: _blue, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Have an event, news or opportunity to share?',
                  style: TextStyle(color: _dark, fontSize: 13.5),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _blue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          'Submit to Campus Feed',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, size: 16),
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

// =====================================================================
//                      BOTTOM BAR ITEM (with badge)
// =====================================================================
class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final int badge; // 0 = no badge
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
    final Color color = selected ? _blue : _grey;
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
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$badge',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontSize: 11.5,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
