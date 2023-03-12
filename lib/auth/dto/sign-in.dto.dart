class SignInDto {
  SignInDto(this.uid, this.customToken, this.hasUser);

  SignInDto.fromJson(json)
      : uid = (json['uid'] ?? '') as String,
        customToken = (json['customToken'] ?? '') as String,
        hasUser = (json['hasUser'] ?? false) as bool;

  final String uid;
  final String customToken;
  final bool hasUser;
}
