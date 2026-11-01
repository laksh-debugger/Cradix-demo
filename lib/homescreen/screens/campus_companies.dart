import 'package:Cradix/homescreen/screens/internship_screen.dart';
import 'package:flutter/material.dart';

// ---------- Colors used in this file (private to this file) ----------
const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _dark = Color(0xFF0F1F3D);
const Color _grey = Color(0xFF6B7A93);
const Color _border = Color(0xFFE6EDF8);
const Color _chipBg = Color(0xFFE3EEFF);
const Color _green = Color(0xFF12A150);
const Color _purple = Color(0xFF7C4DFF);
const Color _orange = Color(0xFFF59E0B);
const Color _lightBlue = Color(0xFF1E88E5);

final List<BoxShadow> _softShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.05),
    blurRadius: 10,
    offset: const Offset(0, 3),
  ),
];

// Which company logo to draw
enum _Brand { google, microsoft, tcs, amazon, infosys, linkedin, deloitte }

// =====================================================================
//     CAMPUS COMPANIES VIEW  (shown when the "Companies" tab is picked)
// =====================================================================
class CampusCompaniesView extends StatelessWidget {
  const CampusCompaniesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _TcsBanner(),
        const SizedBox(height: 14),

        // ---------- Company Updates ----------
        _Section(
          icon: Icons.apartment_rounded,
          title: 'Company Updates',
          onViewAll: () {
            // TODO: open all company updates
          },
          children: const [
            _FeedItem(
              brand: _Brand.google,
              tag: 'Company Update',
              tagColor: _purple,
              time: '2h ago',
              company: 'Google',
              role: 'New Office in Bengaluru',
              description:
                  'Google announces the launch of a new development center in '
                  'Bengaluru, creating exciting opportunities for students and '
                  'freshers.',
              chips: ['Bengaluru', 'Tech', 'Career Growth'],
            ),
            _FeedItem(
              brand: _Brand.microsoft,
              tag: 'Official Update',
              tagColor: _orange,
              time: '5h ago',
              company: 'Microsoft',
              role: 'Campus Hiring Drive 2026',
              description:
                  'Applications open for Software Engineer Intern and Full Time '
                  'roles. Visit our careers page for more details.',
              chips: ['Internship', 'Full Time', 'On-site / Hybrid'],
              last: true,
            ),
          ],
        ),

        // ---------- Hiring & Internship Alerts ----------
        _Section(
          icon: Icons.work_rounded,
          title: 'Hiring & Internship Alerts',
          onViewAll: () {
            // TODO: open all hiring alerts
          },
          children: const [
            _FeedItem(
              brand: _Brand.amazon,
              tag: 'Hiring Now',
              tagColor: _green,
              time: '1h ago',
              company: 'Amazon',
              role: 'SDE Intern (Summer 2026)',
              info: _InfoRow([
                _Info(Icons.payments_outlined, '₹50,000 – 1,00,000 / month'),
                _Info(Icons.calendar_today_outlined, '8 weeks'),
                _Info(Icons.location_on_outlined, 'Bengaluru'),
              ]),
              chips: ['Python', 'Java', 'DSA', 'Problem Solving'],
            ),
            _FeedItem(
              brand: _Brand.infosys,
              tag: 'Internship',
              tagColor: _lightBlue,
              time: '3h ago',
              company: 'Infosys',
              role: 'Systems Engineer Intern',
              info: _InfoRow([
                _Info(Icons.payments_outlined, '₹25,000 – 45,000 / month'),
                _Info(Icons.calendar_today_outlined, '6 months'),
                _Info(Icons.location_on_outlined, 'PAN India'),
              ]),
              chips: ['Java', 'SQL', 'Communication'],
              last: true,
            ),
          ],
        ),

        // ---------- Career Sessions & Webinars ----------
        _Section(
          icon: Icons.mic_rounded,
          title: 'Career Sessions & Webinars',
          onViewAll: () {
            // TODO: open all webinars
          },
          children: const [
            _FeedItem(
              brand: _Brand.linkedin,
              tag: 'Webinar',
              tagColor: _purple,
              time: '4h ago',
              company: 'LinkedIn',
              role: 'Resume Building Workshop',
              description:
                  'Learn how to create a winning resume and stand out.',
              info: _InfoRow([
                _Info(Icons.calendar_today_outlined, 'Oct 29 · 5:00 PM'),
                _Info(Icons.location_on_outlined, 'Online'),
              ]),
              last: true,
            ),
          ],
        ),

        // ---------- Company Challenges ----------
        _Section(
          icon: Icons.emoji_events_rounded,
          title: 'Company Challenges',
          onViewAll: () {
            // TODO: open all challenges
          },
          children: const [
            _FeedItem(
              brand: _Brand.deloitte,
              tag: 'Challenge',
              tagColor: _lightBlue,
              time: '1d ago',
              company: 'Deloitte',
              role: 'GenAI Challenge 2025',
              description: 'Solve real-world problems and win exciting prizes.',
              chips: ['AI/ML', 'Innovation', 'Open for All'],
              last: true,
            ),
          ],
        ),

        // ---------- Featured Companies ----------
        _Section(
          icon: Icons.star_rounded,
          title: 'Featured Companies',
          onViewAll: () {
            // TODO: open all companies
          },
          children: const [
            _FeaturedTile(
              brand: _Brand.google,
              name: 'Google',
              line: 'Hiring  |  12 new opportunities',
            ),
            _FeaturedTile(
              brand: _Brand.microsoft,
              name: 'Microsoft',
              line: 'Internships  |  Apply now',
            ),
            _FeaturedTile(
              brand: _Brand.tcs,
              name: 'TCS',
              line: 'Campus Drive  |  Register now',
            ),
            _FeaturedTile(
              brand: _Brand.amazon,
              name: 'Amazon',
              line: 'Hiring  |  Multiple roles',
            ),
            _FeaturedTile(
              brand: _Brand.infosys,
              name: 'Infosys',
              line: 'Internships  |  Apply now',
              last: true,
            ),
          ],
        ),

        // ---------- Upcoming Company Events ----------
        _Section(
          icon: Icons.calendar_month_rounded,
          title: 'Upcoming Company Events',
          onViewAll: () {
            // TODO: open all company events
          },
          children: const [
            _CompanyEventTile(
              brand: _Brand.tcs,
              title: 'TCS Virtual Info Session',
              date: 'Oct 28 · 4:00 PM',
              tag: 'Webinar',
              tagColor: _lightBlue,
            ),
            _CompanyEventTile(
              brand: _Brand.microsoft,
              title: 'Microsoft Career Talk',
              date: 'Oct 30 · 11:00 AM',
              tag: 'Webinar',
              tagColor: _lightBlue,
            ),
            _CompanyEventTile(
              brand: _Brand.amazon,
              title: 'Amazon Campus Drive',
              date: 'Nov 3 · 9:00 AM',
              tag: 'On-campus',
              tagColor: _green,
              last: true,
            ),
          ],
        ),

        // ---------- "Go to Internships" card ----------
        const _MoreOpportunitiesCard(),
      ],
    );
  }
}

// =====================================================================
//                   LIVE BANNER (TCS Recruitment Drive)
// =====================================================================
class _TcsBanner extends StatelessWidget {
  const _TcsBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF06214F), Color(0xFF0B2E73), Color(0xFF1E4FA8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LIVE pill
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: _green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle, color: Colors.white, size: 8),
                      SizedBox(width: 5),
                      Text(
                        'LIVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // TODO: replace with Image.asset('assets/images/tcs_logo.png')
                const Row(
                  children: [
                    Text(
                      'tcs',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'TATA\nCONSULTANCY\nSERVICES',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 7,
                        height: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Campus Recruitment Drive 2026',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Build your future with TCS',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 8),
                const Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  children: [
                    _LightInfo(Icons.calendar_today_outlined, 'Oct 28, 2025'),
                    _LightInfo(Icons.access_time, '10:00 AM'),
                    _LightInfo(Icons.videocam_outlined, 'Virtual'),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // TODO: open the registration page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: _blue,
                    elevation: 0,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Register Now',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, size: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Page dots (only for looks for now)
                const Row(children: [_Dot(true), _Dot(false), _Dot(false)]),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Placeholder for the office building photo
          // TODO: replace with Image.asset('assets/images/tcs_building.jpg')
          Container(
            width: 80,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.apartment_rounded,
              color: Colors.white38,
              size: 56,
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final bool active;

  const _Dot(this.active);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white38,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _LightInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const _LightInfo(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.white70),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}

// =====================================================================
//                        SECTION CARD WRAPPER
// =====================================================================
class _Section extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onViewAll;
  final List<Widget> children;

  const _Section({
    required this.icon,
    required this.title,
    required this.onViewAll,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _border),
        boxShadow: _softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: _blue, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _dark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap: onViewAll,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        color: _blue,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.chevron_right, color: _blue, size: 18),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}

// =====================================================================
//                COMPANY LOGO PLACEHOLDERS (simple drawings)
//   TODO: replace each with Image.asset('assets/images/<company>.png')
// =====================================================================
class _Logo extends StatelessWidget {
  final _Brand brand;
  final double size;

  const _Logo(this.brand, {this.size = 56});

  Widget _inner() {
    if (brand == _Brand.google) {
      return const Text(
        'G',
        style: TextStyle(
          color: Color(0xFF4285F4),
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    if (brand == _Brand.microsoft) {
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
    if (brand == _Brand.tcs) {
      return const Text(
        'tcs',
        style: TextStyle(
          color: Color(0xFFE4572E),
          fontSize: 22,
          fontWeight: FontWeight.w900,
        ),
      );
    }
    if (brand == _Brand.amazon) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'a',
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              height: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: 22,
            height: 3,
            decoration: BoxDecoration(
              color: _orange,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      );
    }
    if (brand == _Brand.infosys) {
      return const Text(
        'Infosys',
        style: TextStyle(
          color: Color(0xFF1E63E9),
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    if (brand == _Brand.linkedin) {
      return Container(
        width: size * 0.7,
        height: size * 0.7,
        decoration: BoxDecoration(
          color: const Color(0xFF0A66C2),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: const Text(
          'in',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    // Deloitte
    return const Text(
      'Deloitte.',
      style: TextStyle(
        color: Colors.black,
        fontSize: 10.5,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
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

// =====================================================================
//                SMALL HELPERS: tag chip, skill chip, info row
// =====================================================================
class _Tag extends StatelessWidget {
  final String text;
  final Color color;

  const _Tag(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

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

class _Info extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Info(this.icon, this.text);

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

// Wrap = moves items to the next line when there is no space
class _InfoRow extends StatelessWidget {
  final List<Widget> items;

  const _InfoRow(this.items);

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 12, runSpacing: 4, children: items);
  }
}

// =====================================================================
//             ONE POST ROW (update / hiring / webinar / challenge)
// =====================================================================
class _FeedItem extends StatefulWidget {
  final _Brand brand;
  final String tag;
  final Color tagColor;
  final String time;
  final String company;
  final String role;
  final String? description;
  final Widget? info;
  final List<String> chips;
  final bool last;

  const _FeedItem({
    required this.brand,
    required this.tag,
    required this.tagColor,
    required this.time,
    required this.company,
    required this.role,
    this.description,
    this.info,
    this.chips = const [],
    this.last = false,
  });

  @override
  State<_FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<_FeedItem> {
  bool _saved = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: open the full post / details page
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: widget.last
              ? null
              : const Border(bottom: BorderSide(color: _border)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Logo(widget.brand),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _Tag(widget.tag, widget.tagColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.time,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: _grey, fontSize: 11),
                        ),
                      ),
                      InkWell(
                        onTap: () => setState(() => _saved = !_saved),
                        child: Icon(
                          _saved ? Icons.bookmark : Icons.bookmark_border,
                          color: _saved ? _blue : _grey,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: widget.company,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text: '  |  ',
                          style: TextStyle(color: _grey),
                        ),
                        TextSpan(
                          text: widget.role,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    style: const TextStyle(color: _dark, fontSize: 13.5),
                  ),
                  if (widget.description != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      widget.description!,
                      style: const TextStyle(
                        color: _grey,
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ],
                  if (widget.info != null) ...[
                    const SizedBox(height: 6),
                    widget.info!,
                  ],
                  if (widget.chips.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [for (final c in widget.chips) _SkillChip(c)],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
//                         FEATURED COMPANY ROW
// =====================================================================
class _FeaturedTile extends StatelessWidget {
  final _Brand brand;
  final String name;
  final String line;
  final bool last;

  const _FeaturedTile({
    required this.brand,
    required this.name,
    required this.line,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: open this company's page
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: last
              ? null
              : const Border(bottom: BorderSide(color: _border)),
        ),
        child: Row(
          children: [
            _Logo(brand, size: 48),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: _dark,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    line,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: _grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: _grey, size: 20),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
//                       UPCOMING COMPANY EVENT ROW
// =====================================================================
class _CompanyEventTile extends StatelessWidget {
  final _Brand brand;
  final String title;
  final String date;
  final String tag;
  final Color tagColor;
  final bool last;

  const _CompanyEventTile({
    required this.brand,
    required this.title,
    required this.date,
    required this.tag,
    required this.tagColor,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: open this event page
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: last
              ? null
              : const Border(bottom: BorderSide(color: _border)),
        ),
        child: Row(
          children: [
            _Logo(brand, size: 48),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _dark,
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    date,
                    style: const TextStyle(color: _grey, fontSize: 11.5),
                  ),
                  const SizedBox(height: 4),
                  _Tag(tag, tagColor),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: _grey, size: 20),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
//                  "WANT MORE OPPORTUNITIES?" CARD
// =====================================================================
class _MoreOpportunitiesCard extends StatelessWidget {
  const _MoreOpportunitiesCard();

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
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: _blue,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.school_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Want more opportunities?',
                  style: TextStyle(
                    color: _navy,
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Check out the Jobs & Internships section for latest openings.',
                  style: TextStyle(color: _grey, fontSize: 12),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InternshipsScreen(),
                      ),
                    );
                  },
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
                      Flexible(
                        child: Text(
                          'Go to Internships',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, size: 16),
                    ],
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
