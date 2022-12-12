import 'package:don8_flutter/models/user_donation.dart';
import 'package:don8_flutter/utils/get_user.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import '../models/User.dart';
import '../common/constants.dart';

Future<List<UserDonation>> fetchHistory(CookieRequest request) async {
  User? user = getUser(request);
  var url = Uri.parse("$API_URL/profile/user/${user?.username}/flutter-history/");
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // convert data dari json
  List<UserDonation> history = [];
  for (var d in data) {
    history.add(UserDonation.fromJson(d));
  }
  return history;
}