enum BuildType {
  local,
  development,
  stage,
  production,
}

enum ServerType {
  chat,
  map,
  service,
}

class ServerConfig {
  ServerConfig({required this.serverType, required this.host, required this.port});

  final ServerType serverType;
  final String host;
  final int port;
}

class Environment {
  Environment._({
    required this.buildType,
    required this.baseUrl,
    required this.chatServer,
    required this.mapServer,
    required this.serviceServer,
  });

  static late final Environment _instance;

  static Environment get instance => _instance;

  static bool get isTest => isDev || isLocal;

  static bool get isLocal => instance.buildType == BuildType.local;

  static bool get isDev => instance.buildType == BuildType.development;

  static bool get isProd => instance.buildType == BuildType.production;

  factory Environment({
    required BuildType buildType,
    required String baseUrl,
    required ServerConfig chatServer,
    required ServerConfig mapServer,
    required ServerConfig serviceServer,
  }) {
    _instance = Environment._(
      buildType: buildType,
      baseUrl: baseUrl,
      chatServer: chatServer,
      mapServer: mapServer,
      serviceServer: serviceServer,
    );
    return _instance;
  }

  final BuildType buildType;
  final String baseUrl;
  final ServerConfig chatServer;
  final ServerConfig mapServer;
  final ServerConfig serviceServer;
}
