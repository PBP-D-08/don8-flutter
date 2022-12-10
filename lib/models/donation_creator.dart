import 'dart:convert';

// class untuk update User, Organisasi, dan Session
class DonationCreator {
  int pk;
  String organization;

  DonationCreator({
    required this.pk,
    required this.organization,
  });

  factory DonationCreator.fromJson(Map<String, dynamic> json) => DonationCreator(
      pk: json["pk"],
      organization: json["username"],
  );
}