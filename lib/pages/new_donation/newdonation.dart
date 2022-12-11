import 'dart:convert';

import 'package:don8_flutter/models/User.dart';
import 'package:don8_flutter/pages/homepage/home.dart';
import 'package:flutter/material.dart';
import 'package:don8_flutter/common/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import '../../../widgets/drawer.dart';
import 'package:intl/intl.dart'; //for date format
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:don8_flutter/utils/get_user.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class NewDonation extends StatefulWidget {
  const NewDonation({super.key});

  @override
  State<NewDonation> createState() => _NewDonationState();
}

// Future<DonationResponse> createDonation(
//     String title,
//     String description,
//     String image_url,
//     String date_expired,
//     String money_needed,
//     String user_id) async {
//   final response = await http.post(
//     Uri.parse('${dotenv.env['API_URL']}/add_ajax_donation_mobile/'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//       'description': description,
//       'image_url': image_url,
//       'date_expired': date_expired,
//       'money_needed': money_needed,
//       'user_id': user_id,
//     }),
//   );

//   if (response.statusCode == 201) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     return DonationResponse.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to create donation.');
//   }
// }

class _NewDonationState extends State<NewDonation> {
  final _formKey = GlobalKey<FormState>();
  String _donationTitle = "";
  String _donationUrl = "";
  String _donationDescription = "";
  String _donationMoney = "";
  String _donationExpiration = "";
  final dateController = TextEditingController();
  final fieldTitle = TextEditingController();
  final fieldDescription = TextEditingController();
  final fieldURL = TextEditingController();
  final fieldNominal = TextEditingController();

  User? currentUser;

  void clearText() {
    fieldTitle.clear();
    fieldDescription.clear();
    fieldURL.clear();
    fieldNominal.clear();
    dateController.clear();
  }

  createDonation(
      BuildContext context,
      request,
      String title,
      String description,
      String image_url,
      String date_expired,
      String money_needed,
      String user_id) async {
    final response = await request
        .post("${dotenv.env['API_URL']}/add_ajax_donation_mobile/", {
      'title': title,
      'description': description,
      'image_url': image_url,
      'date_expired': date_expired,
      'money_needed': money_needed,
      'user_id': user_id,
    });

    if (response['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Berhasil membuat donasi"),
      ));
      clearText();
      Navigator.pushNamed(context, "/");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Gagal membuat donasi"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    currentUser = getUser(request);

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
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  //
                  children: [
                    Text(
                      'Create New Donation',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                    ),

                    Padding(
                      // Menggunakan padding sebesar 8 pixels
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: fieldTitle,
                        decoration: InputDecoration(
                          hintText: "Masukkan judul donasi kamu",
                          labelText: "Title",
                          // Menambahkan circular border agar lebih rapi
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        // Menambahkan behavior saat nama diketik
                        onChanged: (String? value) {
                          setState(() {
                            _donationTitle = value!;
                          });
                        },
                        // Menambahkan behavior saat data disimpan
                        onSaved: (String? value) {
                          setState(() {
                            _donationTitle = value!;
                          });
                        },
                        // Validator sebagai validasi form
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Title is empty!';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      // Menggunakan padding sebesar 8 pixels
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: fieldDescription,
                        decoration: InputDecoration(
                          hintText: "Masukkan deskripsi",
                          labelText: "Description",
                          // Menambahkan circular border agar lebih rapi
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        // Menambahkan behavior saat nama diketik
                        onChanged: (String? value) {
                          setState(() {
                            _donationDescription = value!;
                          });
                        },
                        // Menambahkan behavior saat data disimpan
                        onSaved: (String? value) {
                          setState(() {
                            _donationDescription = value!;
                          });
                        },
                        // Validator sebagai validasi form
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Description is empty!';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      // Menggunakan padding sebesar 8 pixels
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: fieldURL,
                        decoration: InputDecoration(
                          hintText: "Masukkan image URL",
                          labelText: "Image URL",
                          // Menambahkan circular border agar lebih rapi
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        // Menambahkan behavior saat nama diketik
                        onChanged: (String? value) {
                          setState(() {
                            _donationUrl = value!;
                          });
                        },
                        // Menambahkan behavior saat data disimpan
                        onSaved: (String? value) {
                          setState(() {
                            _donationUrl = value!;
                          });
                        },
                        // Validator sebagai validasi form
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Image URL is empty!';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      // Menggunakan padding sebesar 8 pixels
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: fieldNominal,
                        decoration: InputDecoration(
                          hintText: "Masukkan nominal yang dibutuhkan",
                          labelText: "Money Needed",
                          // Menambahkan circular border agar lebih rapi
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        // Menambahkan behavior saat nama diketik
                        onChanged: (String? value) {
                          setState(() {
                            _donationMoney = value!;
                          });
                        },
                        // Menambahkan behavior saat data disimpan
                        onSaved: (String? value) {
                          setState(() {
                            _donationMoney = value!;
                          });
                        },
                        // Validator sebagai validasi form
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Money needed is empty!';
                          }
                          return null;
                        },
                      ),
                    ),
                    TextField(
                        controller:
                            dateController, //editing controller of this TextField
                        decoration: const InputDecoration(
                            icon:
                                Icon(Icons.calendar_today), //icon of text field
                            labelText: "Expiration Date" //label text of field
                            ),
                        readOnly: true, // when true user cannot edit text
                        onTap: () async {
                          //when click we have to show the datepicker
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            print(
                                pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                            String formattedDate = DateFormat('yyyy-MM-dd').format(
                                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                            print(
                                formattedDate); //formatted date output using intl package =>  2022-07-04
                            //You can format date as per your need

                            setState(() {
                              dateController.text =
                                  formattedDate; //set foratted date to TextField value.
                              _donationExpiration = formattedDate;
                            });
                          } else {
                            print("Date is not selected");
                          }
                        }),
                    // Text(
                    //   "ini default text style nya, kalo mau override pake ini aja",
                    //   style: defaultText.copyWith(
                    //       color: orangeDark, fontWeight: FontWeight.w600),
                    // ),
                    ElevatedButton(
                        onPressed: (() => {
                              // if (request.loggedIn) {print(request.jsonData)}
                              createDonation(
                                  context,
                                  request,
                                  fieldTitle.text,
                                  fieldDescription.text,
                                  fieldURL.text,
                                  dateController.text,
                                  fieldNominal.text,
                                  currentUser!.id.toString())
                            }),
                        child: const Text("Create")),
                    OutlinedButton(
                        onPressed: (() => {
                              // if (request.loggedIn) {print(request.jsonData)}
                              Navigator.pushNamed(context, '/')
                            }),
                        // child: orangeLight(child: ),
                        child: const Text("Cancel")),
                  ],
                ),
              ),
            )));
  }
}
