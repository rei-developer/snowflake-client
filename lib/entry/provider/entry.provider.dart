import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/entry/controller/entry.controller.dart';
import 'package:snowflake_client/entry/controller/impl/entry.controller.dart';

final entryControllerProvider = Provider.family<IEntryController, BuildContext>(
  (ref, context) => EntryController(ref, context),
);
