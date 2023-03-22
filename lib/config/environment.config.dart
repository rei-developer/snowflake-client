import 'package:snowflake_client/util/load_yaml.util.dart';

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
    required this.config,
  });

  static Environment _instance = Environment._(
    buildType: BuildType.local,
    baseUrl: '',
    chatServer: ServerConfig(serverType: ServerType.chat, host: '', port: 0),
    mapServer: ServerConfig(serverType: ServerType.map, host: '', port: 0),
    serviceServer: ServerConfig(serverType: ServerType.service, host: '', port: 0),
    config: {},
  );

  static Environment get instance => _instance;

  static bool get isTest => isDev || isLocal;

  static bool get isLocal => instance.buildType == BuildType.local;

  static bool get isDev => instance.buildType == BuildType.development;

  static bool get isProd => instance.buildType == BuildType.production;

  factory Environment({required BuildType buildType}) {
    Future(() async {
      final config = (await loadConfig())[buildType.name];
      _instance = Environment._(
        buildType: buildType,
        baseUrl: config['baseUrl'],
        chatServer: ServerConfig(
          serverType: ServerType.chat,
          host: config['chat']['host'],
          port: config['chat']['port'],
        ),
        mapServer: ServerConfig(
          serverType: ServerType.map,
          host: config['map']['host'],
          port: config['map']['port'],
        ),
        serviceServer: ServerConfig(
          serverType: ServerType.service,
          host: config['service']['host'],
          port: config['service']['port'],
        ),
        config: config,
      );
    });
    return _instance;
  }

  final BuildType buildType;
  final String baseUrl;
  final ServerConfig chatServer;
  final ServerConfig mapServer;
  final ServerConfig serviceServer;
  final dynamic config;
}
