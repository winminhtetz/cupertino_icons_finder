import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:ios_icon_finder/main.dart';
import 'package:ios_icon_finder/services/favorite_icons/models/fav_icon_model.dart';
import 'package:ios_icon_finder/src/pages/mobile/home/home_page.dart';

void main() {
  late Directory hiveDir;

  setUpAll(() async {
    hiveDir = await Directory.systemTemp.createTemp('ios_icon_finder_test_');
    Hive.init(hiveDir.path);
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(FavIconAdapter());
    }
    await Hive.openBox<FavIcon>('favorite_icons');
  });

  tearDownAll(() async {
    if (Hive.isBoxOpen('favorite_icons')) {
      await Hive.box<FavIcon>('favorite_icons').clear();
    }
    await Hive.close();
    if (await hiveDir.exists()) {
      await hiveDir.delete(recursive: true);
    }
  });

  testWidgets('App boots to home page', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pump();

    expect(find.byType(MyApp), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
  });
}
