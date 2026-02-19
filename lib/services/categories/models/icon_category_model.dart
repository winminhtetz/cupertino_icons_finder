import 'dart:convert';

List<IconCategory> iconCategoryFromJson(String str) {
  final List<dynamic> rawList = json.decode(str) as List<dynamic>;
  return List<IconCategory>.from(
    rawList.map(
      (dynamic item) => IconCategory.fromJson(
        Map<String, dynamic>.from(item as Map),
      ),
    ),
  );
}

class IconCategory {
  final int categoryId;
  final String categoryName;

  const IconCategory({
    required this.categoryId,
    required this.categoryName,
  });

  factory IconCategory.fromJson(Map<String, dynamic> json) {
    return IconCategory(
      categoryId: json['category_id'] as int,
      categoryName: json['category_name'].toString(),
    );
  }
}
