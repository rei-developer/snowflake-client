import 'package:snowflake_client/config/environment.config.dart';
import 'package:snowflake_client/init/app.init.dart';

void main() => AppInit(
      () => Environment(
        buildType: BuildType.local,
        baseUrl: 'http://localhost:10000/v1',
        serviceServer: ServiceServer('localhost', 10004),
      ),
    ).run();
