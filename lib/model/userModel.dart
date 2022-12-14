class UserModel {
  String? name;
  String? dayOfBirth;
  String? idUser;

  UserModel({
    this.name,
    this.dayOfBirth,
    this.idUser,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        dayOfBirth: json["dayOfBirth"],
        idUser: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "dayOfBirth": dayOfBirth,
        "id": idUser,
      };
}
