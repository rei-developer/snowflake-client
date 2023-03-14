class UserModel {
  UserModel(
    this.id,
    this.uid,
    this.name,
    this.sex,
  );

  factory UserModel.initial({
    int? id,
    String? uid,
    String? name,
    int? sex,
  }) =>
      UserModel(
        id ?? 0,
        uid ?? '',
        name ?? '',
        sex ?? 0,
      );

  UserModel copyWith({
    int? id,
    String? uid,
    String? name,
    int? sex,
  }) =>
      UserModel(
        id ?? this.id,
        uid ?? this.uid,
        name ?? this.name,
        sex ?? this.sex,
      );

  final int id;
  final String uid;
  final String name;
  final int sex;
}
