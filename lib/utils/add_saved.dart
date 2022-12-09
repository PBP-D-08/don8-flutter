import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

addSaved(CookieRequest request, BuildContext context, int id) async {
  final response =
      await request.post("${dotenv.env['API_URL']}/saved/", {'id': '$id'});
  if (response['status'] == 200) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Berhasil menyimpan donasi!"),
    ));
    // Navigator.pushNamed(context, "/");
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Gagal menyimpan donasi!"),
    ));
  }
}
