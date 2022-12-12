import 'dart:convert';

class UserDonation {
  int userPk;
  int organizationPk;
  int donationPk;
  String date;
  int amountOfDonation;

  UserDonation({
    required this.userPk,
    required this.organizationPk,
    required this.donationPk,
    required this.date,
    required this.amountOfDonation,
  });

  Map<String, dynamic> toJson() => {
    "user": userPk,
    "organization": organizationPk,
    "donation": donationPk,
    "date": date,
    "amount_of_donation": amountOfDonation,
  };

  factory UserDonation.fromJson(Map<String, dynamic> json) => UserDonation(
        userPk: json["user"],
        organizationPk: json["organization"],
        donationPk: json["donation"],
        date: json["date"],
        amountOfDonation: json["amount_of_donation"],
      );

}