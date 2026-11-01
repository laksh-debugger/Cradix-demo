import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  String _query = '';
  String _filter = 'All';

  final List<String> _filters = const [
    'All',
    'Internships',
    'Hackathons',
    'Companies',
    'Students',
    'Events',
  ];

  final List<String> _recent = ['Flutter internship', 'Google', 'Hackathon'];

  final List<String> _trending = const [
    'Software Intern',
    'AI Hackathon',
    'Data Analyst',
    'Campus Placement',
    'Resume Tips',
  ];

  // Sample data. TODO: replace with real search results from your backend.
  final List<_Item> _items = const [
    _Item('Flutter Developer Intern', 'Remote - 3 months', 'Internships'),
    _Item('Data Analyst Intern', 'Bengaluru - 6 months', 'Internships'),
    _Item('UI/UX Design Intern', 'Hybrid - 2 months', 'Internships'),
    _Item('Smart India Hackathon', 'Team of 4 - Open now', 'Hackathons'),
    _Item('AI Innovation Challenge', 'Online - Starts next week', 'Hackathons'),
    _Item('Google', 'Technology - 12 openings', 'Companies'),
    _Item('Infosys', 'IT Services - 8 openings', 'Companies'),
    _Item('TCS', 'IT Services - 15 openings', 'Companies'),
    _Item('Aarav Sharma', 'B.Tech CSE - 3rd year', 'Students'),
    _Item('Priya Singh', 'B.Tech IT - 2nd year', 'Students'),
    _Item('Campus Placement Drive', 'Main auditorium - Friday', 'Events'),
    _Item('Resume Workshop', 'Seminar hall - Saturday', 'Events'),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<_Item> get _results {
    final String q = _query.trim().toLowerCase();
    return _items.where((i) {
      final bool matchFilter = _filter == 'All' || i.type == _filter;
      final bool matchText =
          i.title.toLowerCase().contains(q) ||
          i.subtitle.toLowerCase().contains(q);
      return matchFilter && matchText;
    }).toList();
  }

  void _search(String text) {
    _controller.text = text;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: text.length),
    );
    setState(() => _query = text);
  }

  void _saveRecent(String text) {
    final String t = text.trim();
    if (t.isEmpty) return;
    setState(() {
      _recent.remove(t);
      _recent.insert(0, t);
      if (_recent.length > 6) _recent.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool searching = _query.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: _navy,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  Expanded(
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextField(
                        controller: _controller,
                        autofocus: true,
                        textInputAction: TextInputAction.search,
                        onChanged: (v) => setState(() => _query = v),
                        onSubmitted: _saveRecent,
                        decoration: InputDecoration(
                          hintText: 'Search internships, companies, people...',
                          hintStyle: const TextStyle(
                            fontSize: 13,
                            color: Colors.black45,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black45,
                          ),
                          suffixIcon: searching
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.black45,
                                    size: 20,
                                  ),
                                  onPressed: () => _search(''),
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
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
                  SizedBox(
                    height: 38,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filters.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final String f = _filters[index];
                        final bool selected = f == _filter;
                        return ChoiceChip(
                          label: Text(f),
                          selected: selected,
                          showCheckmark: false,
                          selectedColor: _blue,
                          backgroundColor: _bg,
                          labelStyle: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: selected ? Colors.white : _navy,
                          ),
                          onSelected: (_) => setState(() => _filter = f),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: searching ? _buildResults() : _buildSuggestions(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      children: [
        if (_recent.isNotEmpty) ...[
          Row(
            children: [
              const Expanded(child: _SectionTitle('Recent searches')),
              TextButton(
                onPressed: () => setState(() => _recent.clear()),
                child: const Text(
                  'Clear all',
                  style: TextStyle(color: _blue, fontSize: 12.5),
                ),
              ),
            ],
          ),
          for (final String r in _recent)
            InkWell(
              onTap: () => _search(r),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 4,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.history, color: Colors.black45, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(r, style: const TextStyle(fontSize: 14)),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _recent.remove(r)),
                      child: const Icon(
                        Icons.close,
                        color: Colors.black38,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 20),
        ],
        const _SectionTitle('Trending now'),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _trending
              .map(
                (t) => ActionChip(
                  avatar: const Icon(Icons.trending_up, size: 16, color: _blue),
                  label: Text(t),
                  backgroundColor: _bg,
                  labelStyle: const TextStyle(fontSize: 12.5, color: _navy),
                  onPressed: () => _search(t),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildResults() {
    final List<_Item> results = _results;

    if (results.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.search_off, size: 56, color: Colors.black26),
              SizedBox(height: 12),
              Text(
                'No results found',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Text(
                'Try different words or another filter.',
                style: TextStyle(fontSize: 12.5, color: Colors.black54),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: results.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final _Item item = results[index];
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            _saveRecent(_query);
            // TODO: open the details page for this result
          },
          child: Container(
            padding: const EdgeInsets.all(12),
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
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _blue.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // Placeholder icon. Put Image.asset here for logos or photos.
                  child: Icon(_iconFor(item.type), color: _blue, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _bg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    item.type,
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: _navy,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _iconFor(String type) {
    switch (type) {
      case 'Internships':
        return Icons.work_outline;
      case 'Hackathons':
        return Icons.emoji_events_outlined;
      case 'Companies':
        return Icons.business;
      case 'Students':
        return Icons.person_outline;
      default:
        return Icons.event_outlined;
    }
  }
}

class _Item {
  final String title;
  final String subtitle;
  final String type;

  const _Item(this.title, this.subtitle, this.type);
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 6),
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
