import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _controller = TextEditingController();
  String _audience = 'Everyone';
  String _type = 'Update';

  static const List<String> _audiences = ['Everyone', 'Campus', 'Companies'];
  static const List<String> _types = [
    'Update',
    'Project',
    'Achievement',
    'Question',
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _canPost => _controller.text.trim().isNotEmpty;

  void _submit() {
    // TODO: save the post (backend / Firebase) using _controller.text,
    // _audience and _type.
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Post shared')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _navy,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ---------- Navy header ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'Create Post',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  _PostButton(enabled: _canPost, onTap: _submit),
                ],
              ),
            ),

            // ---------- White rounded content area ----------
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: _bg,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildUserRow(),
                            const SizedBox(height: 16),
                            _buildTextCard(),
                            const SizedBox(height: 20),
                            const Text(
                              'Post type',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: _navy,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _types.map(_buildTypeChip).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const _AttachmentBar(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserRow() {
    return Row(
      children: [
        // Placeholder avatar. Replace with Image.asset('assets/avatar.png')
        CircleAvatar(
          radius: 22,
          backgroundColor: _blue.withOpacity(0.15),
          child: const Icon(Icons.person, color: _blue),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODO: show the real logged-in student's name
              const Text(
                'Your Name',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _navy,
                ),
              ),
              const SizedBox(height: 4),
              PopupMenuButton<String>(
                onSelected: (value) => setState(() => _audience = value),
                itemBuilder: (context) => _audiences
                    .map((a) => PopupMenuItem<String>(value: a, child: Text(a)))
                    .toList(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.public, size: 14, color: _blue),
                      const SizedBox(width: 4),
                      Text(
                        _audience,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _blue,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down, size: 18, color: _blue),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        minLines: 6,
        maxLines: null,
        maxLength: 500,
        style: const TextStyle(fontSize: 15),
        decoration: const InputDecoration(
          hintText: 'What do you want to share with your campus?',
          hintStyle: TextStyle(color: Colors.black38),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildTypeChip(String label) {
    final bool selected = _type == label;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => setState(() => _type = label),
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

class _PostButton extends StatelessWidget {
  const _PostButton({required this.enabled, required this.onTap});

  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        decoration: BoxDecoration(
          color: enabled ? _blue : Colors.white24,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Post',
          style: TextStyle(
            color: enabled ? Colors.white : Colors.white54,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _AttachmentBar extends StatelessWidget {
  const _AttachmentBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        12,
        10,
        12,
        10 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          // TODO: connect each button (photo picker, etc.) later
          _AttachButton(
            icon: Icons.photo_outlined,
            label: 'Photo',
            onTap: () {},
          ),
          _AttachButton(
            icon: Icons.videocam_outlined,
            label: 'Video',
            onTap: () {},
          ),
          _AttachButton(
            icon: Icons.description_outlined,
            label: 'Document',
            onTap: () {},
          ),
          _AttachButton(icon: Icons.link, label: 'Link', onTap: () {}),
        ],
      ),
    );
  }
}

class _AttachButton extends StatelessWidget {
  const _AttachButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: _blue, size: 24),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(fontSize: 11, color: _navy)),
            ],
          ),
        ),
      ),
    );
  }
}
