enum BuildType {
  local,
  development,
  stage,
  production,
}

class ServiceServer {
  ServiceServer(this.host, this.port);

  final String host;
  final int port;
}

class Environment {
  factory Environment({
    required BuildType buildType,
    required String baseUrl,
    required ServiceServer serviceServer,
  }) {
    _instance = Environment._internal(buildType, baseUrl, serviceServer);
    return _instance;
  }

  Environment._internal(this.buildType, this.baseUrl, this.serviceServer);

  final BuildType buildType;
  final String baseUrl;
  final ServiceServer serviceServer;
  static late final Environment _instance;

  static Environment get instance => _instance;

  static bool get isTest => isDev || isLocal;

  static bool get isLocal => instance.buildType == BuildType.local;

  static bool get isDev => instance.buildType == BuildType.development;

  static bool get isProd => instance.buildType == BuildType.production;
}
