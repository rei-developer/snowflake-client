import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/auth/model/sign-up.model.dart';

abstract class ISignUpRepository extends StateNotifier<SignUpModel> {
  ISignUpRepository(super.state);

  void setDrawFirstLoverHash(String hash);

  String? get hash;
}
