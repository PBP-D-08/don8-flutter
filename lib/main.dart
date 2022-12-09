import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/constants.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'pages/auth/login.dart';
import 'pages/auth/register.dart';
import 'pages/homepage/home.dart';
import 'widgets/example.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
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
            "/": (BuildContext context) => const MyHomePage(),
            "/login": (BuildContext context) => const LoginPage(),
            "/register": (BuildContext context) => const RegisterPage(),
            "/example": (BuildContext context) => const ContohPenggunaan(),
          },
        ));
  }
}
