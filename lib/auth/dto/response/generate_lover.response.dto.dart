class GenerateLoverResponseDto {
  GenerateLoverResponseDto(this.hash);

  GenerateLoverResponseDto.fromJson(json) : hash = (json['hash'] ?? '') as String;

  final String hash;
}
