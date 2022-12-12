import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:don8_flutter/models/user_donation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<UserDonation>> fetchUserDonation() async {
  var url = Uri.parse("${dotenv.env['API_URL']}/donation/get-user-donations/");
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object Movie
  List<UserDonation> userDonationList = [];
  for (var d in data) {
    if (d != null) {
      userDonationList.add(UserDonation.fromJson(d));
    }
  }

  return userDonationList;
}