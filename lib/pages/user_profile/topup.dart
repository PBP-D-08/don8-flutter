// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:don8_flutter/common/constants.dart';
import 'package:don8_flutter/utils/get_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

import 'package:don8_flutter/models/user_donation.dart';
import 'package:don8_flutter/utils/top_up.dart';

import '../../models/User.dart';

Future<dynamic> buildForm(
  BuildContext context,
  CookieRequest request,
) {
  final amountInput = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int topUpAmount = 0;
  User? user = getUser(request);

  Future InvalidFormatHandler() =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Color(0xFFEDF6F9),
              content: Stack(
                  children: [
                    Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xFF006d77),
                            ),
                            child: Text(
                              "Input harus berupa bilangan bulat tak nol",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFFEDF6F9)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 18, right: 0, bottom: 17, left: 0),
                            height: 35,
                            child: ElevatedButton(
                              child: Text("OK"),
                              style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold),
                                foregroundColor: Color(0xFFCC6842),
                                backgroundColor: Color(0xFFFFDDD2),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ]
                    )
                  ]
              ),
            ),
      );

  Future EmptyInputHandler() =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Color(0xFFEDF6F9),
              content: Stack(
                  children: [
                    Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xFF006d77),
                            ),
                            child: Text(
                              "Input tidak boleh kosong",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFFEDF6F9)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 18, right: 0, bottom: 17, left: 0),
                            height: 35,
                            child: ElevatedButton(
                              child: Text("OK"),
                              style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold),
                                foregroundColor: Color(0xFFCC6842),
                                backgroundColor: Color(0xFFFFDDD2),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ]
                    )
                  ]
              ),
            ),
      );

  topUp(BuildContext context, request) async {
    final response = await request.post(
        "$API_URL/profile/user/topup/",
        {"amount": amountInput.value});
    if (response['status'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Top Up Successful"),
      ));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Failed"),
      ));
    }
  }

  return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          content: Stack(children: [
            Form(
              key: _formKey,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF006d77),
                        // borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                          "Top Up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFFEDF6F9)) // Color(0xFFFFDDD2)
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                "Input Top Up Amount: ",
                                style: TextStyle(fontSize: 16,
                                    color: Colors.black)
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                                minLines: 1,
                                maxLines: 2,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius
                                          .circular(5.0)
                                  ),
                                ),

                                // Validator sebagai validasi form
                                validator: (String? value) {
                                  if (value == null || value.isEmpty || value == '') {
                                    Navigator.pop(context);
                                    EmptyInputHandler();
                                    return "Invalid Input";
                                  } 
                                  else if (int.tryParse(value) == null || int.parse(value) < 0) {
                                    Navigator.pop(context);
                                    InvalidFormatHandler();
                                    return "Invalid Input";

                                  } else {
                                    setState(() {
                                      topUpAmount = int.parse(value);
                                    });
                                  }
                                }
                            ),
                          )
                        ],
                      )
                    ),
                    Container(
                      // decoration: BoxDecoration(
                      //   color: Color(0xFFEDF6F9),
                      //   borderRadius: BorderRadius.circular(24),
                      // ),
                      margin: EdgeInsets.only(
                          top: 7, right: 0, bottom: 18, left: 0),
                      height: 35,
                      child: ElevatedButton(
                        child: Text("Submit"),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold),
                          foregroundColor: Color(0xFFCC6842),
                          backgroundColor: Color(0xFFFFDDD2),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                              // user!.balance += topUpAmount;
                              // Navigator.pop(context);
                              topUp(context, request);
                          }
                        },
                      ),
                    ),
                  ]
              ),
            ),
          ],),
        );
              // content: SizedBox(
              //   height: MediaQuery.maybeOf(context)!.size.height / 3,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Top Up Balance",
              //         style:
              //             heading5.copyWith(color: darkColor, fontWeight: bold),
              //       ),
              //       const Divider(
              //         color: darkColor,
              //         thickness: 1,
              //       ),
              //       Text(
              //         "Input Top Up Amount:",
              //         style: heading6.copyWith(fontWeight: semiBold),
              //       ),
              //       TextField(
              //         controller: amountInput,
              //         keyboardType: TextInputType.number,
              //         inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              //         decoration: InputDecoration(
              //           enabledBorder: const OutlineInputBorder(
              //               borderSide: BorderSide(width: 1, color: darkColor)),
              //           focusedBorder: const OutlineInputBorder(
              //               borderSide: BorderSide(width: 2, color: darkColor)),
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(5.0),
              //           ),
              //         ),
              //       ),
              //       const Spacer(),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           ElevatedButton(
              //               onPressed: () {
              //                 Navigator.pop(context);
              //               },
              //               style: ElevatedButton.styleFrom(
              //                   backgroundColor: orangeDark),
              //               child: Text(
              //                 "Cancel",
              //                 style: defaultText.copyWith(
              //                     color: lightColor, fontSize: 20),
              //               )),
              //           ElevatedButton(
              //               onPressed: () async {
              //                 topUp(context, request);
              //               },
              //               style: ElevatedButton.styleFrom(),
              //               child: Text(
              //                 "Top Up",
              //                 style: defaultText.copyWith(
              //                     color: lightColor, fontSize: 20),
              //               )),
              //         ],
              //       )
              //     ],
              //   ),
              // ),
            // );
    })
  );
}