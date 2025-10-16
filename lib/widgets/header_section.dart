import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: const BoxDecoration(
        color: AppConstants.primaryWhite,
        border: Border(
          bottom: BorderSide(
            color: AppConstants.lightGrey,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Asset Management',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.primaryBlack,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Manage and track your assets',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildIconButton(Icons.notifications_outlined),
              const SizedBox(width: AppConstants.smallPadding),
              _buildIconButton(Icons.search),
              const SizedBox(width: AppConstants.smallPadding),
              _buildProfileAvatar(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppConstants.lightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        size: AppConstants.iconSizeMedium,
        color: AppConstants.primaryBlack,
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppConstants.primaryBlack,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: Text(
          'U',
          style: TextStyle(
            color: AppConstants.primaryWhite,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
