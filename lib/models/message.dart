// To parse this JSON data, do
//
//     final postMessage = postMessageFromJson(jsonString);

import 'dart:convert';

PostMessage postMessageFromJson(String str) => PostMessage.fromJson(json.decode(str));

String postMessageToJson(PostMessage data) => json.encode(data.toJson());

class PostMessage {
    PostMessage({
        required this.pk,
        required this.authorName,
        required this.donationName,
        required this.message,
        required this.dateCreated,
        required this.likesCount,
        required this.likeStatus,
    });

    int pk;
    String authorName;
    String donationName;
    String message;
    DateTime dateCreated;
    int likesCount;
    bool likeStatus;

    factory PostMessage.fromJson(Map<String, dynamic> json) => PostMessage(
        pk: json["pk"],
        authorName: json["fields"]["author_name"],
        donationName: json["fields"]["donation_name"],
        message: json["fields"]["message"],
        dateCreated: DateTime.parse(json["fields"]["date_created"]),
        likesCount: json["fields"]["likes_count"],
        likeStatus: json["fields"]["like_status"],
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "author_name": authorName,
        "donation_name": donationName,
        "message": message,
        "date_created": "${dateCreated.year.toString().padLeft(4, '0')}-${dateCreated.month.toString().padLeft(2, '0')}-${dateCreated.day.toString().padLeft(2, '0')}",
        "likes_count": likesCount,
        "like_status": likeStatus,
    };
}
