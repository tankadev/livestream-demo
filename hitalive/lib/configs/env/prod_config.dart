import 'base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  String get apiURL => "https://n17hqjjs98.execute-api.ap-southeast-1.amazonaws.com/Prod/";
}