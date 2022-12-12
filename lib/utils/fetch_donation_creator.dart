import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:don8_flutter/models/donation_creator.dart';
import '../common/constants.dart';

Future<DonationCreator> fetchDonationCreator(int id) async {
  var url = Uri.parse("$API_URL/donation/flutter-donation-creator/$id/");
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
  DonationCreator donationCreator = DonationCreator.fromJson(data);

  return donationCreator;
}