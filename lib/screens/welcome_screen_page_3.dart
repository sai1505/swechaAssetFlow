import 'package:flutter/material.dart';
import 'package:swecha_asset_flow/screens/Auth/signup_page.dart';
import 'package:swecha_asset_flow/widgets/animations/slide_page_route.dart';
import 'package:swecha_asset_flow/widgets/welcome_screen_slides.dart';

class WelcomeScreenPage3 extends StatelessWidget {
  const WelcomeScreenPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WelcomeScreenSlides(
              image: "assets/mobileApp.svg",
              text:
                  "No worries — we’ve got you covered. Meet Swecha Asset Flow",
              buttonText: "Sign Up / Sign In",
              showSkip: false,
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
    );
  }
}
