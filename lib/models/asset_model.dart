class AssetModel {
  final String id;
  final String name;
  final String category;
  final String status;
  final String assignedTo;
  final DateTime lastUpdated;

  const AssetModel({
    required this.id,
    required this.name,
    required this.category,
    required this.status,
    required this.assignedTo,
    required this.lastUpdated,
  });
}
