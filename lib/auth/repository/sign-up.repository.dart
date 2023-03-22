import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/auth/model/sign-up.model.dart';

abstract class ISignUpRepository extends StateNotifier<SignUpModel> {
  ISignUpRepository(super.state);

  void setGeneratedLoverHash(String generatedLoverHash);

  void setLock(bool lock);
}
