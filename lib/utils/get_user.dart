import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'dart:convert';
import 'package:don8_flutter/models/User.dart';

User? getUser(CookieRequest request){
  String? userString = request.cookies['user'];

  if (userString != null) {
    Map<String, dynamic> userJson = json.decode(userString);
    User user = User.fromJson(userJson);
    return user;
  }
  return null;
}