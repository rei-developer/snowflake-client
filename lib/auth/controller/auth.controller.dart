import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/auth/auth.const.dart';
import 'package:snowflake_client/auth/model/auth.model.dart';

abstract class IAuthController extends StateNotifier<AuthModel> {
  IAuthController(super.state);

  Future<SignInResult> signIn();

  void setUid([String? uid = '']);

  Future<void> signOut();

  String get uid;
}
