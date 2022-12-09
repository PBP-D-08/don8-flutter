import 'package:don8_flutter/models/Donation.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

Future<List<Donation>> fetchDonations(CookieRequest request, String url) async {
  final response = await request.get(url);
  List<Donation> donations = [];
  for (var data in response) {
    if (data != null) {
      donations.add(Donation.fromJson(data));
    }
  }
  return donations;
}
