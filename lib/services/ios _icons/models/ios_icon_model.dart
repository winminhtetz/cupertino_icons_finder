import 'dart:convert';

List<IosIcon> iosIconFromJson(String str) => List<IosIcon>.from(json.decode(str).map((x) => IosIcon.fromJson(x)));

String iosIconToJson(List<IosIcon> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IosIcon {
    String iconName;
    String iconCode;
    String iconFont;

    IosIcon({
        required this.iconName,
        required this.iconCode,
        required this.iconFont,
    });

    factory IosIcon.fromJson(Map<String, dynamic> json) => IosIcon(
        iconName: json["icon_name"],
        iconCode: json["icon_code"],
        iconFont: json["icon_font"],
    );

    Map<String, dynamic> toJson() => {
        "icon_name": iconName,
        "icon_code": iconCode,
        "icon_font": iconFont,
    };
}