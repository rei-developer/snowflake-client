import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/config/environment.config.dart';
import 'package:snowflake_client/network/controller/impl/tcp_connection.controller.dart';
import 'package:snowflake_client/network/controller/tcp_connection.controller.dart';

final serviceServerProvider = StateNotifierProvider<ITcpConnectionController, Socket?>(
  (ref) => TcpConnectionController(ref, Environment.instance.serviceServer),
);
