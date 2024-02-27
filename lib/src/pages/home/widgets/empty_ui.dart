import 'package:flutter/cupertino.dart';

class EmptyUI extends StatelessWidget {
  const EmptyUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(CupertinoIcons.search),
          SizedBox(height: 8),
          Text('No Match Found!'),
        ],
      ),
    );
  }
}
