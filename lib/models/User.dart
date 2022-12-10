import 'dart:convert';
import 'package:don8_flutter/models/globals/donated_money.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

class User {
  late String username;
  late int id, role, balance;

  User(
      {required this.id,
      required this.username,
      required this.role,
      required this.balance}) {
    this.balance -= DonatedMoney.amount;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        role: json["role"],
        balance: json["balance"],
      );
}