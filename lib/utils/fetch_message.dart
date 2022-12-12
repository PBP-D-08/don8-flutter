import 'package:don8_flutter/models/message.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

import '../common/constants.dart';

Future<List<PostMessage>> fetchMessages(CookieRequest request, String filter) async {
  var url = "$API_URL/message/json/$filter";
  final response = await request.get(url);
  List<PostMessage> allMessages = [];
  for (var data in response) {
    if (data != null) {
      allMessages.add(PostMessage.fromJson(data));
    }
  }
  return allMessages;
}