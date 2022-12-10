import 'dart:convert';

List<Donation> donationFromJson(String str) =>
    List<Donation>.from(json.decode(str).map((x) => Donation.fromJson(x)));

String donationToJson(List<Donation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Donation {
  Donation({
    required this.pk,
    required this.fields,
  });

  int pk;
  Fields fields;

  factory Donation.fromJson(Map<String, dynamic> json) => Donation(
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  Fields({
    required this.title,
    required this.description,
    required this.dateExpired,
    required this.imageUrl,
    required this.dateCreated,
    required this.moneyNeeded,
    required this.moneyAccumulated,
    required this.isSaved,
    this.currRole,
  });

  String title;
  String description;
  DateTime dateExpired;
  String imageUrl;
  DateTime dateCreated;
  int moneyNeeded;
  int moneyAccumulated;
  bool isSaved;
  int? currRole;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        description: json["description"],
        dateExpired: DateTime.parse(json["date_expired"]),
        imageUrl: json["image_url"],
        dateCreated: DateTime.parse(json["date_created"]),
        moneyNeeded: json["money_needed"],
        moneyAccumulated: json["money_accumulated"],
        isSaved: json["is_saved"],
        currRole: json["curr_role"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "date_expired":
            "${dateExpired.year.toString().padLeft(4, '0')}-${dateExpired.month.toString().padLeft(2, '0')}-${dateExpired.day.toString().padLeft(2, '0')}",
        "image_url": imageUrl,
        "date_created":
            "${dateCreated.year.toString().padLeft(4, '0')}-${dateCreated.month.toString().padLeft(2, '0')}-${dateCreated.day.toString().padLeft(2, '0')}",
        "money_needed": moneyNeeded,
        "money_accumulated": moneyAccumulated,
        "is_saved": isSaved,
        "curr_role": currRole,
      };
}
