class RegisterRequestDto {
  RegisterRequestDto(this.name, this.sex, this.nation);

  final String name;
  final int sex;
  final int nation;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sex': sex,
      'nation': nation,
    };
  }
}
