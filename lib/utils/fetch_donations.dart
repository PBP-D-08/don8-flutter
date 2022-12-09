import 'package:don8_flutter/models/Donation.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/material.dart';

Future<List<Donation>> fetchDonations(BuildContext context, String url) async {
  final request = context.watch<CookieRequest>();
  print(request.cookies);
  final response = await request.get(url);
  List<Donation> donations = [];
  for (var data in response) {
    if (data != null) {
      donations.add(Donation.fromJson(data));
    }
  }
  return donations;
}
