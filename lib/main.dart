import 'package:don8_flutter/pages/new_donation/newdonation.dart';
import 'package:don8_flutter/pages/user_profile/history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/constants.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'pages/auth/login.dart';
import 'pages/auth/register.dart';
import 'pages/portal.dart';
import 'widgets/example.dart';

import 'pages/supportmsg/support.dart';
import 'pages/user_profile/user_profile.dart';
import 'pages/user_profile/history.dart';

Future main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) {
          CookieRequest request = CookieRequest();
          return request;
        },
        child: MaterialApp(
          title: 'Don8',
          theme: customTheme,
          debugShowCheckedModeBanner: false,
          routes: {
            "/": (BuildContext context) => const PortalPage(),
            "/login": (BuildContext context) => const LoginPage(),
            "/register": (BuildContext context) => const RegisterPage(),
            "/example": (BuildContext context) => const ContohPenggunaan(),
            "/newdonation": (BuildContext context) => const NewDonation(),
            "/message": (BuildContext context) => const ShowMessage(),
            "/user_profile": (BuildContext context) => const UserProfile(),
            "/history": (BuildContext context) => const HistoryPage(),
          },
        ));
  }
}
