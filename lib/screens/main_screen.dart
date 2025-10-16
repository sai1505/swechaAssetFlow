import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../widgets/asset_list.dart';
import '../widgets/header_section.dart';
import '../widgets/quick_actions.dart';
import '../widgets/stats_cards.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.lightGrey,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header Section
            const SliverToBoxAdapter(
              child: HeaderSection(),
            ),

            // Stats Cards
            const SliverToBoxAdapter(
              child: StatsCards(),
            ),

            // Quick Actions
            const SliverToBoxAdapter(
              child: QuickActions(),
            ),

            // Asset List with Lazy Loading
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                  vertical: AppConstants.smallPadding,
                ),
                child: Text(
                  'Recent Assets',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.primaryBlack,
                  ),
                ),
              ),
            ),

            // Lazy-loaded Asset List
            const AssetList(),

            const SliverToBoxAdapter(
              child: SizedBox(height: AppConstants.largePadding),
            ),
          ],
        ),
      ),
    );
  }
}
