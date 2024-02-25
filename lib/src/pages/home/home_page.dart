import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ios_icon_finder/services/ios%20_icons/providers/ios_icon_provider.dart';
import 'package:ios_icon_finder/services/ios%20_icons/services/ios_icon_service.dart';
import 'package:ios_icon_finder/src/global/theme/app_color.dart';
import 'package:ios_icon_finder/src/pages/home/components/body_component.dart';
import 'package:ios_icon_finder/src/pages/home/components/title_component.dart';
import 'package:ios_icon_finder/src/pages/home/widgets/error_ui.dart';
import 'package:ios_icon_finder/src/pages/home/widgets/loading.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var query = useState('');

    final data = ref.watch(iosIconServiceProvider);
    final iosIcons = ref.watch(iosIconProvider(query.value));

    return Scaffold(
      backgroundColor: coconut,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(
          children: [
            TitleComponent(
              onSearch: (value) => query.value = value,
            ),
            switch (data) {
              AsyncData() => BodyComponent(
                  icons: iosIcons,
                  onRefresh: ref.refresh(iosIconServiceProvider.future),
                ),
              AsyncError() => ErrorUI(
                  onPressed: () => ref.refresh(iosIconServiceProvider.future),
                ),
              _ => LoadingUI(),
            }
          ],
        ),
      ),
    );
  }
}
