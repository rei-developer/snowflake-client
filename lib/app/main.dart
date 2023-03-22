import 'package:snowflake_client/config/environment.config.dart';
import 'package:snowflake_client/init/app.init.dart';

void main() => AppInit(() => Environment(buildType: BuildType.production)).run();
