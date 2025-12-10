import 'package:flutter/material.dart';
import 'package:swecha_asset_flow/screens/welcome_screen_page_3.dart';
import 'package:swecha_asset_flow/widgets/animations/slide_page_route.dart';
import 'package:swecha_asset_flow/widgets/welcome_screen_slides.dart';

class WelcomeScreenPage2 extends StatelessWidget {
  const WelcomeScreenPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WelcomeScreenSlides(
              image: "assets/searchAsset.svg",
              text: "Searching through scattered records?",
              onPressed: () {
                Navigator.push(
                  context,
                  SlidePageRoute(page: WelcomeScreenPage3()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
