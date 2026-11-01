import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);

class AboutMeScreen extends StatefulWidget {
  const AboutMeScreen({super.key});

  @override
  State<AboutMeScreen> createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen> {
  // TODO: load these from the real logged-in user later.
  final TextEditingController _intro = TextEditingController();
  final TextEditingController _goals = TextEditingController();
  final TextEditingController _interestInput = TextEditingController();
  final TextEditingController _linkedin = TextEditingController();
  final TextEditingController _github = TextEditingController();
  final TextEditingController _portfolio = TextEditingController();

  final List<String> _interests = ['Flutter', 'Web Development', 'AI'];
  final Set<String> _lookingFor = {'Internship'};

  static const List<String> _lookingForOptions = [
    'Internship',
    'Full-time Job',
    'Hackathon Team',
    'Mentorship',
    'Freelance',
  ];

  @override
  void dispose() {
    _intro.dispose();
    _goals.dispose();
    _interestInput.dispose();
    _linkedin.dispose();
    _github.dispose();
    _portfolio.dispose();
    super.dispose();
  }

  void _addInterest() {
    final String value = _interestInput.text.trim();
    if (value.isEmpty ||
        _interests.contains(value) ||
        _interests.length >= 10) {
      return;
    }
    setState(() {
      _interests.add(value);
      _interestInput.clear();
    });
  }

  void _save() {
    // TODO: save the changes (backend / Firebase).
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('About Me updated')));
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
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'About Me',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ---------- Content ----------
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
                          children: [
                            _SectionCard(
                              title: 'Introduction',
                              subtitle: 'Tell people who you are',
                              icon: Icons.person_outline,
                              child: TextField(
                                controller: _intro,
                                minLines: 4,
                                maxLines: null,
                                maxLength: 300,
                                decoration: _inputDecoration(
                                  hint: 'Example: I am a 3rd year B.Tech student who loves building apps.',
                                ),
                              ),
                            ),
                            _SectionCard(
                              title: 'Career Goals',
                              subtitle: 'What do you want to achieve?',
                              icon: Icons.flag_outlined,
                              child: TextField(
                                controller: _goals,
                                minLines: 3,
                                maxLines: null,
                                maxLength: 200,
                                decoration: _inputDecoration(
                                  hint: 'Example: I want to become a mobile app developer.',
                                ),
                              ),
                            ),
                            _buildInterestsCard(),
                            _buildLookingForCard(),
                            _SectionCard(
                              title: 'Social Links',
                              subtitle: 'Let recruiters find your work',
                              icon: Icons.link,
                              child: Column(
                                children: [
                                  TextField(
                                    controller: _linkedin,
                                    keyboardType: TextInputType.url,
                                    decoration: _inputDecoration(
                                      hint: 'LinkedIn profile link',
                                      icon: Icons.business_center_outlined,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextField(
                                    controller: _github,
                                    keyboardType: TextInputType.url,
                                    decoration: _inputDecoration(
                                      hint: 'GitHub profile link',
                                      icon: Icons.code,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextField(
                                    controller: _portfolio,
                                    keyboardType: TextInputType.url,
                                    decoration: _inputDecoration(
                                      hint: 'Portfolio website link',
                                      icon: Icons.language,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _SaveBar(onSave: _save),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestsCard() {
    return _SectionCard(
      title: 'Interests',
      subtitle: 'Add up to 10 topics you like',
      icon: Icons.favorite_border,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_interests.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _interests
                  .map(
                    (item) => InputChip(
                      label: Text(item),
                      labelStyle: const TextStyle(
                        color: _blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      backgroundColor: _blue.withOpacity(0.1),
                      side: BorderSide.none,
                      deleteIconColor: _blue,
                      onDeleted: () => setState(() => _interests.remove(item)),
                    ),
                  )
                  .toList(),
            ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _interestInput,
                  onSubmitted: (_) => _addInterest(),
                  decoration: _inputDecoration(hint: 'Type an interest'),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: _addInterest,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 22),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLookingForCard() {
    return _SectionCard(
      title: 'Looking For',
      subtitle: 'Choose what you are open to',
      icon: Icons.search,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: _lookingForOptions.map((option) {
          final bool selected = _lookingFor.contains(option);
          return FilterChip(
            label: Text(option),
            selected: selected,
            showCheckmark: false,
            onSelected: (value) {
              setState(() {
                if (value) {
                  _lookingFor.add(option);
                } else {
                  _lookingFor.remove(option);
                }
              });
            },
            selectedColor: _blue,
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: selected ? Colors.white : _navy,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            side: BorderSide(color: selected ? _blue : Colors.black12),
          );
        }).toList(),
      ),
    );
  }
}

InputDecoration _inputDecoration({required String hint, IconData? icon}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: Colors.black38, fontSize: 13),
    prefixIcon: icon == null ? null : Icon(icon, color: _blue, size: 20),
    filled: true,
    fillColor: _bg,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _blue, width: 1.5),
    ),
  );
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.child,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: _blue, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _navy,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _SaveBar extends StatelessWidget {
  const _SaveBar({required this.onSave});

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        12 + MediaQuery.of(context).padding.bottom,
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
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: _blue,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Text(
            'Save Changes',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
