import 'package:snowflake_client/config/environment.config.dart';
import 'package:snowflake_client/init/app.init.dart';

void main() => AppInit(
      () => Environment(
        buildType: BuildType.production,
        baseUrl: 'https://snowflake-login-api.yukki.app/v1',
        chatServer: ServerConfig(
          serverType: ServerType.chat,
          host: 'snowflake-chat.yukki.app',
          port: 10002,
        ),
        mapServer: ServerConfig(
          serverType: ServerType.map,
          host: 'snowflake-map.yukki.app',
          port: 10003,
        ),
        serviceServer: ServerConfig(
          serverType: ServerType.service,
          host: 'snowflake-service.yukki.app',
          port: 10004,
        ),
      ),
    ).run();
