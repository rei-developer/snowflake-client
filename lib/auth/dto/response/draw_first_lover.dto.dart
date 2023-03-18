class DrawFirstLoverDto {
  DrawFirstLoverDto(this.hash);

  DrawFirstLoverDto.fromJson(json) : hash = (json['hash'] ?? '') as String;

  final String hash;
}
