import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swecha_asset_flow/screens/Auth/signup_page.dart';
import 'package:swecha_asset_flow/widgets/animations/slide_page_route.dart';
import 'package:swecha_asset_flow/widgets/buttons/HapticButton.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool obscure = true;
  late FocusNode passwordFocus;
  late FocusNode emailFocus;

  final Color themeColor = const Color(0xFFF50057);

  @override
  void initState() {
    passwordFocus = FocusNode();
    emailFocus = FocusNode();

    emailFocus.addListener(() {
      setState(() {});
    });

    passwordFocus.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    passwordFocus.dispose();
    emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: SvgPicture.asset(
                  'assets/signIn.svg', // your SVG file
                  height: 230,
                ),
              ),
              const SizedBox(height: 20),

              Text(
                "Sign In",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 5),

              Text(
                "Please login to continue.",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 30),

              //Email
              _buildTextField(
                icon: Icons.email_outlined,
                filledIcon: Icons.email,
                hint: "Email",
                focusNode: emailFocus,
              ),
              const SizedBox(height: 15),

              // Password
              _buildTextField(
                icon: Icons.lock_outline,
                filledIcon: Icons.lock,
                hint: "Password",
                focusNode: passwordFocus,
                obscure: obscure,
                suffix: IconButton(
                  icon: Icon(
                    obscure ? Icons.visibility_off : Icons.visibility,
                    color: Color(0xFFF50057),
                  ),
                  onPressed: () => setState(() => obscure = !obscure),
                ),
              ),

              const SizedBox(height: 15),

              const SizedBox(height: 25),

              // Sign Up Button
              Align(
                alignment: Alignment.center,
                child: HapticButton(
                  text: "Sign In",
                  onPressed: () {},
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont have an account? ",
                      style:
                          Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        Navigator.push(
                          context,
                          SlidePageRoute(page: SignupPage()),
                        );
                      },
                      child: Text(
                        "Let's Create one",
                        style:
                            Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
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

  Widget _buildTextField({
    required IconData icon,
    required IconData filledIcon,
    required String hint,
    TextInputType keyboard = TextInputType.text,
    bool obscure = false,
    Widget? suffix,
    required FocusNode focusNode,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        focusNode: focusNode,
        keyboardType: keyboard,
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: Icon(
            focusNode.hasFocus ? filledIcon : icon,
            color: focusNode.hasFocus
                ? const Color(0xFFF50057)
                : Color(0xFFF50057),
          ),
          suffixIcon: suffix,
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}
