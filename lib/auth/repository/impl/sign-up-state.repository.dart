import 'package:snowflake_client/auth/model/sign-up.model.dart';
import 'package:snowflake_client/auth/repository/sign-up.repository.dart';

class SignUpStateRepository extends ISignUpRepository {
  SignUpStateRepository() : super(SignUpModel.initial());

  @override
  void setDrawFirstLoverHash(String hash) => state = state.copyWith(drawFirstLoverHash: hash);

  @override
  String? get drawFirstLoverHash => state.drawFirstLoverHash.isNotEmpty
      ? 'https://f002.backblazeb2.com/file/yukki-studio/snowflake/generated-ai-image/${state.drawFirstLoverHash}.webp'
      : null;
}
