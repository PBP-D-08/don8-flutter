import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:don8_flutter/models/user_donation.dart';

Future<dynamic> addUserDonation(UserDonation userDonation) async {
  var url = Uri.parse("${dotenv.env['API_URL']}/donation/flutter-make-donation/");
  var response = await http.post(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
      body: jsonEncode(userDonation)
  );
  // return jsonDecode(response.body)["success"];
}