import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

Future<YamlMap> loadConfig() async => loadYaml(await rootBundle.loadString('assets/config.yaml'));
