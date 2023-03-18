class SignUpModel {
  SignUpModel(this.drawFirstLoverHash);

  factory SignUpModel.initial({String? drawFirstLoverHash}) =>
      SignUpModel(drawFirstLoverHash ?? '');

  SignUpModel copyWith({String? drawFirstLoverHash}) =>
      SignUpModel(drawFirstLoverHash ?? this.drawFirstLoverHash);

  final String drawFirstLoverHash;
}
