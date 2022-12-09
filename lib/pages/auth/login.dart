import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:don8_flutter/widgets/drawer.dart';
import 'package:don8_flutter/common/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

  String _username = "";
  String _password = "";

  onPressed(BuildContext context, request) async {
    final response = await request.login("${dotenv.env['API_URL']}/auth/login_flutter/", {
      'username': _username,
      'password': _password,
    });
    if (request.loggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Berhasil Login"),
      ));
      Navigator.pushNamed(context, "/");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Username atau Password salah!"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
            const Text("Login"),
          ],
        ),
      ),
      drawer: const DrawerApp(),
      body: Form(
          key: _loginFormKey,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/login.png'),
                  fit: BoxFit.cover),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 35, top: 130),
                    child: const Text(
                      'Selamat\nDatang',
                      style: TextStyle(color: Colors.white, fontSize: 33),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 35, right: 35),
                            child: Column(
                              children: [
                                TextFormField(
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      hintText: "Username",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _username = value!;
                                    });
                                  },
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Username is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  style: const TextStyle(),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      hintText: "Password",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _password = value!;
                                    });
                                  },
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Sign in',
                                      style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: greenDark,
                                      child: IconButton(
                                          color: Colors.white,
                                          onPressed: () async {
                                            if (_loginFormKey.currentState!
                                                .validate()) {
                                              onPressed(context, request);
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward,
                                            color: greenLight,
                                          )),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/register');
                                      },
                                      style: const ButtonStyle(),
                                      child: const Text(
                                        'Register',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Color(0xff4c505b),
                                            fontSize: 18),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
