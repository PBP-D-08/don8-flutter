import 'package:flutter/material.dart';
import 'package:don8_flutter/common/constants.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import '../../widgets/drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: Wrap(
            direction: Axis.horizontal,
            spacing: 10,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                ),
              ),
              const Text("don8"),
            ],
          ),
        ),
        drawer: const DrawerApp(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              //
              children: [
                ElevatedButton(
                    onPressed: (() => {
                          if (request.loggedIn) {print(request.jsonData)}
                        }),
                    child: const Text("tes button")),
              ],
            ),
          ),
        ));
  }
}
