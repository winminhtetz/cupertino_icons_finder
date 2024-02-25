import 'package:ios_icon_finder/services/env/m_env.dart';
import 'package:ios_icon_finder/services/ios%20_icons/models/ios_icon_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'ios_icon_service.g.dart';

@Riverpod(keepAlive: true)
class IosIconService extends _$IosIconService {
  @override
   Future<List<IosIcon>> build() async {
    var r = await http.get(Uri.parse(Env.api)); 
    return iosIconFromJson(r.body);
  }
}