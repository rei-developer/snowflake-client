import 'package:snowflake_client/config/environment.config.dart';
import 'package:snowflake_client/init/app.init.dart';

void main() => AppInit(
      () => Environment(
        buildType: BuildType.production,
        baseUrl: 'https://snowflake-login-api.yukki.app/v1',
        chatServer: ServerConfig('snowflake-chat.yukki.app', 10002),
        mapServer: ServerConfig('snowflake-map.yukki.app', 10003),
        serviceServer: ServerConfig('snowflake-service.yukki.app', 10004),
      ),
    ).run();
