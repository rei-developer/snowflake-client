class SignUpModel {
  SignUpModel(this.generatedLoverHash);

  factory SignUpModel.initial({String? generatedLoverHash}) =>
      SignUpModel(generatedLoverHash ?? '');

  SignUpModel copyWith({String? generatedLoverHash}) =>
      SignUpModel(generatedLoverHash ?? this.generatedLoverHash);

  final String generatedLoverHash;
}
