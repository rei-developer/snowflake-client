class SignUpModel {
  SignUpModel(this.generatedLoverHash, this.isLock);

  factory SignUpModel.initial({String? generatedLoverHash, bool? isLock}) =>
      SignUpModel(generatedLoverHash ?? '', isLock ?? false);

  SignUpModel copyWith({String? generatedLoverHash, bool? isLock}) =>
      SignUpModel(generatedLoverHash ?? this.generatedLoverHash, isLock ?? this.isLock);

  final String generatedLoverHash;
  final bool isLock;
}
