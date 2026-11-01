import 'package:Cradix/homescreen/screens/chat_detail_screen.dart';
import 'package:Cradix/homescreen/screens/create_post_screen.dart';
import 'package:Cradix/homescreen/screens/explore_screen.dart';
import 'package:Cradix/homescreen/screens/profile_screen.dart';
import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);
const Color _grey = Color(0xFF6B7A93);
const Color _green = Color(0xFF2FB36B);
const Color _purple = Color(0xFF7E3FE4);

class _Chat {
  final String name;
  final String type; // Recruiter, Student or Group
  final String lastMessage;
  final String time;
  final bool online;
  int unread;

  _Chat({
    required this.name,
    required this.type,
    required this.lastMessage,
    required this.time,
    this.online = false,
    this.unread = 0,
  });
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // TODO: load the real chats from the backend later.
  // These are only sample chats.
  final List<_Chat> _chats = [
    _Chat(
      name: 'TCS Campus Hiring',
      type: 'Recruiter',
      lastMessage: 'Your profile looks great. Can we schedule a call?',
      time: '10:33 AM',
      online: true,
      unread: 2,
    ),
    _Chat(
      name: 'Aarav Sharma',
      type: 'Student',
      lastMessage: 'Are you joining the hackathon this weekend?',
      time: '9:12 AM',
      online: true,
      unread: 1,
    ),
    _Chat(
      name: 'Hackathon Buddy Team',
      type: 'Group',
      lastMessage: 'Riya: I will share the project idea tonight.',
      time: 'Yesterday',
    ),
    _Chat(
      name: 'Infosys HR',
      type: 'Recruiter',
      lastMessage: 'Thank you for applying. We will get back to you soon.',
      time: 'Yesterday',
    ),
    _Chat(
      name: 'Riya Verma',
      type: 'Student',
      lastMessage: 'Thanks for sharing the notes!',
      time: 'Mon',
    ),
  ];

  final TextEditingController _search = TextEditingController();
  int _filter = 0; // 0 All, 1 Unread, 2 Recruiters, 3 Students

  @override
  void initState() {
    super.initState();
    _search.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  int get _totalUnread => _chats.fold(0, (sum, chat) => sum + chat.unread);

  List<_Chat> get _visible {
    final String query = _search.text.trim().toLowerCase();
    return _chats.where((chat) {
      final bool matchesSearch =
          query.isEmpty || chat.name.toLowerCase().contains(query);
      final bool matchesFilter =
          _filter == 0 ||
          (_filter == 1 && chat.unread > 0) ||
          (_filter == 2 && chat.type == 'Recruiter') ||
          (_filter == 3 && chat.type == 'Student');
      return matchesSearch && matchesFilter;
    }).toList();
  }

  Future<void> _open(_Chat chat) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDetailScreen(
          name: chat.name,
          subtitle: chat.type,
          online: chat.online,
        ),
      ),
    );
    if (!mounted) return;
    setState(() => chat.unread = 0);
  }

  @override
  Widget build(BuildContext context) {
    final List<_Chat> visible = _visible;

    return Scaffold(
      backgroundColor: _navy,
      extendBody: true,
      body: Column(
        children: [
          // ---------- Navy header ----------
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 8, 18),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chats',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Talk to recruiters and students',
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
                      // TODO: start a new chat
                    },
                    icon: const Icon(
                      Icons.edit_square,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ---------- Content ----------
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: _bg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _search,
                          decoration: InputDecoration(
                            hintText: 'Search chats',
                            hintStyle: const TextStyle(color: Colors.black38),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.black38,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _filterChip('All', 0),
                            _filterChip('Unread', 1),
                            _filterChip('Recruiters', 2),
                            _filterChip('Students', 3),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  Expanded(
                    child: visible.isEmpty
                        ? const _EmptyState()
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 110),
                            itemCount: visible.length,
                            itemBuilder: (context, index) {
                              final _Chat chat = visible[index];
                              return _ChatTile(
                                chat: chat,
                                onTap: () => _open(chat),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePostScreen()),
          );
        },
        backgroundColor: _blue,
        foregroundColor: Colors.white,
        elevation: 6,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _ChatBottomBar(badge: _totalUnread),
    );
  }

  Widget _filterChip(String label, int value) {
    final bool selected = _filter == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      showCheckmark: false,
      onSelected: (_) => setState(() => _filter = value),
      selectedColor: _blue,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: selected ? Colors.white : _navy,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
      side: BorderSide(color: selected ? _blue : Colors.black12),
    );
  }
}

class _ChatTile extends StatelessWidget {
  const _ChatTile({required this.chat, required this.onTap});

  final _Chat chat;
  final VoidCallback onTap;

  IconData get _icon {
    switch (chat.type) {
      case 'Recruiter':
        return Icons.business_center_rounded;
      case 'Group':
        return Icons.groups_rounded;
      default:
        return Icons.person;
    }
  }

  Color get _color {
    switch (chat.type) {
      case 'Recruiter':
        return _blue;
      case 'Group':
        return _purple;
      default:
        return const Color(0xFF14A38B);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasUnread = chat.unread > 0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              // Placeholder avatar. Replace with Image.asset('assets/avatar.png')
              Stack(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: _color.withOpacity(0.14),
                    child: Icon(_icon, color: _color, size: 24),
                  ),
                  if (chat.online)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 13,
                        height: 13,
                        decoration: BoxDecoration(
                          color: _green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            chat.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: _navy,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            chat.type,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      chat.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: hasUnread ? _navy : _grey,
                        fontWeight: hasUnread
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    chat.time,
                    style: TextStyle(
                      fontSize: 11,
                      color: hasUnread ? _blue : _grey,
                      fontWeight: hasUnread ? FontWeight.w700 : FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (hasUnread)
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: _blue,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${chat.unread}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  else
                    const SizedBox(height: 22),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.chat_bubble_outline, size: 56, color: Colors.black26),
            SizedBox(height: 12),
            Text(
              'No chats found',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: _navy,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Try a different search or filter.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.5, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Bottom navigation ----------------

class _ChatBottomBar extends StatelessWidget {
  const _ChatBottomBar({required this.badge});

  final int badge;

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
                icon: Icons.chat_bubble,
                label: 'Chat',
                badge: badge,
                active: true,
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
  const _NavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
    this.badge = 0,
  });

  final IconData icon;
  final String label;
  final bool active;
  final int badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color color = active ? _blue : _grey;
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
