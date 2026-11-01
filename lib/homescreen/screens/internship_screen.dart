import 'package:Cradix/homescreen/chat_screen.dart';
import 'package:Cradix/homescreen/screens/profile_screen.dart';
import 'package:flutter/material.dart';

// Same folder (lib/homescreen/screens/) so no extra path needed.

// ---------- Colors used on this screen (private to this file) ----------
const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);
const Color _grey = Color(0xFF6B7A99);
const Color _chipBg = Color(0xFFEAF1FF);

// ---------- Simple data holder for one internship ----------
class _Internship {
  final int logoType; // 0 = TechSphere, 1 = Google, 2 = Microsoft
  final String company;
  final String title;
  final String description;
  final String salary;
  final String duration;
  final String location;
  final List<String> skills;
  final String applyBefore;

  const _Internship({
    required this.logoType,
    required this.company,
    required this.title,
    required this.description,
    required this.salary,
    required this.duration,
    required this.location,
    required this.skills,
    required this.applyBefore,
  });
}

// Dummy data. Later you can replace this with real data from your backend.
const List<_Internship> _recommended = [
  _Internship(
    logoType: 0,
    company: 'TechSphere',
    title: 'Frontend Developer Intern',
    description: 'Work on real-world projects and build amazing products.',
    salary: '₹10,000 – 15,000 / month',
    duration: '3 months',
    location: 'Remote',
    skills: ['React', 'JavaScript', 'HTML', 'CSS'],
    applyBefore: '25 Apr 2025',
  ),
  _Internship(
    logoType: 1,
    company: 'Google',
    title: 'Software Engineering Intern',
    description: 'Join our team and work on cutting-edge technology.',
    salary: '₹15,000 – 25,000 / month',
    duration: '3 months',
    location: 'Bangalore (On-site)',
    skills: ['Python', 'Java', 'Data Structures', 'Problem Solving'],
    applyBefore: '30 Apr 2025',
  ),
  _Internship(
    logoType: 2,
    company: 'Microsoft',
    title: 'Product Management Intern',
    description: 'Be a part of our innovation journey.',
    salary: '₹12,000 – 20,000 / month',
    duration: '3 months',
    location: 'Hybrid (Bangalore)',
    skills: ['Product Management', 'Communication', 'Analytical Thinking'],
    applyBefore: '28 Apr 2025',
  ),
];

// =====================================================================
//                         INTERNSHIPS SCREEN
// =====================================================================
class InternshipsScreen extends StatefulWidget {
  const InternshipsScreen({super.key});

  @override
  State<InternshipsScreen> createState() => _InternshipsScreenState();
}

class _InternshipsScreenState extends State<InternshipsScreen> {
  static const List<String> _filters = [
    'All',
    'Remote',
    'Paid',
    'Part-time',
    'Latest',
  ];

  int _selectedFilter = 0; // which chip is selected
  final Set<int> _saved = {}; // indexes of bookmarked internships

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Column(
        children: [
          _Header(onBack: () => Navigator.maybePop(context)),
          Expanded(
            child: Container(
              color: _navy,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(26),
                ),
                child: Container(
                  color: Colors.white,
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                    children: [
                      const _SearchRow(),
                      const SizedBox(height: 14),
                      _FilterChips(
                        filters: _filters,
                        selected: _selectedFilter,
                        onSelected: (i) => setState(() => _selectedFilter = i),
                      ),
                      const SizedBox(height: 16),
                      _MatchBanner(
                        onUpdateProfile: () {
                          // TODO: open the Edit Profile page
                        },
                      ),
                      const SizedBox(height: 18),
                      _SectionHeader(
                        leading: const Icon(
                          Icons.local_fire_department,
                          color: Color(0xFFFF8A00),
                          size: 24,
                        ),
                        title: 'Recommended for You',
                        actionText: 'See All',
                        onAction: () {
                          // TODO: open the full internships list
                        },
                      ),
                      const SizedBox(height: 12),
                      for (int i = 0; i < _recommended.length; i++)
                        _InternshipCard(
                          item: _recommended[i],
                          saved: _saved.contains(i),
                          onSave: () => setState(() {
                            if (_saved.contains(i)) {
                              _saved.remove(i);
                            } else {
                              _saved.add(i);
                            }
                          }),
                          onApply: () {
                            // TODO: open the internship details / apply page
                          },
                        ),
                      const SizedBox(height: 6),
                      _SectionHeader(
                        leading: const Icon(
                          Icons.description_outlined,
                          color: _blue,
                          size: 24,
                        ),
                        title: 'My Applications',
                        actionText: 'View All',
                        onAction: () {
                          // TODO: open the My Applications page
                        },
                      ),
                      const SizedBox(height: 12),
                      const _ApplicationsRow(),
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
          // TODO: open the "create / post" page
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
                  icon: Icons.home_outlined,
                  label: 'Home',
                  selected: false,
                  // Go back to the first screen (Home)
                  onTap: () =>
                      Navigator.of(context).popUntil((route) => route.isFirst),
                ),
              ),
              const Expanded(
                child: _NavItem(
                  icon: Icons.work_outline,
                  label: 'Internships',
                  selected: true,
                  onTap: null, // already on this screen
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatScreen(),
                      ),
                    );
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
                      MaterialPageRoute(builder: (_) => ProfileScreen()),
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
  final VoidCallback onBack;

  const _Header({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _navy,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 16, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Internships',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Build your skills. Gain experience. Shape your future.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Stack(
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
                        width: 9,
                        height: 9,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
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
//                    SEARCH + LOCATION + FILTER ROW
// =====================================================================
class _SearchRow extends StatelessWidget {
  const _SearchRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Search box takes all the leftover width
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE3EAF7)),
              boxShadow: _softShadow,
            ),
            child: const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: _navy),
                hintText: 'Search role, company or skill',
                hintMaxLines: 1,
                hintStyle: TextStyle(color: _grey, fontSize: 13),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Location chip
        InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            // TODO: open location picker
          },
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE3EAF7)),
              boxShadow: _softShadow,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on_outlined, color: _blue, size: 20),
                SizedBox(width: 2),
                Text(
                  'Location',
                  style: TextStyle(
                    color: _navy,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: _navy, size: 18),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Filter button
        InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            // TODO: open filter sheet
          },
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _chipBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.tune, color: _navy),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
//                           FILTER CHIPS
// =====================================================================
class _FilterChips extends StatelessWidget {
  final List<String> filters;
  final int selected;
  final ValueChanged<int> onSelected;

  const _FilterChips({
    required this.filters,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Horizontal scroll so it never overflows on small phones
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final bool isSelected = i == selected;
          return InkWell(
            borderRadius: BorderRadius.circular(21),
            onTap: () => onSelected(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? _blue : Colors.white,
                borderRadius: BorderRadius.circular(21),
                border: Border.all(
                  color: isSelected ? _blue : const Color(0xFFE3EAF7),
                ),
                boxShadow: isSelected ? null : _softShadow,
              ),
              child: Text(
                filters[i],
                style: TextStyle(
                  color: isSelected ? Colors.white : _navy,
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
//                    "GET MATCHED" BANNER CARD
// =====================================================================
class _MatchBanner extends StatelessWidget {
  final VoidCallback onUpdateProfile;

  const _MatchBanner({required this.onUpdateProfile});

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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.track_changes, color: _blue, size: 26),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Get Matched with the Right Opportunities',
                        style: TextStyle(
                          color: _navy,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Complete your profile to unlock personalized internship recommendations.',
                  style: TextStyle(color: _navy, fontSize: 12.5),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: onUpdateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _blue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Update Profile',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Placeholder illustration (briefcase in a circle)
          // TODO: replace with Image.asset('assets/images/briefcase.png', width: 90)
          Container(
            width: 76,
            height: 76,
            decoration: const BoxDecoration(
              color: Color(0xFFD6E6FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.work, color: _blue, size: 40),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//                        SECTION HEADER ROW
// =====================================================================
class _SectionHeader extends StatelessWidget {
  final Widget leading;
  final String title;
  final String actionText;
  final VoidCallback onAction;

  const _SectionHeader({
    required this.leading,
    required this.title,
    required this.actionText,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leading,
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _navy,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        InkWell(
          onTap: onAction,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                actionText,
                style: const TextStyle(
                  color: _blue,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(Icons.chevron_right, color: _blue, size: 20),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================================
//                         INTERNSHIP CARD
// =====================================================================
class _InternshipCard extends StatelessWidget {
  final _Internship item;
  final bool saved;
  final VoidCallback onSave;
  final VoidCallback onApply;

  const _InternshipCard({
    required this.item,
    required this.saved,
    required this.onSave,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEDF2FB)),
        boxShadow: _softShadow,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CompanyLogo(type: item.logoType),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company name + verified tick
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            item.company,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: _navy,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.verified, color: _blue, size: 16),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _navy,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: _grey, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    // Wrap = moves items to the next line if no space
                    Wrap(
                      spacing: 12,
                      runSpacing: 4,
                      children: [
                        _InfoItem(
                          icon: Icons.payments_outlined,
                          text: item.salary,
                        ),
                        _InfoItem(
                          icon: Icons.calendar_today_outlined,
                          text: item.duration,
                        ),
                        _InfoItem(
                          icon: Icons.location_on_outlined,
                          text: item.location,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final skill in item.skills) _SkillChip(skill),
                      ],
                    ),
                  ],
                ),
              ),
              // Bookmark button (top right)
              InkWell(
                onTap: onSave,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Icon(
                    saved ? Icons.bookmark : Icons.bookmark_border,
                    color: saved ? _blue : _navy,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Bottom row: date on the left, Apply button on the right
          Row(
            children: [
              const Icon(
                Icons.event_outlined,
                color: Color(0xFFE5484D),
                size: 18,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Apply before: ${item.applyBefore}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: _grey, fontSize: 12.5),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: onApply,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _blue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Apply Now',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Small "icon + text" item (salary, duration, location)
class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: _grey),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: _grey, fontSize: 11.5)),
      ],
    );
  }
}

// Small skill tag like "React" or "Python"
class _SkillChip extends StatelessWidget {
  final String label;

  const _SkillChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _chipBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF3B4F7A),
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// Placeholder company logos (simple boxes).
// TODO: replace each one with Image.asset('assets/images/company.png')
class _CompanyLogo extends StatelessWidget {
  final int type; // 0 = TechSphere, 1 = Google, 2 = Microsoft

  const _CompanyLogo({required this.type});

  @override
  Widget build(BuildContext context) {
    Widget inner;
    Color bg = Colors.white;

    if (type == 0) {
      bg = const Color(0xFF0A1430);
      inner = const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'T',
            style: TextStyle(
              color: Color(0xFF3FA2FF),
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            'TechSphere',
            style: TextStyle(color: Colors.white, fontSize: 8),
          ),
        ],
      );
    } else if (type == 1) {
      inner = const Center(
        child: Text(
          'G',
          style: TextStyle(
            color: Color(0xFF4285F4),
            fontSize: 38,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      // Microsoft: four coloured squares
      inner = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _Square(Color(0xFFF25022)),
                SizedBox(width: 3),
                _Square(Color(0xFF7FBA00)),
              ],
            ),
            SizedBox(height: 3),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _Square(Color(0xFF00A4EF)),
                SizedBox(width: 3),
                _Square(Color(0xFFFFB900)),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEDF2FB)),
      ),
      child: inner,
    );
  }
}

class _Square extends StatelessWidget {
  final Color color;

  const _Square(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(width: 18, height: 18, color: color);
  }
}

// =====================================================================
//                         MY APPLICATIONS ROW
// =====================================================================
class _ApplicationsRow extends StatelessWidget {
  const _ApplicationsRow();

  @override
  Widget build(BuildContext context) {
    // Horizontal scroll so 5 tiles fit on any phone width
    return SizedBox(
      height: 112,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          _AppStatusTile(
            icon: Icons.send,
            color: Color(0xFF1E63E9),
            label: 'Applied',
            count: 3,
          ),
          SizedBox(width: 10),
          _AppStatusTile(
            icon: Icons.access_time,
            color: Color(0xFFF5A623),
            label: 'Under Review',
            count: 2,
          ),
          SizedBox(width: 10),
          _AppStatusTile(
            icon: Icons.star_border,
            color: Color(0xFF7C4DFF),
            label: 'Shortlisted',
            count: 1,
          ),
          SizedBox(width: 10),
          _AppStatusTile(
            icon: Icons.calendar_today_outlined,
            color: Color(0xFF1FA67A),
            label: 'Interview',
            count: 0,
          ),
          SizedBox(width: 10),
          _AppStatusTile(
            icon: Icons.check_circle,
            color: Color(0xFF22B573),
            label: 'Selected',
            count: 0,
          ),
        ],
      ),
    );
  }
}

class _AppStatusTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final int count;

  const _AppStatusTile({
    required this.icon,
    required this.color,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        // TODO: open the applications list filtered by this status
      },
      child: Container(
        width: 116,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEDF2FB)),
          boxShadow: _softShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _navy,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, color: _grey, size: 16),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              '$count',
              style: const TextStyle(
                color: _navy,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
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
  final VoidCallback? onTap;

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

// Soft shadow shared by all white cards on this screen
final List<BoxShadow> _softShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.05),
    blurRadius: 10,
    offset: const Offset(0, 3),
  ),
];
