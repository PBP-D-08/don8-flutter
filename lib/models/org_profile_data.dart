import 'dart:convert';

UserOrg userFromJson(String str) => UserOrg.fromJson(json.decode(str));

class UserOrg {
  UserOrg({
    required this.pk,
    required this.fields,
  });

  int pk;
  Fields fields;

  factory UserOrg.fromJson(Map<String, dynamic> json) => UserOrg(
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
    required this.organization,
    required this.withdrawn,
    required this.total_campaign,
  });


  int organization;
  int withdrawn;
  int total_campaign;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    organization: json["organization"],
    withdrawn: json["withdrawn"],
    total_campaign: json["total_campaign"],
  );

  Map<String, dynamic> toJson() => {
    "organization": organization,
    "withdrawn": withdrawn,
    "total_campaign": "total_campaign",

  };
}