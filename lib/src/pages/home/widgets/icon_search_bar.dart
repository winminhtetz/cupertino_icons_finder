import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ios_icon_finder/src/global/theme/app_color.dart';

class IconSearchBar extends HookWidget {
  const IconSearchBar({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    var isEmpty = true;
    final controller = useTextEditingController();
    final update = useValueListenable(controller);

    useEffect(
      () {
        isEmpty = update.text.isEmpty;
        return null;
      },
      [update],
    );

    return TextField(
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        fillColor: Colors.white,
        suffixIcon: Opacity(
          opacity: (isEmpty) ? 0.4 : 1,
          child: IconButton(
            onPressed: () => onClear(controller),
            icon: Icon(CupertinoIcons.clear),
          ),
        ),
        contentPadding: EdgeInsets.all(10),
        hintText: 'Please search the name of icon',
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

  void onClear(TextEditingController controller) {
    controller.clear();
    onChanged("");
  }
}
