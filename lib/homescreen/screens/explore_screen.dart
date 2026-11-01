import 'package:Cradix/homescreen/screens/ai_tools_screen.dart';
import 'package:Cradix/homescreen/screens/courses_screen.dart';
import 'package:Cradix/homescreen/screens/hackathon_buddy_screen.dart';
import 'package:Cradix/homescreen/screens/internship_screen.dart';
import 'package:Cradix/homescreen/screens/jobs_screen.dart';
import 'package:Cradix/homescreen/screens/notifications_screen.dart';
import 'package:Cradix/homescreen/screens/profile_screen.dart';
import 'package:Cradix/homescreen/screens/search_screen.dart';
import 'package:flutter/material.dart';

/// Open it with:
/// Navigator.push(context, MaterialPageRoute(builder: (_) => const ExploreScreen()));
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _E.navy,
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
                color: _E.bg,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
                  children: const [
                    _SearchRow(),
                    SizedBox(height: 14),
                    _CategoryRow(),
                    SizedBox(height: 22),
                    _SectionHeader(
                      icon: Icons.track_changes,
                      title: 'Recommended for You',
                    ),
                    SizedBox(height: 10),
                    _JobsSection(),
                    SizedBox(height: 14),
                    _SectionHeader(
                      icon: Icons.event_note_rounded,
                      title: 'Upcoming Events',
                    ),
                    SizedBox(height: 10),
                    _EventsSection(),
                    SizedBox(height: 14),
                    _SectionHeader(
                      icon: Icons.school_rounded,
                      title: 'Popular Courses',
                    ),
                    SizedBox(height: 10),
                    _CoursesSection(),
                    SizedBox(height: 16),
                    _CareerBanner(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: _E.primary,
        foregroundColor: Colors.white,
        elevation: 6,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const _ExploreBottomBar(),
    );
  }
}

// ---------------- Colors & helpers ----------------

class _E {
  static const primary = Color(0xFF1E63E9);
  static const navy = Color(0xFF0B2E73);
  static const bg = Color(0xFFF5F8FE);
  static const border = Color(0xFFE6EDF8);
  static const textDark = Color(0xFF0B2A6B);
  static const textGrey = Color(0xFF6B7A93);
  static const chipBg = Color(0xFFE3EEFF);
  static const green = Color(0xFF1E9E55);
}

BoxDecoration _card() => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(16),
  border: Border.all(color: _E.border),
  boxShadow: [
    BoxShadow(
      color: const Color(0xFF1E63E9).withOpacity(0.06),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ],
);

class _Tag {
  final String text;
  final Color bg;
  final Color fg;
  const _Tag(this.text, this.bg, this.fg);
}

const _blueTag = [Color(0xFFE3EEFF), Color(0xFF1E63E9)];
const _greenTag = [Color(0xFFDDF6E7), Color(0xFF1E9E55)];
const _purpleTag = [Color(0xFFEDE4FF), Color(0xFF7B3FE4)];
const _greyTag = [Color(0xFFE9EEF7), Color(0xFF4B5C7A)];

class _TagChip extends StatelessWidget {
  final _Tag tag;
  const _TagChip({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: tag.bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tag.text,
        style: TextStyle(
          color: tag.fg,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

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
          padding: const EdgeInsets.fromLTRB(16, 10, 8, 20),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _E.primary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.explore, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explore',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Discover opportunities. Build your future.',
                      style: TextStyle(color: Color(0xFFD5E2FA), fontSize: 12),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SearchScreen()),
                  );
                },
                icon: const Icon(Icons.search, color: Colors.white, size: 26),
              ),
              Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const NotificationsScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.notifications_none_rounded,
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
                        color: Color(0xFFFF3B30),
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
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

// ---------------- Search + location ----------------

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
              border: Border.all(color: _E.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: _E.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SearchScreen()),
                      );
                    },
                    style: const TextStyle(fontSize: 13),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      hintText:
                          'Search jobs, internships, hackathons, courses...',
                      hintStyle: TextStyle(
                        color: _E.textGrey,
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
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: _E.border),
          ),
          child: const Row(
            children: [
              Icon(Icons.location_on, color: _E.primary, size: 20),
              SizedBox(width: 4),
              Text(
                'All Locations',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: _E.textDark,
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: _E.textDark, size: 18),
            ],
          ),
        ),
      ],
    );
  }
}
// ---------------- Categories ----------------

class _Cat {
  final String title, sub;
  final IconData icon;
  final Color color;
  const _Cat(this.title, this.sub, this.icon, this.color);
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow();

  static const _cats = [
    _Cat(
      'Jobs',
      'Full-time & Part-time',
      Icons.work_rounded,
      Color(0xFF1E88E5),
    ),
    _Cat(
      'Internships',
      'Gain Experience',
      Icons.school_rounded,
      Color(0xFF2FB36B),
    ),
    _Cat(
      'Hackathons',
      'Build & Compete',
      Icons.emoji_events_rounded,
      Color(0xFF8E4DFF),
    ),
    _Cat(
      'Courses',
      'Learn New Skills',
      Icons.menu_book_rounded,
      Color(0xFFF59E0B),
    ),
    _Cat(
      'AI Tools',
      'Boost Productivity',
      Icons.smart_toy_rounded,
      Color(0xFF0EA5C6),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 134,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _cats.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) => _CategoryTile(cat: _cats[i]),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final _Cat cat;
  const _CategoryTile({required this.cat});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (cat.title == 'Jobs') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const JobsScreen()),
          );
        } else if (cat.title == 'Internships') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const InternshipsScreen()),
          );
        } else if (cat.title == 'Hackathons') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HackathonBuddyScreen()),
          );
        } else if (cat.title == 'Courses') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CoursesScreen()),
          );
        } else if (cat.title == 'AI Tools') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AiToolsScreen()),
          );
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 104,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        decoration: BoxDecoration(
          color: cat.color.withOpacity(0.10),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cat.color.withOpacity(0.25)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: cat.color.withOpacity(0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(cat.icon, color: cat.color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              cat.title,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: _E.textDark,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              cat.sub,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(fontSize: 10, color: _E.textGrey),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Section header ----------------

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: _E.primary, size: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _E.textDark,
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: const Row(
            children: [
              Text(
                'View All',
                style: TextStyle(
                  color: _E.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward, color: _E.primary, size: 16),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------- Recommended jobs ----------------

class _Job {
  final String logo; // 'google' | 'microsoft' | 'amazon'
  final String title, company, location, deadline;
  final List<_Tag> tags;
  const _Job({
    required this.logo,
    required this.title,
    required this.company,
    required this.location,
    required this.deadline,
    required this.tags,
  });
}

class _JobsSection extends StatelessWidget {
  const _JobsSection();

  static const _jobs = [
    _Job(
      logo: 'google',
      title: 'Frontend Developer Intern',
      company: 'Google',
      location: 'Bengaluru, Remote',
      deadline: 'Apply by Oct 25',
      tags: [
        _Tag('Internship', Color(0xFFE3EEFF), Color(0xFF1E63E9)),
        _Tag('Stipend ₹1.2L/month', Color(0xFFDDF6E7), Color(0xFF1E9E55)),
        _Tag('React', Color(0xFFEDE4FF), Color(0xFF7B3FE4)),
        _Tag('+2', Color(0xFFE9EEF7), Color(0xFF4B5C7A)),
      ],
    ),
    _Job(
      logo: 'microsoft',
      title: 'Software Engineer',
      company: 'Microsoft',
      location: 'Hyderabad, Hybrid',
      deadline: 'Apply by Oct 30',
      tags: [
        _Tag('Full-time', Color(0xFFE3EEFF), Color(0xFF1E63E9)),
        _Tag('₹12-18 LPA', Color(0xFFDDF6E7), Color(0xFF1E9E55)),
        _Tag('Java', Color(0xFFEDE4FF), Color(0xFF7B3FE4)),
        _Tag('+3', Color(0xFFE9EEF7), Color(0xFF4B5C7A)),
      ],
    ),
    _Job(
      logo: 'amazon',
      title: 'ML Intern',
      company: 'Amazon',
      location: 'Bengaluru, On-site',
      deadline: 'Apply by Nov 5',
      tags: [
        _Tag('Internship', Color(0xFFE3EEFF), Color(0xFF1E63E9)),
        _Tag('₹1.5L/month', Color(0xFFDDF6E7), Color(0xFF1E9E55)),
        _Tag('Python', Color(0xFFEDE4FF), Color(0xFF7B3FE4)),
        _Tag('+2', Color(0xFFE9EEF7), Color(0xFF4B5C7A)),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [for (final j in _jobs) _JobCard(job: j)]);
  }
}

class _JobCard extends StatelessWidget {
  final _Job job;
  const _JobCard({required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: _card(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CompanyLogo(kind: job.logo),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.title,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _E.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${job.company}  ·  ${job.location}',
                  style: const TextStyle(fontSize: 12.5, color: _E.textGrey),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [for (final t in job.tags) _TagChip(tag: t)],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 12,
                    color: _E.textGrey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    job.deadline,
                    style: const TextStyle(fontSize: 10.5, color: _E.textGrey),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Icon(
                Icons.bookmark_border_rounded,
                color: _E.primary,
                size: 22,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Placeholder logos. Replace with Image.asset('assets/google.png') etc.
class _CompanyLogo extends StatelessWidget {
  final String kind;
  const _CompanyLogo({required this.kind});

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (kind) {
      case 'google':
        child = const Text(
          'G',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: Color(0xFF4285F4),
          ),
        );
        break;
      case 'microsoft':
        child = SizedBox(
          width: 28,
          height: 28,
          child: GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              ColoredBox(color: Color(0xFFF25022)),
              ColoredBox(color: Color(0xFF7FBA00)),
              ColoredBox(color: Color(0xFF00A4EF)),
              ColoredBox(color: Color(0xFFFFB900)),
            ],
          ),
        );
        break;
      default:
        child = const Text(
          'a',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        );
    }
    return Container(
      width: 56,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _E.border),
      ),
      child: child,
    );
  }
}

// ---------------- Upcoming events ----------------

class _Event {
  final String label, status, title, dateTime, place;
  final Color statusBg, statusFg;
  final List<Color> gradient;
  const _Event({
    required this.label,
    required this.status,
    required this.statusBg,
    required this.statusFg,
    required this.title,
    required this.dateTime,
    required this.place,
    required this.gradient,
  });
}

class _EventsSection extends StatelessWidget {
  const _EventsSection();

  static const _events = [
    _Event(
      label: 'CAMPUS\nHACKATHON\n2026',
      status: 'Registration Open',
      statusBg: Color(0xFFDDF6E7),
      statusFg: Color(0xFF1E9E55),
      title: 'Campus Hackathon 2026',
      dateTime: 'Oct 30  ·  9:00 AM',
      place: 'Main Auditorium',
      gradient: [Color(0xFF0B1F4D), Color(0xFF1B3F8F)],
    ),
    _Event(
      label: 'Tech\nTalk',
      status: 'This Week',
      statusBg: Color(0xFFEDE4FF),
      statusFg: Color(0xFF7B3FE4),
      title: 'Tech Talk with Industry Experts',
      dateTime: 'Nov 2  ·  4:00 PM',
      place: 'Online',
      gradient: [Color(0xFF3B1C8C), Color(0xFFB02FD6)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [for (final e in _events) _EventCard(event: e)]);
  }
}

class _EventCard extends StatelessWidget {
  final _Event event;
  const _EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(8),
      decoration: _card(),
      child: Row(
        children: [
          // Replace with: ClipRRect(child: Image.asset('assets/event1.png', width: 100, height: 84, fit: BoxFit.cover))
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 100,
              height: 84,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: event.gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                event.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: event.statusBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    event.status,
                    style: TextStyle(
                      color: event.statusFg,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _E.textDark,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 13,
                          color: _E.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          event.dateTime,
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: _E.textGrey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: _E.primary,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          event.place,
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: _E.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: _E.primary),
        ],
      ),
    );
  }
}

// ---------------- Popular courses ----------------

class _Course {
  final String title, provider, rating, price, tag;
  final Color tagColor;
  final List<Color> gradient;
  const _Course({
    required this.title,
    required this.provider,
    required this.rating,
    required this.price,
    required this.tag,
    required this.tagColor,
    required this.gradient,
  });
}

class _CoursesSection extends StatelessWidget {
  const _CoursesSection();

  static const _courses = [
    _Course(
      title: 'Web Development',
      provider: 'Coursera',
      rating: '4.8 (12k)',
      price: 'Free',
      tag: 'Popular',
      tagColor: Color(0xFF1E63E9),
      gradient: [Color(0xFF1B2A41), Color(0xFF324A6B)],
    ),
    _Course(
      title: 'Data Science & ML',
      provider: 'Udemy',
      rating: '4.7 (8k)',
      price: '₹1,499',
      tag: 'Trending',
      tagColor: Color(0xFF1E63E9),
      gradient: [Color(0xFF0B3A6B), Color(0xFF1E88E5)],
    ),
    _Course(
      title: 'UI/UX Design',
      provider: 'Coursera',
      rating: '4.6 (5k)',
      price: '₹2,999',
      tag: 'New',
      tagColor: Color(0xFF8E4DFF),
      gradient: [Color(0xFF8E6CF0), Color(0xFFF59E0B)],
    ),
    _Course(
      title: 'Cloud Computing',
      provider: 'Microsoft Learn',
      rating: '4.5 (7k)',
      price: 'Free',
      tag: 'Popular',
      tagColor: Color(0xFF1E63E9),
      gradient: [Color(0xFF0B2E73), Color(0xFF2B7BF2)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 168,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _courses.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) => _CourseCard(course: _courses[i]),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final _Course course;
  const _CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    final isFree = course.price == 'Free';
    return Container(
      width: 170,
      decoration: _card(),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Replace the gradient with Image.asset('assets/course1.png', fit: BoxFit.cover)
          Stack(
            children: [
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: course.gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: course.tagColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    course.tag,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _E.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  course.provider,
                  style: const TextStyle(fontSize: 11.5, color: _E.textGrey),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFF59E0B),
                      size: 15,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      course.rating,
                      style: const TextStyle(fontSize: 11, color: _E.textGrey),
                    ),
                    const Spacer(),
                    Text(
                      course.price,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isFree ? _E.green : _E.textDark,
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

// ---------------- Career banner ----------------

class _CareerBanner extends StatelessWidget {
  const _CareerBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F1FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD3E4FF)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.rocket_launch, color: _E.primary, size: 24),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Take the next step in your career!',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: _E.textDark,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Explore more opportunities, get personalized recommendations and achieve your goals.',
                  style: TextStyle(fontSize: 10, color: _E.textGrey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _E.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Go to Jobs &\nInternships',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, height: 1.15),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Bottom navigation ----------------

class _ExploreBottomBar extends StatelessWidget {
  const _ExploreBottomBar();

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
                // Go back to the home screen
                onTap: () => Navigator.maybePop(context),
              ),
            ),
            Expanded(
              child: _NavItem(
                icon: Icons.explore,
                label: 'Explore',
                active: true,
                onTap: () {},
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
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                ),
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
    final color = active ? _E.primary : _E.textGrey;
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
