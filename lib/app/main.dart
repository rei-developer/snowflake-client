import 'package:snowflake_client/config/environment.config.dart';
import 'package:snowflake_client/init/app.init.dart';

void main() => AppInit(
      () => Environment(
        buildType: BuildType.production,
        baseUrl: 'https://snowflake-login-api.yukki.app/v1',
        serviceServer: ServiceServer('snowflake-service.yukki.app', 10004),
      ),
    ).run();
