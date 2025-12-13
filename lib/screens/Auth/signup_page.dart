import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swecha_asset_flow/Blocs/Auth/bloc/auth_bloc.dart';
import 'package:swecha_asset_flow/screens/Auth/signin_page.dart';
import 'package:swecha_asset_flow/widgets/animations/slide_page_route.dart';
import 'package:swecha_asset_flow/widgets/buttons/HapticButton.dart';
import 'package:swecha_asset_flow/widgets/custom_snackbar.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool obscure = true;
  late final TextEditingController username;
  late final TextEditingController email;
  late final TextEditingController password;
  late FocusNode usernameFocus;
  late FocusNode passwordFocus;
  late FocusNode emailFocus;

  final Color themeColor = const Color(0xFFF50057);

  @override
  void initState() {
    super.initState();
    usernameFocus = FocusNode();
    passwordFocus = FocusNode();
    emailFocus = FocusNode();
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();

    usernameFocus.addListener(() {
      setState(() {}); // rebuild UI when focus changes
    });

    emailFocus.addListener(() {
      setState(() {});
    });

    passwordFocus.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    usernameFocus.dispose();
    passwordFocus.dispose();
    emailFocus.dispose();
    username.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) => {
          if (state is AuthSuccess)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: CustomSnackbar(message: "SignUp successful"),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  duration: const Duration(seconds: 2),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                ),
              ),
            },
          if (state is AuthError)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: CustomSnackbar(message: "SignIn successful"),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Color(0xFFF50057),
                  elevation: 0,
                  duration: const Duration(seconds: 2),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                ),
              ),
            },
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: SvgPicture.asset(
                    'assets/signUp.svg', // your SVG file
                    height: 230,
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  "Sign Up",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 5),

                Text(
                  "Please register to login.",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 30),

                // Username
                _buildTextField(
                  icon: Icons.person_outline,
                  filledIcon: Icons.person,
                  hint: "Username",
                  controller: username,
                  focusNode: usernameFocus,
                ),
                const SizedBox(height: 15),

                //Email
                _buildTextField(
                  icon: Icons.email_outlined,
                  filledIcon: Icons.email,
                  hint: "Email",
                  controller: email,
                  focusNode: emailFocus,
                ),
                const SizedBox(height: 15),

                // Password
                _buildTextField(
                  icon: Icons.lock_outline,
                  filledIcon: Icons.lock,
                  hint: "Password",
                  focusNode: passwordFocus,
                  controller: password,
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
                    text: "Sign Up",
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        SignUpRequested(
                          email: email.text.trim(),
                          password: password.text.trim(),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have account? ",
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
                            SlidePageRoute(page: SigninPage()),
                          );
                        },
                        child: Text(
                          "Sign In",
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
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
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
        controller: controller,
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
