class SignInResultResponseDto {
  SignInResultResponseDto(this.uid, this.hasUser, this.hasLover);

  SignInResultResponseDto.fromJson(json)
      : uid = (json['uid'] ?? '') as String,
        hasUser = (json['hasUser'] ?? false) as bool,
        hasLover = (json['hasLover'] ?? false) as bool;

  final String uid;
  final bool hasUser;
  final bool hasLover;
}
