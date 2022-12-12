import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

import 'package:don8_flutter/widgets/drawer.dart';
import 'package:don8_flutter/common/constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  String _username = "";
  String _password1 = "";
  String _password2 = "";
  String? _role;

  List<String> roles = ['Pengguna', 'Perusahaan'];

  var role_map = {'Pengguna': 'user', 'Perusahaan': 'company'};

  onPressed(BuildContext context, request) async {
    final response = await request
        .post("$API_URL/auth/register_flutter/", {
      'username': _username,
      'password1': _password1,
      'password2': _password2,
      'role': role_map[_role],
    });
    if (response['status'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Berhasil Register"),
      ));
      Navigator.pushNamed(context, "/login");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Username already exist"),
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
            const Text("Register"),
          ],
        ),
      ),
      drawer: const DrawerApp(),
      body: Form(
          key: _registerFormKey,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/register.png'),
                  fit: BoxFit.cover),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 35, top: 30),
                    child: const Text(
                      'Buat\nAkun',
                      style: TextStyle(color: Colors.white, fontSize: 33),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.21),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 35, right: 35),
                            child: Column(
                              children: [
                                TextFormField(
                                  style: const TextStyle(color: greenDark),
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: greenDark,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "Username",
                                      hintStyle:
                                          const TextStyle(color: greenDark),
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
                                  style: const TextStyle(color: greenDark),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: greenDark,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "Password",
                                      hintStyle:
                                          const TextStyle(color: greenDark),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _password1 = value!;
                                    });
                                  },
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Confirm Password is required';
                                    }
                                    if (value != _password2) {
                                      return 'Password and Confirm Password is different';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  style: const TextStyle(color: greenDark),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: greenDark,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: greenDark,
                                        ),
                                      ),
                                      hintText: "Confirm Password",
                                      hintStyle:
                                          const TextStyle(color: greenDark),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _password2 = value!;
                                    });
                                  },
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Confirm Password is required';
                                    }
                                    if (value != _password1) {
                                      return 'Password and Confirm Password is different';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField(
                                    value: _role,
                                    icon: const Icon(Icons.arrow_drop_down,
                                        color: greenDark),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: greenDark,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: greenDark,
                                        ),
                                      ),
                                    ),
                                    items: roles.map((String role) {
                                      return DropdownMenuItem(
                                        value: role,
                                        child: Text(
                                          role,
                                          style:
                                              const TextStyle(color: greenDark),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _role = newValue!;
                                      });
                                    },
                                    validator: (value) => value == null
                                        ? 'Role is required'
                                        : null,
                                    hint: Container(
                                      width: 150, //and here
                                      child: const Text(
                                        "Pilih Role",
                                        style: TextStyle(color: greenDark),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Register',
                                      style: TextStyle(
                                          color: greenDark,
                                          fontSize: 27,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: greenDark,
                                      child: IconButton(
                                          color: Colors.white,
                                          onPressed: () async {
                                            if (_registerFormKey.currentState!
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
                                        Navigator.pushNamed(context, '/login');
                                      },
                                      style: const ButtonStyle(),
                                      child: const Text(
                                        'Sign In',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: orangeDark,
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
