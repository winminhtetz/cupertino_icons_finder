import 'package:envied/envied.dart';
part 'm_env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'API')
  static const String api = _Env.api;
}
