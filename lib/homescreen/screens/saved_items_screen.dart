import 'package:Cradix/homescreen/screens/explore_screen.dart';
import 'package:Cradix/homescreen/screens/profile_screen.dart';
import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);
const Color _fieldBorder = Color(0xFFDDE5F3);
const Color _hint = Color(0xFF9AA7BF);
const Color _textGrey = Color(0xFF6B7A93);
const Color _green = Color(0xFF1FA971);
const Color _orange = Color(0xFFF59E0B);
const Color _red = Color(0xFFE53935);

const List<String> _tabs = [
  'All Saved',
  'Hackathons',
  'Internships',
  'Courses',
];

class _Chip {
  final String text;
  final Color color;
  final IconData? icon;
  final bool dot;

  const _Chip(this.text, this.color, {this.icon, this.dot = false});
}

class _Info {
  final IconData icon;
  final String text;
  final Color? color;

  const _Info(this.icon, this.text, {this.color});
}

class _SavedItem {
  // 1 = hackathon, 2 = internship, 3 = course (matches the tab numbers)
  final int type;
  final String title;
  final String? subtitle;
  final List<_Chip> chips;
  final List<_Info> infos;
  final String button;
  final Color color1;
  final Color color2;
  final IconData? thumbIcon;
  final String thumbLabel;
  final bool logo;

  const _SavedItem({
    required this.type,
    required this.title,
    this.subtitle,
    this.chips = const [],
    this.infos = const [],
    required this.button,
    required this.color1,
    required this.color2,
    this.thumbIcon,
    required this.thumbLabel,
    this.logo = false,
  });
}

// Sample saved items. Replace with the user's real saved list later.
const List<_SavedItem> _allItems = [
  _SavedItem(
    type: 1,
    title: 'Campus Hackathon 2026',
    chips: [
      _Chip('Hackathon', _blue, icon: Icons.emoji_events_outlined),
      _Chip('Registration Open', _green, dot: true),
    ],
    infos: [
      _Info(Icons.calendar_today_outlined, 'Apply by Oct 30'),
      _Info(Icons.groups_outlined, 'Team size: 2–4'),
    ],
    button: 'View Details',
    color1: Color(0xFF0B2E73),
    color2: Color(0xFF1E63E9),
    thumbIcon: Icons.laptop_mac,
    thumbLabel: 'CAMPUS\nHACKATHON\n2026',
  ),
  _SavedItem(
    type: 1,
    title: 'AI Innovation Challenge',
    chips: [
      _Chip('Online', _blue, icon: Icons.videocam_outlined),
      _Chip('Team of 2–4', _blue, icon: Icons.groups_outlined),
    ],
    infos: [_Info(Icons.calendar_today_outlined, 'Apply by Nov 5')],
    button: 'View Details',
    color1: Color(0xFF14213D),
    color2: Color(0xFF6C3FE0),
    thumbIcon: Icons.psychology_outlined,
    thumbLabel: 'AI\nINNOVATION\nCHALLENGE',
  ),
  _SavedItem(
    type: 2,
    title: 'Frontend Developer Intern',
    subtitle: 'NovaTech',
    infos: [
      _Info(Icons.currency_rupee, '12,000/month'),
      _Info(Icons.calendar_today_outlined, '3 months'),
      _Info(Icons.location_on_outlined, 'Remote'),
      _Info(Icons.event_outlined, 'Apply by Nov 10'),
    ],
    button: 'View Internship',
    color1: Color(0xFF1E63E9),
    color2: Color(0xFF4A3FD8),
    thumbLabel: 'NT',
    logo: true,
  ),
  _SavedItem(
    type: 3,
    title: 'Web Development',
    subtitle: 'Coursera',
    chips: [_Chip('Free', _green)],
    infos: [_Info(Icons.star, '4.8 (12k)', color: _orange)],
    button: 'View Course',
    color1: Color(0xFF0B2E73),
    color2: Color(0xFF2F8BEA),
    thumbIcon: Icons.web,
    thumbLabel: 'Web\nDevelopment',
  ),
  _SavedItem(
    type: 3,
    title: 'Data Science & ML',
    subtitle: 'Udemy',
    chips: [_Chip('₹1,499', _blue)],
    infos: [_Info(Icons.star, '4.7 (8k)', color: _orange)],
    button: 'View Course',
    color1: Color(0xFF14213D),
    color2: Color(0xFF1FA971),
    thumbIcon: Icons.bar_chart,
    thumbLabel: 'Data Science\n& ML',
  ),
];

class SavedItemsScreen extends StatefulWidget {
  const SavedItemsScreen({super.key});

  @override
  State<SavedItemsScreen> createState() => _SavedItemsScreenState();
}

class _SavedItemsScreenState extends State<SavedItemsScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  final List<_SavedItem> _items = List<_SavedItem>.of(_allItems);

  int _tab = 0;
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<_SavedItem> _visible() {
    final String q = _query.trim().toLowerCase();
    return _items.where((item) {
      final bool tabOk = _tab == 0 || item.type == _tab;
      final bool searchOk =
          q.isEmpty ||
          item.title.toLowerCase().contains(q) ||
          (item.subtitle ?? '').toLowerCase().contains(q);
      return tabOk && searchOk;
    }).toList();
  }

  void _remove(_SavedItem item) {
    final int index = _items.indexOf(item);
    setState(() => _items.remove(item));

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Removed from saved'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              final int at = index > _items.length ? _items.length : index;
              _items.insert(at, item);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<_SavedItem> shown = _visible();

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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: _TabBar(
                          selected: _tab,
                          onChanged: (i) => setState(() => _tab = i),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(color: _fieldBorder),
                                ),
                                child: TextField(
                                  controller: _searchCtrl,
                                  onChanged: (v) => setState(() => _query = v),
                                  decoration: const InputDecoration(
                                    hintText: 'Search saved items...',
                                    hintStyle: TextStyle(color: _hint),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: _blue,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                // TODO: open the filter options
                              },
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: _fieldBorder),
                                ),
                                child: const Icon(Icons.tune, color: _navy),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: shown.isEmpty
                            ? const _EmptyState()
                            : ListView(
                                keyboardDismissBehavior:
                                    ScrollViewKeyboardDismissBehavior.onDrag,
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  0,
                                  16,
                                  24,
                                ),
                                children: [
                                  for (final _SavedItem item in shown) ...[
                                    _ItemCard(
                                      item: item,
                                      onUnsave: () => _remove(item),
                                      onOpen: () {
                                        // TODO: open the ${item.title} details page
                                      },
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                  const SizedBox(height: 8),
                                  const _Footer(),
                                ],
                              ),
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
      padding: const EdgeInsets.fromLTRB(8, 10, 16, 18),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const SizedBox(width: 2),
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: _blue,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.bookmark, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Saved Items',
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
                  'Your saved opportunities in one place.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 12.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;

  const _TabBar({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: _fieldBorder),
      ),
      child: Row(
        children: [
          for (int i = 0; i < _tabs.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(i),
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: selected == i ? _blue : Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _tabs[i],
                      maxLines: 1,
                      style: TextStyle(
                        color: selected == i ? Colors.white : _navy,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
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

class _ItemCard extends StatelessWidget {
  final _SavedItem item;
  final VoidCallback onUnsave;
  final VoidCallback onOpen;

  const _ItemCard({
    required this.item,
    required this.onUnsave,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: _navy.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Replace this box with the real picture:
          // Image.asset('assets/images/saved_item.png', width: 84, height: 84)
          _Thumb(item: item),
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
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _navy,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    InkWell(
                      onTap: onUnsave,
                      borderRadius: BorderRadius.circular(16),
                      child: const Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(Icons.bookmark, color: _blue, size: 26),
                      ),
                    ),
                  ],
                ),
                if (item.subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    item.subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: _textGrey, fontSize: 13.5),
                  ),
                ],
                if (item.chips.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      for (final _Chip c in item.chips) _ChipView(chip: c),
                    ],
                  ),
                ],
                if (item.infos.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 6,
                    children: [
                      for (final _Info i in item.infos) _InfoView(info: i),
                    ],
                  ),
                ],
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Material(
                    color: _blue,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: onOpen,
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item.button,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 2),
                            const Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
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

class _Thumb extends StatelessWidget {
  final _SavedItem item;

  const _Thumb({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      height: 84,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [item.color1, item.color2],
        ),
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: item.logo
              ? Text(
                  item.thumbLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (item.thumbIcon != null)
                      Icon(item.thumbIcon, color: Colors.white, size: 26),
                    const SizedBox(height: 4),
                    Text(
                      item.thumbLabel,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _ChipView extends StatelessWidget {
  final _Chip chip;

  const _ChipView({required this.chip});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: chip.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (chip.dot)
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: chip.color,
                shape: BoxShape.circle,
              ),
            )
          else if (chip.icon != null)
            Icon(chip.icon, color: chip.color, size: 15),
          if (chip.dot || chip.icon != null) const SizedBox(width: 5),
          Text(
            chip.text,
            style: TextStyle(
              color: chip.color,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoView extends StatelessWidget {
  final _Info info;

  const _InfoView({required this.info});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(info.icon, color: info.color ?? _textGrey, size: 16),
        const SizedBox(width: 4),
        Text(
          info.text,
          style: TextStyle(
            color: info.color == null ? _textGrey : _navy,
            fontSize: 12.5,
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bookmark_border, color: _hint, size: 54),
            SizedBox(height: 12),
            Text(
              'No saved items found',
              style: TextStyle(
                color: _navy,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Tap the bookmark on any hackathon, internship or course to save it here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: _textGrey, fontSize: 13.5, height: 1.3),
            ),
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(Icons.bookmark_border, color: _blue, size: 30),
        SizedBox(height: 8),
        Text(
          'Your saved items stay here so you can come back anytime.',
          textAlign: TextAlign.center,
          style: TextStyle(color: _blue, fontSize: 13),
        ),
      ],
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
