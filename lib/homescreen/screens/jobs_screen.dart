import 'package:flutter/material.dart';

// Same folder (lib/homescreen/screens/) so no extra path needed.
import 'profile_screen.dart';

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

// ---------- One job (simple data holder) ----------
class _Job {
  final int logo; // 0 Google, 1 Microsoft, 2 Amazon, 3 Infosys, 4 TCS
  final String title;
  final String company;
  final String location;
  final String mode; // Remote / Hybrid / On-site
  final String type; // Full-time / Part-time
  final String salary;
  final List<String> skills;
  final String applyBy;

  const _Job({
    required this.logo,
    required this.title,
    required this.company,
    required this.location,
    required this.mode,
    required this.type,
    required this.salary,
    required this.skills,
    required this.applyBy,
  });
}

// Dummy data. Later you can replace this with real data from your backend.
const List<_Job> _allJobs = [
  _Job(
    logo: 1,
    title: 'Software Engineer',
    company: 'Microsoft',
    location: 'Hyderabad',
    mode: 'Hybrid',
    type: 'Full-time',
    salary: '₹12-18 LPA',
    skills: ['Java', 'DSA', 'System Design', 'SQL'],
    applyBy: 'Oct 30',
  ),
  _Job(
    logo: 0,
    title: 'Frontend Developer',
    company: 'Google',
    location: 'Bengaluru',
    mode: 'Remote',
    type: 'Full-time',
    salary: '₹15-24 LPA',
    skills: ['React', 'JavaScript', 'CSS'],
    applyBy: 'Nov 2',
  ),
  _Job(
    logo: 2,
    title: 'SDE I',
    company: 'Amazon',
    location: 'Bengaluru',
    mode: 'On-site',
    type: 'Full-time',
    salary: '₹18-26 LPA',
    skills: ['Java', 'Python', 'DSA', 'AWS'],
    applyBy: 'Nov 5',
  ),
  _Job(
    logo: 3,
    title: 'Systems Engineer',
    company: 'Infosys',
    location: 'Pune',
    mode: 'Hybrid',
    type: 'Full-time',
    salary: '₹4-6 LPA',
    skills: ['Java', 'SQL'],
    applyBy: 'Nov 8',
  ),
  _Job(
    logo: 4,
    title: 'Support Analyst',
    company: 'TCS',
    location: 'Remote',
    mode: 'Remote',
    type: 'Part-time',
    salary: '₹30K/month',
    skills: ['Communication', 'Excel'],
    applyBy: 'Nov 10',
  ),
];

// =====================================================================
//                             JOBS SCREEN
// =====================================================================
class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  static const List<String> _filters = [
    'All',
    'Full-time',
    'Part-time',
    'Remote',
    'Hybrid',
    'On-site',
  ];

  int _filter = 0; // selected chip
  String _query = ''; // text typed in the search box
  final Set<int> _saved = {}; // bookmarked job numbers (index in _allJobs)

  // Returns the jobs that match the chip + the search text
  List<int> _visibleJobs() {
    final List<int> result = [];
    for (int i = 0; i < _allJobs.length; i++) {
      final _Job job = _allJobs[i];

      bool passesFilter = true;
      if (_filter == 1) passesFilter = job.type == 'Full-time';
      if (_filter == 2) passesFilter = job.type == 'Part-time';
      if (_filter == 3) passesFilter = job.mode == 'Remote';
      if (_filter == 4) passesFilter = job.mode == 'Hybrid';
      if (_filter == 5) passesFilter = job.mode == 'On-site';

      final String text =
          '${job.title} ${job.company} ${job.location} ${job.skills.join(' ')}'
              .toLowerCase();
      final bool passesSearch = text.contains(_query.toLowerCase().trim());

      if (passesFilter && passesSearch) result.add(i);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final List<int> visible = _visibleJobs();

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
                  color: const Color(0xFFF7F9FE),
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                    children: [
                      // ---------- Search box ----------
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: _border),
                          boxShadow: _softShadow,
                        ),
                        child: TextField(
                          onChanged: (value) => setState(() => _query = value),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search, color: _navy),
                            hintText: 'Search role, company or skill',
                            hintMaxLines: 1,
                            hintStyle: TextStyle(color: _grey, fontSize: 13),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // ---------- Filter chips (scroll sideways) ----------
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _filters.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 10),
                          itemBuilder: (context, i) {
                            final bool on = i == _filter;
                            return InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () => setState(() => _filter = i),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: on ? _blue : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: on ? _blue : _border,
                                  ),
                                  boxShadow: on ? null : _softShadow,
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
                      const SizedBox(height: 16),

                      // ---------- Banner ----------
                      const _MatchBanner(),
                      const SizedBox(height: 18),

                      // ---------- Section title ----------
                      Row(
                        children: [
                          const Icon(
                            Icons.work_rounded,
                            color: _blue,
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${visible.length} jobs for you',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: _dark,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // TODO: open sort options
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Latest',
                                  style: TextStyle(
                                    color: _blue,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: _blue,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // ---------- Job cards ----------
                      if (visible.isEmpty)
                        const _EmptyState()
                      else
                        for (final int i in visible)
                          _JobCard(
                            job: _allJobs[i],
                            saved: _saved.contains(i),
                            onSave: () => setState(() {
                              if (_saved.contains(i)) {
                                _saved.remove(i);
                              } else {
                                _saved.add(i);
                              }
                            }),
                            onApply: () {
                              // TODO: open the job details / apply page
                            },
                          ),
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

      // ---------- Bottom bar (Explore is highlighted) ----------
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
                  onTap: () =>
                      Navigator.of(context).popUntil((route) => route.isFirst),
                ),
              ),
              Expanded(
                child: _NavItem(
                  icon: Icons.explore_outlined,
                  label: 'Explore',
                  selected: true,
                  // We came from Explore, so going back = Explore tab
                  onTap: () => Navigator.maybePop(context),
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
                        'Jobs',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Full-time & part-time roles, picked for you.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
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
//                           BANNER CARD
// =====================================================================
class _MatchBanner extends StatelessWidget {
  const _MatchBanner();

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
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Land your first full-time role',
                  style: TextStyle(
                    color: _navy,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Keep your passport and portfolio updated to get better matches.',
                  style: TextStyle(color: _dark, fontSize: 12.5),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: Color(0xFFD6E6FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.business_center_rounded,
              color: _blue,
              size: 34,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//                            ONE JOB CARD
// =====================================================================
class _JobCard extends StatelessWidget {
  final _Job job;
  final bool saved;
  final VoidCallback onSave;
  final VoidCallback onApply;

  const _JobCard({
    required this.job,
    required this.saved,
    required this.onSave,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    // Show at most 2 skills and then "+N"
    final List<String> shown = job.skills.take(2).toList();
    final int extra = job.skills.length - shown.length;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
        boxShadow: _softShadow,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Logo(job.logo),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _dark,
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${job.company} · ${job.location}, ${job.mode}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: _grey, fontSize: 12.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              InkWell(
                onTap: onSave,
                child: Icon(
                  saved ? Icons.bookmark : Icons.bookmark_border,
                  color: saved ? _blue : _grey,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Wrap = moves tags to the next line when there is no space
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _Chip(job.type, const Color(0xFFE3EEFF), _blue),
                _Chip(job.salary, const Color(0xFFD7F5E1), _green),
                for (final String s in shown)
                  _Chip(s, const Color(0xFFEDE7FF), const Color(0xFF6D4AD8)),
                if (extra > 0) _Chip('+$extra', const Color(0xFFEEF1F6), _grey),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.event_outlined, color: _grey, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Apply by ${job.applyBy}',
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

class _Chip extends StatelessWidget {
  final String text;
  final Color bg;
  final Color fg;

  const _Chip(this.text, this.bg, this.fg);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fg,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// Company logo placeholders (simple drawings)
// TODO: replace each with Image.asset('assets/images/<company>.png')
class _Logo extends StatelessWidget {
  final int logo; // 0 Google, 1 Microsoft, 2 Amazon, 3 Infosys, 4 TCS

  const _Logo(this.logo);

  Widget _inner() {
    if (logo == 0) {
      return const Text(
        'G',
        style: TextStyle(
          color: Color(0xFF4285F4),
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    if (logo == 1) {
      return const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Sq(Color(0xFFF25022)),
              SizedBox(width: 2),
              _Sq(Color(0xFF7FBA00)),
            ],
          ),
          SizedBox(height: 2),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Sq(Color(0xFF00A4EF)),
              SizedBox(width: 2),
              _Sq(Color(0xFFFFB900)),
            ],
          ),
        ],
      );
    }
    if (logo == 2) {
      return const Text(
        'a',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    if (logo == 3) {
      return const Text(
        'Infosys',
        style: TextStyle(
          color: Color(0xFF1E63E9),
          fontSize: 10.5,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    return const Text(
      'tcs',
      style: TextStyle(
        color: Color(0xFFE4572E),
        fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border),
      ),
      child: _inner(),
    );
  }
}

class _Sq extends StatelessWidget {
  final Color color;

  const _Sq(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(width: 12, height: 12, color: color);
  }
}

// Shown when no job matches the search / filter
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Icon(Icons.search_off_rounded, color: _grey, size: 48),
          SizedBox(height: 10),
          Text(
            'No jobs found',
            style: TextStyle(
              color: _dark,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Try a different search or filter.',
            style: TextStyle(color: _grey, fontSize: 13),
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
