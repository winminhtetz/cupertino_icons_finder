import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_icon_finder/src/global/theme/app_color.dart';

class CopyBtn extends StatelessWidget {
  const CopyBtn({super.key, required this.onCopy});

  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onCopy,
      icon: Icon(CupertinoIcons.doc, size: 14),
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            side: BorderSide(color: porcelain),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
