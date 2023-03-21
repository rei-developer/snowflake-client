import 'package:snowflake_client/auth/model/sign-up.model.dart';
import 'package:snowflake_client/auth/repository/sign-up.repository.dart';

class SignUpStateRepository extends ISignUpRepository {
  SignUpStateRepository() : super(SignUpModel.initial());

  @override
  void setGeneratedLoverHash(String generatedLoverHash) =>
      state = state.copyWith(generatedLoverHash: generatedLoverHash);
}
