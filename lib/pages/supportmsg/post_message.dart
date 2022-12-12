// ignore_for_file: use_build_context_synchronously

import 'package:don8_flutter/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';


Future<dynamic> buildForm(
  BuildContext context,
  List<String> donationsName,
  CookieRequest request,
) {
  String dropdownvalue = donationsName[0];
  final msgController = TextEditingController();

  createPost(BuildContext context, request) async {
    final response = await request.post(
        "$API_URL/message/add-message-flutter/",
        {"donation-name": dropdownvalue, "message": msgController.text});
    if (response['status'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Post successfully Created"),
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
              content: SizedBox(
                height: MediaQuery.maybeOf(context)!.size.height / 1.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Post",
                      style:
                          heading5.copyWith(color: darkColor, fontWeight: bold),
                    ),
                    const Divider(
                      color: darkColor,
                      thickness: 1,
                    ),
                    Text(
                      "Donation Name",
                      style: heading6.copyWith(fontWeight: semiBold),
                    ),
                    DropdownButton(
                        isExpanded: true,
                        value: dropdownvalue,
                        items: donationsName.map((String name) {
                          return DropdownMenuItem(
                              value: name, child: Text(name));
                        }).toList(),
                        onChanged: (String? newVal) {
                          setState(() {
                            dropdownvalue = newVal!;
                          });
                          
                        }),
                    Text(
                      "Message",
                      style: heading6.copyWith(fontWeight: semiBold),
                    ),
                    TextField(
                      controller: msgController,
                      maxLines: 8,
                      decoration: InputDecoration(
                        hintText: "Write Your Support Here",
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: darkColor)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: darkColor)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: orangeDark),
                            child: Text(
                              "Cancel",
                              style: defaultText.copyWith(
                                  color: lightColor, fontSize: 20),
                            )),
                        ElevatedButton(
                            onPressed: () async {
                              createPost(context, request);
                            },
                            style: ElevatedButton.styleFrom(),
                            child: Text(
                              "Create",
                              style: defaultText.copyWith(
                                  color: lightColor, fontSize: 20),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            );
          }));
}
