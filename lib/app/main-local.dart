import 'package:snowflake_client/config/environment.config.dart';
import 'package:snowflake_client/init/app.init.dart';

void main() => AppInit(
      () => Environment(
        buildType: BuildType.local,
        baseUrl: 'http://localhost:10000/v1',
        chatServer: ServerConfig(
          serverType: ServerType.chat,
          host: 'localhost',
          port: 10002,
        ),
        mapServer: ServerConfig(
          serverType: ServerType.map,
          host: 'localhost',
          port: 10003,
        ),
        serviceServer: ServerConfig(
          serverType: ServerType.service,
          host: 'localhost',
          port: 10004,
        ),
      ),
    ).run();
