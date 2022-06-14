import 'base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  String get apiURL => "https://hita-live.herokuapp.com";
}