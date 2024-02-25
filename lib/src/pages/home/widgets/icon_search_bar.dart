import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_icon_finder/src/global/theme/app_color.dart';

class IconSearchBar extends StatelessWidget {
  const IconSearchBar({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        suffixIcon: Icon(CupertinoIcons.search),
        contentPadding: EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: bombay),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: coconut),
        ),
      ),
    );
  }
}
