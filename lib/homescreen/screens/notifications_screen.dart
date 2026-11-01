import 'package:flutter/material.dart';

// ---------- Colors used on this screen (private to this file) ----------
const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _dark = Color(0xFF0F1F3D);
const Color _grey = Color(0xFF6B7A93);
const Color _border = Color(0xFFE6EDF8);

// ---------- One notification (simple data holder) ----------
class _Notif {
  final int id;
  final String category; // Events / Jobs / Messages / Hackathons / Campus
  final IconData icon;
  final Color color;
  final String title;
  final String body;
  final String time;
  final bool today; // true = shown under "Today", false = under "Earlier"
  bool unread; // changes when the user taps it

  _Notif({
    required this.id,
    required this.category,
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
    required this.time,
    required this.today,
    this.unread = true,
  });
}

// Dummy data. Later you can replace this with real data from your backend.
List<_Notif> _initialItems() {
  return [
    _Notif(
      id: 1,
      category: 'Events',
      icon: Icons.event_rounded,
      color: const Color(0xFF8E4DFF),
      title: 'Campus Hackathon 2026 starts soon',
      body: 'Registration closes today at 6:00 PM. Don\'t miss it!',
      time: '10 min ago',
      today: true,
    ),
    _Notif(
      id: 2,
      category: 'Messages',
      icon: Icons.chat_bubble_rounded,
      color: const Color(0xFF2FB36B),
      title: 'Priya Sharma sent you a message',
      body: 'Hey! Are you joining the coding workshop?',
      time: '25 min ago',
      today: true,
    ),
    _Notif(
      id: 3,
      category: 'Jobs',
      icon: Icons.work_rounded,
      color: const Color(0xFFF59E0B),
      title: 'New internship at Google',
      body: 'Frontend Developer Intern matches your profile.',
      time: '1 h ago',
      today: true,
    ),
    _Notif(
      id: 4,
      category: 'Hackathons',
      icon: Icons.emoji_events_rounded,
      color: const Color(0xFFE5484D),
      title: 'Team request from Rohan Mehta',
      body: 'Rohan wants you on his team for Campus Hackathon.',
      time: '2 h ago',
      today: true,
    ),
    _Notif(
      id: 5,
      category: 'Campus',
      icon: Icons.favorite_rounded,
      color: const Color(0xFF0EA5C6),
      title: 'Aarav Sharma liked your post',
      body: 'Your project post got 24 new likes.',
      time: 'Yesterday',
      today: false,
      unread: false,
    ),
    _Notif(
      id: 6,
      category: 'Jobs',
      icon: Icons.work_rounded,
      color: const Color(0xFFF59E0B),
      title: 'Application update: Microsoft',
      body: 'Your application moved to Under Review.',
      time: 'Yesterday',
      today: false,
    ),
    _Notif(
      id: 7,
      category: 'Events',
      icon: Icons.event_rounded,
      color: const Color(0xFF8E4DFF),
      title: 'TCS Virtual Info Session',
      body: 'Reminder: Oct 28, 4:00 PM. Join from the Companies tab.',
      time: '2 days ago',
      today: false,
      unread: false,
    ),
    _Notif(
      id: 8,
      category: 'Campus',
      icon: Icons.campaign_rounded,
      color: const Color(0xFF0EA5C6),
      title: 'Placement Drive Registration Open',
      body: 'The Training & Placement Cell posted a new update.',
      time: '3 days ago',
      today: false,
      unread: false,
    ),
  ];
}

// =====================================================================
//                         NOTIFICATIONS SCREEN
// =====================================================================
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  static const List<String> _filters = [
    'All',
    'Unread',
    'Events',
    'Jobs',
    'Messages',
    'Hackathons',
    'Campus',
  ];

  int _filter = 0; // selected chip
  late List<_Notif> _items;

  @override
  void initState() {
    super.initState();
    _items = _initialItems();
  }

  // Notifications that match the selected chip
  List<_Notif> _visible() {
    if (_filter == 0) return _items;
    if (_filter == 1) return _items.where((n) => n.unread).toList();
    return _items.where((n) => n.category == _filters[_filter]).toList();
  }

  void _markAllRead() {
    setState(() {
      for (final n in _items) {
        n.unread = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<_Notif> visible = _visible();
    final List<_Notif> today = visible.where((n) => n.today).toList();
    final List<_Notif> earlier = visible.where((n) => !n.today).toList();
    final int unreadCount = _items.where((n) => n.unread).length;

    return Scaffold(
      backgroundColor: _navy,
      body: Column(
        children: [
          _Header(
            unreadCount: unreadCount,
            onBack: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  // ---------- Filter chips (scroll sideways) ----------
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, i) {
                        final bool on = i == _filter;
                        return InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => setState(() => _filter = i),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: on ? _blue : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: on ? _blue : _border),
                            ),
                            child: Text(
                              _filters[i],
                              style: TextStyle(
                                color: on ? Colors.white : _dark,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.5,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),

                  // ---------- "N new" + Mark all as read ----------
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 4, 12, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            unreadCount == 0
                                ? 'No new notifications'
                                : '$unreadCount new',
                            style: const TextStyle(
                              color: _grey,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: unreadCount == 0 ? null : _markAllRead,
                          child: const Text(
                            'Mark all as read',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ---------- The list ----------
                  Expanded(
                    child: visible.isEmpty
                        ? const _EmptyState()
                        : ListView(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                            children: [
                              if (today.isNotEmpty) ...[
                                const _GroupTitle('Today'),
                                for (final n in today) _buildTile(n),
                              ],
                              if (earlier.isNotEmpty) ...[
                                const _GroupTitle('Earlier'),
                                for (final n in earlier) _buildTile(n),
                              ],
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // One notification row. Swipe left to delete it, tap to mark as read.
  Widget _buildTile(_Notif n) {
    return Dismissible(
      key: ValueKey(n.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(right: 22),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: const Color(0xFFE5484D),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      onDismissed: (_) {
        setState(() => _items.removeWhere((x) => x.id == n.id));
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Notification removed')));
      },
      child: _NotifTile(
        notif: n,
        onTap: () {
          // Mark as read
          setState(() => n.unread = false);
          // TODO: open the page that this notification is about
        },
      ),
    );
  }
}

// =====================================================================
//                              HEADER
// =====================================================================
class _Header extends StatelessWidget {
  final int unreadCount;
  final VoidCallback onBack;

  const _Header({required this.unreadCount, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
        child: Row(
          children: [
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    unreadCount == 0
                        ? 'You\'re all caught up'
                        : '$unreadCount unread',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// "Today" / "Earlier" label
class _GroupTitle extends StatelessWidget {
  final String text;

  const _GroupTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 8, bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: _navy,
        ),
      ),
    );
  }
}

// =====================================================================
//                         ONE NOTIFICATION ROW
// =====================================================================
class _NotifTile extends StatelessWidget {
  final _Notif notif;
  final VoidCallback onTap;

  const _NotifTile({required this.notif, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        // Unread rows have a light blue background
        color: notif.unread ? const Color(0xFFF0F6FF) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: notif.unread ? const Color(0xFFD3E4FF) : _border,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: notif.color.withOpacity(0.14),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(notif.icon, color: notif.color, size: 22),
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
                              notif.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: _dark,
                                fontSize: 14,
                                fontWeight: notif.unread
                                    ? FontWeight.bold
                                    : FontWeight.w600,
                              ),
                            ),
                          ),
                          if (notif.unread) ...[
                            const SizedBox(width: 8),
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              width: 9,
                              height: 9,
                              decoration: const BoxDecoration(
                                color: _blue,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        notif.body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _grey,
                          fontSize: 12.5,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notif.time,
                        style: const TextStyle(color: _grey, fontSize: 11.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Shown when no notification matches the selected chip
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.notifications_off_outlined, color: _grey, size: 52),
          SizedBox(height: 10),
          Text(
            'No notifications here',
            style: TextStyle(
              color: _dark,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'You\'re all caught up.',
            style: TextStyle(color: _grey, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
