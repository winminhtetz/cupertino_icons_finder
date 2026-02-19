import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:ios_icon_finder/services/categories/models/icon_category_model.dart';

const String _categoriesApiUrl =
    'https://raw.githubusercontent.com/winminhtetz/JsonFiles/main/categories.json';

final iconCategoriesProvider = FutureProvider<List<IconCategory>>((ref) async {
  final response = await http.get(Uri.parse(_categoriesApiUrl));

  if (response.statusCode != 200) {
    throw Exception('Failed to load categories (${response.statusCode})');
  }

  return iconCategoryFromJson(response.body);
});
