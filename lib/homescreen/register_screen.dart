import 'package:Cradix/homescreen/screens/complete_profile_screen.dart';
import 'package:Cradix/homescreen/screens/login_screen.dart';
import 'package:flutter/material.dart';

const Color _navy = Color(0xFF0B2E73);
const Color _navy2 = Color(0xFF14408F);
const Color _blue = Color(0xFF1E63E9);
const Color _blue2 = Color(0xFF4A8BF5);
const Color _bg = Color(0xFFF5F8FE);
const Color _fieldBg = Color(0xFFF6F8FC);
const Color _fieldBorder = Color(0xFFDDE5F3);
const Color _hint = Color(0xFF9AA7BF);
const Color _textGrey = Color(0xFF6B7A93);
const Color _red = Color(0xFFE53935);

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _rollCtrl = TextEditingController();

  bool _hidePass = true;
  String? _college;

  // Sample list. Replace with your real list of colleges.
  final List<String> _colleges = const [
    'Lovely Professional University (LPU)',
    'Delhi University',
    'IIT Delhi',
    'Amity University',
    'Other',
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _rollCtrl.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String hint, IconData icon, {Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _hint, fontSize: 15),
      prefixIcon: Icon(icon, color: _blue, size: 24),
      suffixIcon: suffix,
      filled: true,
      fillColor: _fieldBg,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      errorStyle: const TextStyle(
        color: _red,
        fontSize: 12.5,
        fontWeight: FontWeight.w600,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _fieldBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _blue, width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _red, width: 2),
      ),
    );
  }

  void _submit() {
    final bool valid = _formKey.currentState!.validate();
    if (!valid) return;

    // TODO: send the details to your backend / Firebase to create the account.

    // pushReplacement = the user cannot press Back to return to this page.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const CompleteProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: _navy,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Header(),
              Container(
                width: double.infinity,
                constraints: BoxConstraints(minHeight: screenH * 0.7),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(22, 24, 22, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _PerkChips(),
                            const SizedBox(height: 20),
                            Form(
                              key: _formKey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _nameCtrl,
                                    textInputAction: TextInputAction.next,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: _decoration(
                                      'Full Name',
                                      Icons.person_outline,
                                    ),
                                    validator: (v) =>
                                        (v == null || v.trim().isEmpty)
                                        ? 'Please enter your name'
                                        : null,
                                  ),
                                  const SizedBox(height: 14),
                                  TextFormField(
                                    controller: _emailCtrl,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    decoration: _decoration(
                                      'Email Address',
                                      Icons.mail_outline,
                                    ),
                                    validator: (v) {
                                      final String t = (v ?? '').trim();
                                      if (t.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      if (!t.contains('@') ||
                                          !t.contains('.')) {
                                        return 'Enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 14),
                                  TextFormField(
                                    controller: _passCtrl,
                                    obscureText: _hidePass,
                                    textInputAction: TextInputAction.next,
                                    decoration: _decoration(
                                      'Password',
                                      Icons.lock_outline,
                                      suffix: IconButton(
                                        icon: Icon(
                                          _hidePass
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: _textGrey,
                                        ),
                                        onPressed: () => setState(
                                          () => _hidePass = !_hidePass,
                                        ),
                                      ),
                                    ),
                                    validator: (v) =>
                                        (v == null || v.length < 6)
                                        ? 'Use at least 6 characters'
                                        : null,
                                  ),
                                  const SizedBox(height: 14),
                                  DropdownButtonFormField<String>(
                                    value: _college,
                                    isExpanded: true,
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: _blue,
                                    ),
                                    decoration: _decoration(
                                      'College Name',
                                      Icons.school_outlined,
                                    ),
                                    items: [
                                      for (final String c in _colleges)
                                        DropdownMenuItem<String>(
                                          value: c,
                                          child: Text(
                                            c,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                    ],
                                    onChanged: (v) =>
                                        setState(() => _college = v),
                                    validator: (v) => v == null
                                        ? 'Please select your college'
                                        : null,
                                  ),
                                  const SizedBox(height: 14),
                                  TextFormField(
                                    controller: _rollCtrl,
                                    textInputAction: TextInputAction.done,
                                    decoration: _decoration(
                                      'Roll Number (Optional)',
                                      Icons.badge_outlined,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            _SignUpButton(onTap: _submit),
                            const SizedBox(height: 20),
                            const _OrDivider(),
                            const SizedBox(height: 20),
                            _SocialButton(
                              // Replace the "G" with your Google logo:
                              // Image.asset('assets/images/google.png', width: 24)
                              leading: const Text(
                                'G',
                                style: TextStyle(
                                  color: Color(0xFF4285F4),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              label: 'Continue with Google',
                              onTap: () {
                                // TODO: Google sign-in
                              },
                            ),
                            const SizedBox(height: 12),
                            _SocialButton(
                              // Replace the icon with your GitHub logo:
                              // Image.asset('assets/images/github.png', width: 24)
                              leading: const Icon(
                                Icons.code,
                                color: _navy,
                                size: 26,
                              ),
                              label: 'Continue with GitHub',
                              onTap: () {
                                // TODO: GitHub sign-in
                              },
                            ),
                            const SizedBox(height: 18),
                            Center(
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  const Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                      color: _textGrey,
                                      fontSize: 13.5,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => const LoginScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Log In',
                                      style: TextStyle(
                                        color: _blue,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const _CampusIllustration(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Navy gradient top part with soft decorative circles.
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_navy, _navy2],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -40,
              top: -30,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06),
                ),
              ),
            ),
            Positioned(
              right: 50,
              bottom: -50,
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _blue2.withOpacity(0.18),
                ),
              ),
            ),
            Positioned(
              left: -30,
              bottom: 10,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _LogoRow(),
                  const SizedBox(height: 22),
                  const Text(
                    'Create Your Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Join CRADIX and be a part of something bigger.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoRow extends StatelessWidget {
  const _LogoRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Your CRADIX logo inside a white circle
        Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Image.asset(
                'assets/images/cradix_logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CRADIX',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  'Learn  ·  Build  ·  Grow',
                  style: TextStyle(
                    color: Color(0xFFBFD3F7),
                    fontSize: 12.5,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Three small "why join" chips.
class _PerkChips extends StatelessWidget {
  const _PerkChips();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _Perk(icon: Icons.work_outline, label: 'Internships'),
        _Perk(icon: Icons.emoji_events_outlined, label: 'Hackathons'),
        _Perk(icon: Icons.groups_outlined, label: 'Network'),
      ],
    );
  }
}

class _Perk extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Perk({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: _blue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _blue, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: _blue,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  final VoidCallback onTap;

  const _SignUpButton({required this.onTap});

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
          child: const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.arrow_forward, color: Colors.white, size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: _fieldBorder, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Text('OR', style: TextStyle(color: _textGrey, fontSize: 13)),
        ),
        Expanded(child: Divider(color: _fieldBorder, thickness: 1)),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final Widget leading;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({
    required this.leading,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(27),
        border: Border.all(color: _fieldBorder),
        boxShadow: [
          BoxShadow(
            color: _navy.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(27),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 28, child: Center(child: leading)),
              const SizedBox(width: 14),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _navy,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Soft blue campus picture at the bottom.
// Replace the whole Stack with your picture:
// Image.asset('assets/images/campus.png', width: double.infinity, fit: BoxFit.cover)
class _CampusIllustration extends StatelessWidget {
  const _CampusIllustration();

  @override
  Widget build(BuildContext context) {
    const Color soft = Color(0xFFB9CCEC);
    const Color mid = Color(0xFF7FA0DA);
    return Container(
      height: 130,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xFFE6EEFB)],
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: const [
          Positioned(
            left: -6,
            bottom: 0,
            child: Icon(Icons.park, color: mid, size: 84),
          ),
          Positioned(
            left: 52,
            bottom: 0,
            child: Icon(Icons.park, color: soft, size: 52),
          ),
          Positioned(
            right: -6,
            bottom: 0,
            child: Icon(Icons.park, color: mid, size: 90),
          ),
          Positioned(
            right: 56,
            bottom: 0,
            child: Icon(Icons.park, color: soft, size: 50),
          ),
          Positioned(
            bottom: 0,
            child: Icon(Icons.account_balance, color: soft, size: 96),
          ),
        ],
      ),
    );
  }
}
