import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/asset_model.dart';

class AssetList extends StatefulWidget {
  const AssetList({super.key});

  @override
  State<AssetList> createState() => _AssetListState();
}

class _AssetListState extends State<AssetList> {
  final List<AssetModel> _assets = [];
  bool _isLoading = false;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _loadMoreAssets();
  }

  Future<void> _loadMoreAssets() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    final newAssets = List.generate(10, (index) {
      final assetIndex = _currentPage * 10 + index;
      return AssetModel(
        id: 'AST-${assetIndex.toString().padLeft(4, '0')}',
        name: 'Asset Item $assetIndex',
        category: ['Laptop', 'Monitor', 'Chair', 'Desk'][assetIndex % 4],
        status: ['Active', 'Maintenance', 'Available'][assetIndex % 3],
        assignedTo: assetIndex % 3 == 0 ? 'John Doe' : 'Available',
        lastUpdated: DateTime.now().subtract(Duration(days: assetIndex)),
      );
    });

    setState(() {
      _assets.addAll(newAssets);
      _currentPage++;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index == _assets.length) {
              if (_isLoading) {
                return const Padding(
                  padding: EdgeInsets.all(AppConstants.defaultPadding),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppConstants.primaryBlack,
                      strokeWidth: 2,
                    ),
                  ),
                );
              } else {
                // Load more trigger
                Future.microtask(() => _loadMoreAssets());
                return const SizedBox.shrink();
              }
            }

            return _AssetListItem(asset: _assets[index]);
          },
          childCount: _assets.length + 1,
        ),
      ),
    );
  }
}

class _AssetListItem extends StatelessWidget {
  final AssetModel asset;

  const _AssetListItem({required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: AppConstants.primaryWhite,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(
          color: AppConstants.lightGrey,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppConstants.lightGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.laptop_mac,
              color: AppConstants.primaryBlack,
            ),
          ),
          const SizedBox(width: AppConstants.defaultPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  asset.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppConstants.primaryBlack,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${asset.id} • ${asset.category}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Assigned: ${asset.assignedTo}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: asset.status == 'Active'
                      ? AppConstants.primaryBlack
                      : AppConstants.lightGrey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  asset.status,
                  style: TextStyle(
                    fontSize: 10,
                    color: asset.status == 'Active'
                        ? AppConstants.primaryWhite
                        : AppConstants.primaryBlack,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
