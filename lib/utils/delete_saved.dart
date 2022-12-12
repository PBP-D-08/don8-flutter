import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/material.dart';
import '../common/constants.dart';

Future<String> deleteSaved(
    CookieRequest request, BuildContext context, int id) async {
  final url = Uri.parse("$API_URL/saved/delete/$id/");
  final httpRequest = http.Request("DELETE", url);
  httpRequest.headers.addAll(request.headers);

  final response = await httpRequest.send();

  if (response.statusCode != 200) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Gagal menghapus donasi dari donasi yang disimpan!"),
    ));
    return Future.error("error: status code ${response.statusCode}");
  }
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text("Berhasil menghapus donasi dari donasi yang disimpan!"),
  ));

  return await response.stream.bytesToString();
}
