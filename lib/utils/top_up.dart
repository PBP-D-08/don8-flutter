import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:don8_flutter/models/user_donation.dart';

import '../models/User.dart';

Future<dynamic> topUp(User user) async {
  var url = Uri.parse("${dotenv.env['API_URL']}/user/profile/${user.username}/flutter_top_up/");
  var response = await http.post(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
      body: jsonEncode(User)
  );
  // return jsonDecode(response.body)["success"];
}