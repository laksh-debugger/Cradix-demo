import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _blue = Color(0xFF1E63E9);
const Color _bg = Color(0xFFF5F8FE);
const Color _purple = Color(0xFF7E57C2);

class _Project {
  final String title;
  final String description;
  final String techStack; // comma separated, example: Flutter, Firebase
  final String link;

  const _Project({
    required this.title,
    this.description = '',
    this.techStack = '',
    this.link = '',
  });
}

class _PortfolioLink {
  final String title;
  final String url;

  const _PortfolioLink({required this.title, required this.url});
}

class SkillsPortfolioScreen extends StatefulWidget {
  const SkillsPortfolioScreen({super.key});

  @override
  State<SkillsPortfolioScreen> createState() => _SkillsPortfolioScreenState();
}

class _SkillsPortfolioScreenState extends State<SkillsPortfolioScreen> {
  // TODO: load these from the real logged-in user later.
  final List<String> _skills = ['Flutter', 'Dart'];
  final TextEditingController _skillInput = TextEditingController();

  final List<_Project> _projects = [
    const _Project(
      title: 'Cradix - Campus Recruitment App',
      description: 'A student network and campus recruitment app.',
      techStack: 'Flutter, Dart',
    ),
  ];

  final List<_PortfolioLink> _links = [];

  static const List<String> _suggestions = [
    'Python',
    'Java',
    'C++',
    'React',
    'SQL',
    'Firebase',
    'Git',
    'UI/UX',
  ];

  @override
  void dispose() {
    _skillInput.dispose();
    super.dispose();
  }

  // ---------------- Skills ----------------

  void _addSkill(String raw) {
    final String value = raw.trim();
    if (value.isEmpty || _skills.length >= 20) return;
    final bool exists = _skills.any(
      (s) => s.toLowerCase() == value.toLowerCase(),
    );
    if (exists) return;
    setState(() {
      _skills.add(value);
      _skillInput.clear();
    });
    // TODO: save the changes (backend / Firebase).
  }

  // ---------------- Projects ----------------

  Future<void> _openProjectForm({_Project? existing, int? index}) async {
    final _Project? result = await showModalBottomSheet<_Project>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _ProjectForm(existing: existing),
    );
    if (result == null || !mounted) return;
    setState(() {
      if (index == null) {
        _projects.add(result);
      } else {
        _projects[index] = result;
      }
    });
    // TODO: save the changes (backend / Firebase).
  }

  // ---------------- Portfolio links ----------------

  Future<void> _openLinkForm() async {
    final _PortfolioLink? result = await showModalBottomSheet<_PortfolioLink>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const _LinkForm(),
    );
    if (result == null || !mounted) return;
    setState(() => _links.add(result));
    // TODO: save the changes (backend / Firebase).
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
                      'Skills, Projects & Portfolio',
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
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    20,
                    16,
                    20 + MediaQuery.of(context).padding.bottom,
                  ),
                  child: Column(
                    children: [
                      _buildSkillsSection(),
                      _buildProjectsSection(),
                      _buildLinksSection(),
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

  // ---------------- Skills section ----------------

  Widget _buildSkillsSection() {
    final List<String> available = _suggestions
        .where((s) => !_skills.any((k) => k.toLowerCase() == s.toLowerCase()))
        .toList();

    return _SectionCard(
      title: 'Skills',
      subtitle: 'Add up to 20 technical skills',
      icon: Icons.code_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_skills.isEmpty)
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'No skills added yet.',
                style: TextStyle(fontSize: 12.5, color: Colors.black54),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _skills
                  .map(
                    (skill) => InputChip(
                      label: Text(skill),
                      labelStyle: const TextStyle(
                        color: _blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      backgroundColor: _blue.withOpacity(0.1),
                      side: BorderSide.none,
                      deleteIconColor: _blue,
                      onDeleted: () => setState(() => _skills.remove(skill)),
                    ),
                  )
                  .toList(),
            ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _skillInput,
                  onSubmitted: _addSkill,
                  decoration: _fieldDecoration('Type a skill'),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () => _addSkill(_skillInput.text),
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
          if (available.isNotEmpty) ...[
            const SizedBox(height: 14),
            const Text(
              'Quick add',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: available
                  .map(
                    (s) => ActionChip(
                      label: Text('+ $s'),
                      labelStyle: const TextStyle(
                        color: _navy,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                      ),
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black12),
                      onPressed: () => _addSkill(s),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  // ---------------- Projects section ----------------

  Widget _buildProjectsSection() {
    return _SectionCard(
      title: 'Projects',
      subtitle: 'Show the things you have built',
      icon: Icons.rocket_launch_outlined,
      trailing: TextButton.icon(
        onPressed: () => _openProjectForm(),
        icon: const Icon(Icons.add, size: 18),
        label: const Text('Add'),
        style: TextButton.styleFrom(foregroundColor: _blue),
      ),
      child: _projects.isEmpty
          ? const Text(
              'No projects yet. Tap "Add" to add your first project.',
              style: TextStyle(fontSize: 12.5, color: Colors.black54),
            )
          : Column(
              children: [
                for (int i = 0; i < _projects.length; i++)
                  _ProjectCard(
                    project: _projects[i],
                    onEdit: () =>
                        _openProjectForm(existing: _projects[i], index: i),
                    onDelete: () {
                      setState(() => _projects.removeAt(i));
                      // TODO: save the changes (backend / Firebase).
                    },
                  ),
              ],
            ),
    );
  }

  // ---------------- Portfolio links section ----------------

  Widget _buildLinksSection() {
    return _SectionCard(
      title: 'Portfolio Links',
      subtitle: 'GitHub, website, Behance and more',
      icon: Icons.link,
      trailing: TextButton.icon(
        onPressed: _openLinkForm,
        icon: const Icon(Icons.add, size: 18),
        label: const Text('Add'),
        style: TextButton.styleFrom(foregroundColor: _blue),
      ),
      child: _links.isEmpty
          ? const Text(
              'No links yet. Tap "Add" to add a link to your work.',
              style: TextStyle(fontSize: 12.5, color: Colors.black54),
            )
          : Column(
              children: [
                for (int i = 0; i < _links.length; i++)
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
                    decoration: BoxDecoration(
                      color: _bg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.public, color: _blue, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _links[i].title,
                                style: const TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                  color: _navy,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _links[i].url,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: _blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.black45,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() => _links.removeAt(i));
                            // TODO: save the changes (backend / Firebase).
                          },
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}

// ---------------- Shared helpers ----------------

InputDecoration _fieldDecoration(String label, {String? hint}) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    counterText: '',
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
    this.trailing,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;
  final Widget? trailing;

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
                  color: _purple.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: _purple, size: 20),
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
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.project,
    required this.onEdit,
    required this.onDelete,
  });

  final _Project project;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final List<String> tech = project.techStack
        .split(',')
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toList();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder image. Replace with Image.asset('assets/project.png')
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _blue.withOpacity(0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.folder_open, color: _blue, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _navy,
                  ),
                ),
                if (project.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    project.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.5,
                      height: 1.3,
                      color: Colors.black54,
                    ),
                  ),
                ],
                if (tech.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: tech
                        .map(
                          (t) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              t,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _blue,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
                if (project.link.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.link, size: 15, color: _blue),
                      const SizedBox(width: 4),
                      // TODO: open this link in the browser later
                      Expanded(
                        child: Text(
                          project.link,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12, color: _blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black45),
            onSelected: (value) {
              if (value == 'edit') {
                onEdit();
              } else {
                onDelete();
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem<String>(value: 'edit', child: Text('Edit')),
              PopupMenuItem<String>(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------- Bottom sheet frame ----------------

class _SheetFrame extends StatelessWidget {
  const _SheetFrame({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: _navy,
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _BlueButton extends StatelessWidget {
  const _BlueButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _blue,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

// ---------------- Project form ----------------

class _ProjectForm extends StatefulWidget {
  const _ProjectForm({this.existing});

  final _Project? existing;

  @override
  State<_ProjectForm> createState() => _ProjectFormState();
}

class _ProjectFormState extends State<_ProjectForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _description;
  late final TextEditingController _tech;
  late final TextEditingController _link;

  @override
  void initState() {
    super.initState();
    final _Project? p = widget.existing;
    _title = TextEditingController(text: p?.title ?? '');
    _description = TextEditingController(text: p?.description ?? '');
    _tech = TextEditingController(text: p?.techStack ?? '');
    _link = TextEditingController(text: p?.link ?? '');
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _tech.dispose();
    _link.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(
      _Project(
        title: _title.text.trim(),
        description: _description.text.trim(),
        techStack: _tech.text.trim(),
        link: _link.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = widget.existing != null;
    return _SheetFrame(
      title: isEdit ? 'Edit Project' : 'Add Project',
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _title,
              decoration: _fieldDecoration('Project title'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Please enter a project title'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _description,
              minLines: 3,
              maxLines: 5,
              maxLength: 250,
              decoration: _fieldDecoration(
                'Description (optional)',
                hint: 'What does it do? What was your role?',
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _tech,
              decoration: _fieldDecoration(
                'Tech stack (optional)',
                hint: 'Example: Flutter, Firebase',
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _link,
              keyboardType: TextInputType.url,
              decoration: _fieldDecoration(
                'Project link (optional)',
                hint: 'GitHub or live link',
              ),
            ),
            const SizedBox(height: 20),
            _BlueButton(
              label: isEdit ? 'Save Changes' : 'Add Project',
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Portfolio link form ----------------

class _LinkForm extends StatefulWidget {
  const _LinkForm();

  @override
  State<_LinkForm> createState() => _LinkFormState();
}

class _LinkFormState extends State<_LinkForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _url = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _url.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context)
        .pop(_PortfolioLink(title: _title.text.trim(), url: _url.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return _SheetFrame(
      title: 'Add Portfolio Link',
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _title,
              decoration: _fieldDecoration(
                'Link name',
                hint: 'Example: GitHub, Behance, My Website',
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Please enter a name'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _url,
              keyboardType: TextInputType.url,
              decoration: _fieldDecoration('Link (URL)'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Please enter the link'
                  : null,
            ),
            const SizedBox(height: 20),
            _BlueButton(label: 'Add Link', onPressed: _submit),
          ],
        ),
      ),
    );
  }
}
