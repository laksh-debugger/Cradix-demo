import 'dart:math';

import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _blue2 = Color(0xFF4A8BF5);
const Color _bg = Color(0xFFF5F8FE);
const Color _fieldBorder = Color(0xFFDDE5F3);
const Color _textGrey = Color(0xFF6B7A93);
const Color _green = Color(0xFF1FA971);
const Color _red = Color(0xFFE53935);

class _Question {
  final String question;
  final String tip;

  const _Question(this.question, this.tip);
}

// Sample questions. Replace with real AI results later.
const Map<String, List<_Question>> _questionsByField = {
  'Software': [
    _Question(
      'Tell me about a project you built.',
      'Explain the problem, what you built, the tools you used and what you learned. Keep it under 2 minutes.',
    ),
    _Question(
      'What is the difference between a list and a map?',
      'A list stores items in order and you find them by position. A map stores key-value pairs and you find items by key.',
    ),
    _Question(
      'How do you debug a bug you cannot find?',
      'Show a clear process: reproduce it, read the error, isolate the code, test one change at a time.',
    ),
    _Question(
      'What is Object-Oriented Programming?',
      'A way of organising code into objects. Mention classes, encapsulation, inheritance and polymorphism with a short example.',
    ),
    _Question(
      'Why do you want to work as a developer?',
      'Be honest and specific. Connect what you enjoy building to what the company does.',
    ),
  ],
  'Data & AI': [
    _Question(
      'What is the difference between supervised and unsupervised learning?',
      'Supervised learning uses labelled data to predict. Unsupervised learning finds patterns in data without labels.',
    ),
    _Question(
      'How do you handle missing data?',
      'Explain options: remove rows, fill with mean or median, or use a model. Say how you choose.',
    ),
    _Question(
      'What is overfitting?',
      'The model learns the training data too well and fails on new data. Mention more data, simpler models and validation.',
    ),
    _Question(
      'Explain a data project you have done.',
      'Cover the question, the data, your method and the result. Numbers make the answer stronger.',
    ),
    _Question(
      'Which tools do you use for analysis?',
      'Name the tools you really know, such as Python, Pandas or SQL, and what you did with each.',
    ),
  ],
  'Business': [
    _Question(
      'Why are you interested in this role?',
      'Link your skills and goals to the role. Show you researched the company.',
    ),
    _Question(
      'How would you prioritise many tasks?',
      'Talk about urgency and impact, a simple method like a priority matrix, and checking with your team.',
    ),
    _Question(
      'Tell me about a time you led a team.',
      'Use the STAR method: Situation, Task, Action, Result. Even a college project counts.',
    ),
    _Question(
      'How do you measure the success of a product?',
      'Mention clear goals and metrics such as active users, retention or revenue.',
    ),
    _Question(
      'Where do you see yourself in 5 years?',
      'Show ambition and growth in this field. Avoid naming a job at another company.',
    ),
  ],
  'Design': [
    _Question(
      'Walk me through your design process.',
      'Research, ideas, wireframes, prototype, testing and improving. Use one real example.',
    ),
    _Question(
      'How do you handle feedback on your design?',
      'Listen first, ask questions, separate opinions from user needs, and improve the work.',
    ),
    _Question(
      'What makes a good user experience?',
      'It is simple, clear, fast and accessible. Give an app you like as an example.',
    ),
    _Question(
      'Which design tools do you use?',
      'Name your tools, such as Figma, and say what you made with them.',
    ),
    _Question(
      'Tell me about a design you are proud of.',
      'Explain the problem, your choices and the result. Show the thinking, not just the look.',
    ),
  ],
  'HR Round': [
    _Question(
      'Tell me about yourself.',
      'Give a short story: who you are, what you study, one or two achievements and why you are here.',
    ),
    _Question(
      'What are your strengths and weaknesses?',
      'Pick real strengths with proof. For weaknesses, say what you are doing to improve.',
    ),
    _Question(
      'Why should we hire you?',
      'Match your skills to the role, show enthusiasm and give one example of results.',
    ),
    _Question(
      'How do you handle pressure or deadlines?',
      'Describe how you plan, break work into steps and ask for help early. Add a short example.',
    ),
    _Question(
      'Do you have any questions for us?',
      'Always ask something, such as about the team, the training or what success looks like in this role.',
    ),
  ],
};

class InterviewPrepScreen extends StatefulWidget {
  const InterviewPrepScreen({super.key});

  @override
  State<InterviewPrepScreen> createState() => _InterviewPrepScreenState();
}

class _InterviewPrepScreenState extends State<InterviewPrepScreen> {
  final ScrollController _scroll = ScrollController();

  String? _field;
  bool _tried = false; // true after Start Practice is pressed once
  bool _show = false;
  List<_Question> _questions = [];
  final Set<int> _done = {};

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _start() {
    setState(() => _tried = true);
    if (_field == null) return;

    // TODO: ask your AI for fresh questions instead of this sample list.
    setState(() {
      _questions = List<_Question>.from(_questionsByField[_field!] ?? const []);
      _done.clear();
      _show = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _shuffle() {
    setState(() {
      _questions.shuffle(Random());
      _done.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final int total = _questions.length;
    final double progress = total == 0 ? 0 : _done.length / total;

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
                  child: ListView(
                    controller: _scroll,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                    children: [
                      const _IntroBanner(),
                      const SizedBox(height: 20),
                      const _SectionTitle('Choose your field'),
                      const SizedBox(height: 4),
                      const Text(
                        'We will give you 5 mock questions.',
                        style: TextStyle(color: _textGrey, fontSize: 13),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final String name in _questionsByField.keys)
                            ChoiceChip(
                              label: Text(name),
                              selected: _field == name,
                              showCheckmark: false,
                              backgroundColor: Colors.white,
                              selectedColor: _blue,
                              side: const BorderSide(color: _fieldBorder),
                              labelStyle: TextStyle(
                                color: _field == name ? Colors.white : _navy,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.5,
                              ),
                              onSelected: (_) => setState(() {
                                _field = name;
                                _show = false;
                              }),
                            ),
                        ],
                      ),
                      if (_tried && _field == null)
                        const Padding(
                          padding: EdgeInsets.only(top: 8, left: 4),
                          child: Text(
                            'Please choose a field',
                            style: TextStyle(
                              color: _red,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      const SizedBox(height: 22),
                      _GradientButton(
                        label: 'Start Practice',
                        icon: Icons.play_arrow_rounded,
                        onTap: _start,
                      ),
                      if (_show) ...[
                        const SizedBox(height: 26),
                        Row(
                          children: [
                            Expanded(child: _SectionTitle('$_field questions')),
                            TextButton.icon(
                              onPressed: _shuffle,
                              icon: const Icon(
                                Icons.shuffle,
                                color: _blue,
                                size: 18,
                              ),
                              label: const Text(
                                'Shuffle',
                                style: TextStyle(
                                  color: _blue,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  minHeight: 8,
                                  backgroundColor: _fieldBorder,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        _green,
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${_done.length} / $total practiced',
                              style: const TextStyle(
                                color: _textGrey,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        for (int i = 0; i < _questions.length; i++) ...[
                          _QuestionCard(
                            // The key makes each card keep its own open/closed
                            // state when the list is shuffled.
                            key: ValueKey(_questions[i].question),
                            number: i + 1,
                            question: _questions[i],
                            done: _done.contains(i),
                            onToggleDone: () => setState(() {
                              if (_done.contains(i)) {
                                _done.remove(i);
                              } else {
                                _done.add(i);
                              }
                            }),
                          ),
                          const SizedBox(height: 10),
                        ],
                        const SizedBox(height: 10),
                        const _TipsCard(),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
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
          const SizedBox(width: 4),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Interview Prep',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Mock questions and sample answers',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 12.5),
                ),
              ],
            ),
          ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.groups_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class _IntroBanner extends StatelessWidget {
  const _IntroBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_blue, _blue2],
        ),
        boxShadow: [
          BoxShadow(
            color: _blue.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Practice makes confident',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Answer out loud first, then open the tip to compare.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.record_voice_over_outlined,
              color: Colors.white,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: _navy,
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _GradientButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [_blue, _blue2],
        ),
        boxShadow: [
          BoxShadow(
            color: _blue.withOpacity(0.35),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onTap,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 24),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
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

class _QuestionCard extends StatelessWidget {
  final int number;
  final _Question question;
  final bool done;
  final VoidCallback onToggleDone;

  const _QuestionCard({
    super.key,
    required this.number,
    required this.question,
    required this.done,
    required this.onToggleDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: done ? _green : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: _navy.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Theme(
        // Removes the thin divider lines that ExpansionTile draws.
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: const Border(),
          collapsedShape: const Border(),
          tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          iconColor: _blue,
          collapsedIconColor: _blue,
          leading: Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: done ? _green : _blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: done
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : Text(
                    '$number',
                    style: const TextStyle(
                      color: _blue,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
          ),
          title: Text(
            question.question,
            style: const TextStyle(
              color: _navy,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              height: 1.25,
            ),
          ),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _blue.withOpacity(0.06),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.lightbulb_outline, color: _blue, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'Sample answer tip',
                        style: TextStyle(
                          color: _blue,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    question.tip,
                    style: const TextStyle(
                      color: _navy,
                      fontSize: 13.5,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onToggleDone,
                icon: Icon(
                  done ? Icons.check_circle : Icons.check_circle_outline,
                  color: done ? _green : _blue,
                  size: 20,
                ),
                label: Text(
                  done ? 'Practiced' : 'Mark as practiced',
                  style: TextStyle(
                    color: done ? _green : _blue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TipsCard extends StatelessWidget {
  const _TipsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _navy.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tips_and_updates_outlined, color: _blue, size: 22),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Quick interview tips',
                  style: TextStyle(
                    color: _navy,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          _TipLine('Keep answers between 1 and 2 minutes.'),
          _TipLine('Use real examples from projects and college.'),
          _TipLine('Research the company before you go.'),
          _TipLine('Speak slowly and keep eye contact.'),
        ],
      ),
    );
  }
}

class _TipLine extends StatelessWidget {
  final String text;

  const _TipLine(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(Icons.check_circle, color: _green, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _textGrey,
                fontSize: 13.5,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
