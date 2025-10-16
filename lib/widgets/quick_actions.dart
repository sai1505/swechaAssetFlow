import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppConstants.primaryBlack,
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Row(
            children: const [
              Expanded(
                child: _ActionButton(
                  icon: Icons.add_circle_outline,
                  label: 'Add Asset',
                ),
              ),
              SizedBox(width: AppConstants.defaultPadding),
              Expanded(
                child: _ActionButton(
                  icon: Icons.qr_code_scanner,
                  label: 'Scan QR',
                ),
              ),
              SizedBox(width: AppConstants.defaultPadding),
              Expanded(
                child: _ActionButton(
                  icon: Icons.upload_file_outlined,
                  label: 'Import',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.defaultPadding,
      ),
      decoration: BoxDecoration(
        color: AppConstants.primaryBlack,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppConstants.primaryWhite,
            size: AppConstants.iconSizeMedium,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: AppConstants.primaryWhite,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
