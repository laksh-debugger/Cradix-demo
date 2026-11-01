import 'package:Cradix/homescreen/screens/explore_screen.dart';
import 'package:Cradix/homescreen/screens/profile_screen.dart';
import 'package:flutter/material.dart';

/// Open it with:
/// Navigator.push(context, MaterialPageRoute(builder: (_) => const HackathonBuddyScreen()));
class HackathonBuddyScreen extends StatelessWidget {
  const HackathonBuddyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _H.navy,
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
                color: _H.bg,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
                  children: const [
                    _SearchRow(),
                    SizedBox(height: 14),
                    _FilterChips(),
                    SizedBox(height: 18),
                    _SectionHeader(
                      icon: Icons.bolt_rounded,
                      title: 'Quick Actions',
                      iconColor: _H.primary,
                    ),
                    SizedBox(height: 10),
                    _QuickActions(),
                    SizedBox(height: 22),
                    _SectionHeader(
                      icon: Icons.event_note_rounded,
                      title: 'Upcoming Hackathons',
                    ),
                    SizedBox(height: 10),
                    _UpcomingSection(),
                    SizedBox(height: 12),
                    _SectionHeader(
                      icon: Icons.groups_outlined,
                      title: 'My Hackathons',
                    ),
                    SizedBox(height: 10),
                    _MySection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: _H.primary,
        foregroundColor: Colors.white,
        elevation: 6,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const _HackBottomBar(),
    );
  }
}

// ---------------- Colors & helpers ----------------

class _H {
  static const primary = Color(0xFF1E63E9);
  static const navy = Color(0xFF0B2E73);
  static const bg = Color(0xFFF5F8FE);
  static const border = Color(0xFFE6EDF8);
  static const textDark = Color(0xFF0B2A6B);
  static const textGrey = Color(0xFF6B7A93);
  static const chipBg = Color(0xFFE3EEFF);
  static const green = Color(0xFF1E9E55);
  static const orange = Color(0xFFF59E0B);
}

BoxDecoration _card() => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(16),
  border: Border.all(color: _H.border),
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
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.maybePop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              const SizedBox(width: 4),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hackathon Buddy',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Find hackathons, build teams, create ideas',
                      style: TextStyle(
                        color: Color(0xFFD5E2FA),
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
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
        ),
      ),
    );
  }
}

// ---------------- Search + filter ----------------

class _SearchRow extends StatelessWidget {
  const _SearchRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: _H.border),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: _H.textDark),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 13),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      hintText: 'Search hackathons, skills, technologies...',
                      hintStyle: TextStyle(
                        color: _H.textGrey,
                        fontSize: 13,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _H.chipBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.tune_rounded, color: _H.primary),
          ),
        ),
      ],
    );
  }
}

class _FilterChips extends StatefulWidget {
  const _FilterChips();

  @override
  State<_FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<_FilterChips> {
  int _selected = 0;
  static const _labels = ['All', 'Upcoming', 'Online', 'Offline'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < _labels.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () => setState(() => _selected = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: _selected == i ? _H.primary : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: _selected == i ? _H.primary : _H.border,
                    ),
                  ),
                  child: Text(
                    _labels[i],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _selected == i ? Colors.white : _H.textDark,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------- Section header ----------------

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  const _SectionHeader({
    required this.icon,
    required this.title,
    this.iconColor = _H.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _H.textDark,
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: const Row(
            children: [
              Text(
                'See All',
                style: TextStyle(
                  color: _H.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              Icon(Icons.chevron_right, color: _H.primary, size: 18),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------- Quick actions ----------------

class _Action {
  final String title;
  final IconData icon;
  final Color color;
  const _Action(this.title, this.icon, this.color);
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  static const _actions = [
    _Action(
      'Discover\nHackathons',
      Icons.emoji_events_outlined,
      Color(0xFF1E88E5),
    ),
    _Action('Find\nTeammates', Icons.groups_outlined, Color(0xFF2FB36B)),
    _Action('Create / Join\nTeam', Icons.group_add_outlined, Color(0xFF7E57C2)),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < _actions.length; i++) ...[
          Expanded(child: _ActionTile(action: _actions[i])),
          if (i != _actions.length - 1) const SizedBox(width: 10),
        ],
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  final _Action action;
  const _ActionTile({required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 128,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: action.color.withOpacity(0.10),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: action.color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: action.color.withOpacity(0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(action.icon, color: action.color, size: 24),
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    action.title,
                    style: const TextStyle(
                      fontSize: 13.5,
                      height: 1.25,
                      fontWeight: FontWeight.w700,
                      color: _H.textDark,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, color: _H.textGrey, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Upcoming hackathons ----------------

class _Logo extends StatelessWidget {
  final String label;
  final IconData? icon;
  final List<Color> colors;
  final double width, height;
  const _Logo({
    required this.label,
    required this.colors,
    required this.width,
    required this.height,
    this.icon,
  });

  // Replace with: Image.asset('assets/techignite.png', fit: BoxFit.cover)
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: const Color(0xFF7DB8FF), size: 28),
            const SizedBox(height: 4),
          ],
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              height: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _Hack {
  final String title, by, date, place, prize, status, logoLabel;
  final IconData logoIcon;
  final Color statusBg, statusFg;
  final List<Color> logoColors;
  const _Hack({
    required this.title,
    required this.by,
    required this.date,
    required this.place,
    required this.prize,
    required this.status,
    required this.statusBg,
    required this.statusFg,
    required this.logoLabel,
    required this.logoIcon,
    required this.logoColors,
  });
}

class _UpcomingSection extends StatelessWidget {
  const _UpcomingSection();

  static const _hacks = [
    _Hack(
      title: 'TechIgnite 2025',
      by: 'TechSphere',
      date: 'Apr 15 – Apr 17, 2025',
      place: 'Online',
      prize: '₹ 5,00,000 Prize Pool',
      status: 'Open',
      statusBg: Color(0xFFDDF6E7),
      statusFg: Color(0xFF1E9E55),
      logoLabel: 'TechIgnite\nHackathon',
      logoIcon: Icons.local_fire_department_rounded,
      logoColors: [Color(0xFF0B1F4D), Color(0xFF12306E)],
    ),
    _Hack(
      title: 'CodeVerse Hackathon',
      by: 'DevStack',
      date: 'Apr 25 – Apr 27, 2025',
      place: 'Hybrid (College Campus)',
      prize: '₹ 3,00,000 Prize Pool',
      status: 'Closing Soon',
      statusBg: Color(0xFFFFF1D6),
      statusFg: Color(0xFFE08A00),
      logoLabel: 'CodeVerse',
      logoIcon: Icons.code_rounded,
      logoColors: [Color(0xFF1B1F5E), Color(0xFF2A2A8C)],
    ),
    _Hack(
      title: 'AI for Good',
      by: 'GlobalTech',
      date: 'May 10 – May 12, 2025',
      place: 'Online',
      prize: '₹ 2,00,000 Prize Pool',
      status: 'Open',
      statusBg: Color(0xFFDDF6E7),
      statusFg: Color(0xFF1E9E55),
      logoLabel: 'AI for Good',
      logoIcon: Icons.psychology_rounded,
      logoColors: [Color(0xFF2B2A9A), Color(0xFF4B3FD0)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [for (final h in _hacks) _HackCard(hack: h)]);
  }
}

class _HackCard extends StatelessWidget {
  final _Hack hack;
  const _HackCard({required this.hack});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: _card(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Logo(
            label: hack.logoLabel,
            icon: hack.logoIcon,
            colors: hack.logoColors,
            width: 80,
            height: 96,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        hack.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: _H.textDark,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: hack.statusBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        hack.status,
                        style: TextStyle(
                          color: hack.statusFg,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'by ${hack.by}',
                  style: const TextStyle(fontSize: 12, color: _H.textGrey),
                ),
                const SizedBox(height: 6),
                _InfoLine(icon: Icons.calendar_today_outlined, text: hack.date),
                _InfoLine(icon: Icons.location_on_outlined, text: hack.place),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Expanded(
                      child: _InfoLine(
                        icon: Icons.emoji_events,
                        text: hack.prize,
                        iconColor: _H.orange,
                        bottomPadding: 0,
                      ),
                    ),
                    const SizedBox(width: 6),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _H.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 9,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View Details',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 3),
                          Icon(Icons.chevron_right, size: 15),
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
    );
  }
}

class _InfoLine extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final double bottomPadding;
  const _InfoLine({
    required this.icon,
    required this.text,
    this.iconColor = _H.textGrey,
    this.bottomPadding = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Row(
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: _H.textGrey),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- My hackathons ----------------

class _My {
  final String title, date, status, team, logo;
  final Color statusBg, statusFg;
  final List<Color> logoColors;
  const _My({
    required this.title,
    required this.date,
    required this.status,
    required this.team,
    required this.logo,
    required this.statusBg,
    required this.statusFg,
    required this.logoColors,
  });
}

class _MySection extends StatelessWidget {
  const _MySection();

  static const _items = [
    _My(
      title: 'TechIgnite 2025',
      date: 'Apr 15 – Apr 17, 2025',
      status: 'Registered',
      team: 'Team: 4 members',
      logo: 'TechIgnite',
      statusBg: Color(0xFFDDF6E7),
      statusFg: Color(0xFF1E9E55),
      logoColors: [Color(0xFF0B1F4D), Color(0xFF12306E)],
    ),
    _My(
      title: 'CodeVerse Hackathon',
      date: 'Apr 25 – Apr 27, 2025',
      status: 'Invited',
      team: 'Team: 2 members',
      logo: 'CodeVerse',
      statusBg: Color(0xFFE3EEFF),
      statusFg: Color(0xFF1E63E9),
      logoColors: [Color(0xFF1B1F5E), Color(0xFF2A2A8C)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final m in _items)
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(10),
            decoration: _card(),
            child: Row(
              children: [
                _Logo(
                  label: m.logo,
                  colors: m.logoColors,
                  width: 64,
                  height: 58,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        m.title,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: _H.textDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      _InfoLine(
                        icon: Icons.calendar_today_outlined,
                        text: m.date,
                        bottomPadding: 0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: m.statusBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        m.status,
                        style: TextStyle(
                          color: m.statusFg,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.people_outline,
                          size: 14,
                          color: _H.textGrey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          m.team,
                          style: const TextStyle(
                            fontSize: 11,
                            color: _H.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.chevron_right, color: _H.textGrey),
              ],
            ),
          ),
      ],
    );
  }
}

// ---------------- Bottom navigation ----------------

class _HackBottomBar extends StatelessWidget {
  const _HackBottomBar();

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
                active: true,
                // Go back to the home screen
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
                onTap: () {},
              ),
            ),
            Expanded(
              child: _NavItem(
                icon: Icons.person_outline,
                label: 'Profile',
                onTap: () {
                  final nav = Navigator.of(context);
                  nav.popUntil((route) => route.isFirst);
                  nav.push(
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                },
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
    final color = active ? _H.primary : _H.textGrey;
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
