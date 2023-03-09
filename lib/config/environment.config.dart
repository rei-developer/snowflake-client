enum BuildType {
  local,
  development,
  stage,
  production,
}

class Environment {
  factory Environment({
    required BuildType buildType,
    required String baseUrl,
  }) {
    _instance = Environment._internal(buildType, baseUrl);
    return _instance;
  }

  Environment._internal(this.buildType, this.baseUrl);

  final BuildType buildType;
  final String baseUrl;
  static late final Environment _instance;

  static Environment get instance => _instance;

  static bool get isTest => isDev || isLocal;

  static bool get isLocal => instance.buildType == BuildType.local;

  static bool get isDev => instance.buildType == BuildType.development;

  static bool get isProd => instance.buildType == BuildType.production;
}
