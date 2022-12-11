// To parse this JSON data, do
//
//     final sortedDonations = sortedDonationsFromJson(jsonString);

import 'dart:convert';

List<SortedDonations> sortedDonationsFromJson(String str) => List<SortedDonations>.from(json.decode(str).map((x) => SortedDonations.fromJson(x)));

String sortedDonationsToJson(List<SortedDonations> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SortedDonations {
    SortedDonations({
        required this.model,
        required this.pk,
        required this.fields,
    });

    Model? model;
    int pk;
    Fields fields;

    factory SortedDonations.fromJson(Map<String, dynamic> json) => SortedDonations(
        model: modelValues.map[json["model"]],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse![model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    Fields({
        required this.user,
        required this.title,
        required this.description,
        required this.dateCreated,
        required this.dateExpired,
        required this.moneyAccumulated,
        required this.moneyNeeded,
        required this.imageUrl,
    });

    int user;
    String title;
    String description;
    DateTime dateCreated;
    DateTime dateExpired;
    int moneyAccumulated;
    int moneyNeeded;
    String imageUrl;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        title: json["title"],
        description: json["description"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateExpired: DateTime.parse(json["date_expired"]),
        moneyAccumulated: json["money_accumulated"],
        moneyNeeded: json["money_needed"],
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "title": title,
        "description": description,
        "date_created": "${dateCreated.year.toString().padLeft(4, '0')}-${dateCreated.month.toString().padLeft(2, '0')}-${dateCreated.day.toString().padLeft(2, '0')}",
        "date_expired": "${dateExpired.year.toString().padLeft(4, '0')}-${dateExpired.month.toString().padLeft(2, '0')}-${dateExpired.day.toString().padLeft(2, '0')}",
        "money_accumulated": moneyAccumulated,
        "money_needed": moneyNeeded,
        "image_url": imageUrl,
    };
}

enum Model { HOMEPAGE_DONATION }

final modelValues = EnumValues({
    "homepage.donation": Model.HOMEPAGE_DONATION
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String>? get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
