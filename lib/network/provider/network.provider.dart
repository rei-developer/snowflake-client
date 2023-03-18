import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/config/environment.config.dart';
import 'package:snowflake_client/network/controller/impl/network.controller.dart';

final serviceServerProvider = StateNotifierProvider<TcpConnectionController, Socket?>(
  (ref) => TcpConnectionController(ref, Environment.instance.serviceServer),
);
