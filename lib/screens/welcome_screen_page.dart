import 'package:flutter/material.dart';
import 'package:swecha_asset_flow/screens/welcome_screen_page_2.dart';
import 'package:swecha_asset_flow/widgets/animations/slide_page_route.dart';
import 'package:swecha_asset_flow/widgets/welcome_screen_slides.dart';

class WelcomeScreenPage extends StatelessWidget {
  const WelcomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WelcomeScreenSlides(
              image: "assets/clearDesk.svg",
              text: "Struggling to keep track of your assets?",
              onPressed: () {
                Navigator.push(
                  context,
                  SlidePageRoute(page: WelcomeScreenPage2()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
