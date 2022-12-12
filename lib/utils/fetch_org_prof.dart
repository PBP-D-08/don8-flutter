import 'package:don8_flutter/models/org_profile_data.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

Future<List<UserOrg>> fetchOrg(CookieRequest request, String url) async {
  final response = await request.get(url);
  List<UserOrg> donations = [];
  for (var data in response) {
    if (data != null) {
      donations.add(UserOrg.fromJson(data));
    }
  }
  return donations;
}