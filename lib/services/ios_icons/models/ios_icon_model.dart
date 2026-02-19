import 'dart:convert';

List<IosIcon> iosIconFromJson(String str) {
  final List<dynamic> rawList = json.decode(str) as List<dynamic>;
  return List<IosIcon>.from(
    rawList.map(
      (dynamic item) => IosIcon.fromJson(
        Map<String, dynamic>.from(item as Map),
      ),
    ),
  );
}

String iosIconToJson(List<IosIcon> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IosIcon {
  String iconName;
  String iconCode;
  String iconFont;
  String? iconFontPackage;
  int? categoryId;

  IosIcon({
    required this.iconName,
    required this.iconCode,
    required this.iconFont,
    this.iconFontPackage,
    this.categoryId,
  });

  int get codePoint {
    final normalized = iconCode.toLowerCase();
    if (normalized.startsWith('0x')) {
      return int.parse(normalized.substring(2), radix: 16);
    }
    return int.parse(iconCode);
  }

  factory IosIcon.fromJson(Map<String, dynamic> json) => IosIcon(
        iconName: json['icon_name'].toString(),
        iconCode: json['icon_code'].toString(),
        iconFont: json['icon_font'].toString(),
        iconFontPackage: json['icon_font_package']?.toString(),
        categoryId: _toInt(json['category_id']),
      );

  Map<String, dynamic> toJson() => {
        'icon_name': iconName,
        'icon_code': iconCode,
        'icon_font': iconFont,
        'icon_font_package': iconFontPackage,
        'category_id': categoryId,
      };

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }
}
