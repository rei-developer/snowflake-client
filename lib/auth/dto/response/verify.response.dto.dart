class VerifyResponseDto {
  VerifyResponseDto(this.uid, this.customToken);

  VerifyResponseDto.fromJson(json)
      : uid = (json['uid'] ?? '') as String,
        customToken = (json['customToken'] ?? '') as String;

  final String uid;
  final String customToken;
}
