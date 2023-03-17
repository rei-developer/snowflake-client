enum BuildType {
  local,
  development,
  stage,
  production,
}

class ServerConfig {
  ServerConfig(this.host, this.port);

  final String host;
  final int port;
}

class Environment {
  factory Environment({
    required BuildType buildType,
    required String baseUrl,
    required ServerConfig chatServer,
    required ServerConfig mapServer,
    required ServerConfig serviceServer,
  }) {
    _instance = Environment._internal(buildType, baseUrl, chatServer, mapServer, serviceServer);
    return _instance;
  }

  Environment._internal(
    this.buildType,
    this.baseUrl,
    this.chatServer,
    this.mapServer,
    this.serviceServer,
  );

  final BuildType buildType;
  final String baseUrl;
  final ServerConfig chatServer;
  final ServerConfig mapServer;
  final ServerConfig serviceServer;
  static late final Environment _instance;

  static Environment get instance => _instance;

  static bool get isTest => isDev || isLocal;

  static bool get isLocal => instance.buildType == BuildType.local;

  static bool get isDev => instance.buildType == BuildType.development;

  static bool get isProd => instance.buildType == BuildType.production;
}
