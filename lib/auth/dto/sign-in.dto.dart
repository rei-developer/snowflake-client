class SignInDto {
  SignInDto(this.uid, this.idToken, this.customToken);

  SignInDto.fromJson(json)
      : uid = (json['uid'] ?? '') as String,
        idToken = (json['idToken'] ?? '') as String,
        customToken = (json['customToken'] ?? '') as String;

  final String uid;
  final String idToken;
  final String customToken;
}
