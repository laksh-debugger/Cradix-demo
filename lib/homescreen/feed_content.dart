import 'package:flutter/material.dart';

import 'screens/campus_feed_screen.dart';

// ---------- Colors used in this file (private to this file) ----------
const Color _primary = Color(0xFF1E63E9);
const Color _textDark = Color(0xFF0F1F3D);
const Color _textGrey = Color(0xFF6B7A93);
const Color _border = Color(0xFFE6EDF8);

BoxDecoration _cardDecoration() => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(16),
  border: Border.all(color: _border),
  boxShadow: [
    BoxShadow(
      color: const Color(0xFF1E63E9).withOpacity(0.06),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ],
);

// =====================================================================
//   FEED CONTENT for the "Campus" and "Companies" chips on the home screen
//   tab: 1 = Campus, 2 = Companies   ("For You" stays in homepage.dart)
// =====================================================================
class FeedContent extends StatelessWidget {
  final int tab;

  const FeedContent({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    final bool isCampus = tab == 1;

    return Column(
      children: [
        if (isCampus) ...const [
          _FeedPost(
            avatarIcon: Icons.person,
            avatarColor: Color(0xFFD7A07A),
            name: 'Priya Sharma',
            subtitle: 'B.Sc. CS · 4 hours ago',
            badge: 'Student Post',
            badgeColor: _primary,
            text: 'Our college tech club is hosting a coding workshop! Don\'t miss this opportunity to learn, build and grow together.',
            footer: 'Coding Workshop · Nov 1 · 10:00 AM · Lab Block',
          ),
          _FeedPost(
            avatarIcon: Icons.campaign_rounded,
            avatarColor: Color(0xFF0EA5C6),
            name: 'Training & Placement Cell',
            subtitle: 'Official Update · Updated today',
            badge: 'Campus News',
            badgeColor: Color(0xFFF59E0B),
            text: 'Placement Drive Registration is now open. Complete your profile to get matched with the right companies.',
            footer: 'Registration open',
          ),
        ] else ...const [
          _FeedPost(
            avatarIcon: Icons.business_rounded,
            avatarColor: Color(0xFF4285F4),
            name: 'Google',
            subtitle: 'Company Update · 2h ago',
            badge: 'Company Update',
            badgeColor: Color(0xFF7C4DFF),
            text: 'Google announces the launch of a new development center in Bengaluru, creating exciting opportunities for students and freshers.',
            footer: 'Bengaluru · Tech · Career Growth',
          ),
          _FeedPost(
            avatarIcon: Icons.business_rounded,
            avatarColor: Color(0xFF00A4EF),
            name: 'Microsoft',
            subtitle: 'Official Update · 5h ago',
            badge: 'Official Update',
            badgeColor: Color(0xFFF59E0B),
            text: 'Applications open for Software Engineer Intern and Full Time roles. Visit our careers page for more details.',
            footer: 'Internship · Full Time · On-site / Hybrid',
          ),
          _FeedPost(
            avatarIcon: Icons.business_rounded,
            avatarColor: Color(0xFFE4572E),
            name: 'TCS',
            subtitle: 'Live now',
            badge: 'LIVE',
            badgeColor: Color(0xFF12A150),
            text: 'Campus Recruitment Drive 2026. Build your future with TCS.',
            footer: 'Oct 28, 2025 · 10:00 AM · Virtual',
          ),
        ],
        const SizedBox(height: 2),
        _OpenFeedButton(companies: !isCampus),
      ],
    );
  }
}

class _FeedPost extends StatelessWidget {
  final IconData avatarIcon;
  final Color avatarColor;
  final String name;
  final String subtitle;
  final String badge;
  final Color badgeColor;
  final String text;
  final String footer;

  const _FeedPost({
    required this.avatarIcon,
    required this.avatarColor,
    required this.name,
    required this.subtitle,
    required this.badge,
    required this.badgeColor,
    required this.text,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: avatarColor,
                child: Icon(avatarIcon, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: _textDark,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.verified, color: _primary, size: 15),
                      ],
                    ),
                    Text(
                      subtitle,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: _textGrey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: badgeColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: badgeColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.4,
              color: _textDark,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.info_outline, size: 15, color: _textGrey),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  footer,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: _textGrey, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// "See all ..." button under the posts: opens the Campus Feed screen
class _OpenFeedButton extends StatelessWidget {
  final bool companies;

  const _OpenFeedButton({required this.companies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CampusFeedScreen()),
          );
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: _primary,
          side: const BorderSide(color: _primary),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                companies ? 'See all company updates' : 'See all campus posts',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.arrow_forward, size: 16),
          ],
        ),
      ),
    );
  }
}
