import 'package:pbp_django_auth/pbp_django_auth.dart';

import 'package:flutter/material.dart';

import '../common/constants.dart';

addSaved(CookieRequest request, BuildContext context, int id) async {
  final response =
      await request.post("$API_URL/saved/", {'id': '$id'});
  if (response['status'] == 200) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Berhasil menyimpan donasi!"),
    ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Gagal menyimpan donasi!"),
    ));
  }
}
