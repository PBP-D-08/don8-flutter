import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:don8_flutter/models/user_donation.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import '../models/User.dart';

Future<dynamic> topUp(CookieRequest request, String url) async {
  Uri uri = Uri.parse(url);
  var response = await http.post(
      uri,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
      body: jsonEncode(User)
  );
  // return jsonDecode(response.body)["success"];
}