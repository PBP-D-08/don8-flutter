import 'package:don8_flutter/models/message.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

likePost(CookieRequest request, BuildContext context,int pk) async {
  var url = "${dotenv.env['API_URL']}/message/like-post-flutter/";
  final response = await request.post(url,{'post_id' : '$pk'});
  return response;

}