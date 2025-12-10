import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swecha_asset_flow/screens/Auth/signup_page.dart';
import 'package:swecha_asset_flow/widgets/animations/slide_page_route.dart';
import 'package:swecha_asset_flow/widgets/buttons/HapticButton.dart';

class WelcomeScreenSlides extends StatelessWidget {
  final String image;
  final String text;
  final String buttonText;
  final VoidCallback onPressed;
  final bool showSkip;

  const WelcomeScreenSlides({
    super.key,
    required this.image,
    required this.text,
    required this.onPressed,
    this.buttonText = "Next",
    this.showSkip = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -60,
          left: -60,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: Color(0xFFF50057).withOpacity(0.25),
              shape: BoxShape.circle,
            ),
          ),
        ),

        Positioned(
          bottom: -60,
          right: -60,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: Color(0xFFF50057).withOpacity(0.25),
              shape: BoxShape.circle,
            ),
          ),
        ),

        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(image, height: 250),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 19),
                ),
                const SizedBox(
                  height: 20,
                ),
                HapticButton(
                  text: buttonText,
                  onPressed: onPressed,
                ),
                if (showSkip)
                  HapticButton(
                    text: "Skip",
                    textColor: Colors.grey,
                    textDecoration: TextDecoration.underline,
                    color: Colors.transparent,
                    onPressed: () {
                      Navigator.push(
                        context,
                        SlidePageRoute(page: SignupPage()),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
