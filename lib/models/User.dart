class User {
  late String username;
  late int id, role, balance;

  User(
      {required this.id,
      required this.username,
      required this.role,
      required this.balance});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    role: json["role"],
    balance: json["balance"],
  );
}
