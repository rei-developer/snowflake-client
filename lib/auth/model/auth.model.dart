class AuthModel {
  AuthModel(this.uid);

  factory AuthModel.initial({String? uid}) => AuthModel(uid ?? '');

  final String uid;

  AuthModel copyWith({String? uid}) => AuthModel(uid ?? this.uid);
}
