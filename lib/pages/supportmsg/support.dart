import 'package:flutter/material.dart';
import 'package:don8_flutter/utils/fetch_donations.dart';
import 'package:don8_flutter/utils/fetch_message.dart';
import 'package:don8_flutter/models/message.dart';
import 'package:don8_flutter/models/Donation.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:don8_flutter/utils/like_post.dart';

import 'package:don8_flutter/common/constants.dart';
import 'post_message.dart';

class ShowMessage extends StatefulWidget {
  const ShowMessage({super.key});

  @override
  State<ShowMessage> createState() => _ShowMessageState();
}

class _ShowMessageState extends State<ShowMessage> {
  final msgController = TextEditingController();
  late Future<List<PostMessage>> listMessages;
  late Future<List<Donation>> donations;
  List<String> donationsName = ["All"];
  String dropDownValue = 'All';

  // Function to show like status
  Widget getText(snapshot, index) {
    {
      if (snapshot.data[index].likeStatus) {
        return Text("Unlike", style: defaultText.copyWith(color: orangeLight));
      } else {
        return Text(
          "Like",
          style: defaultText.copyWith(color: orangeDark),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    donations = fetchDonations(request, "$API_URL/donation");
    listMessages = fetchMessages(request, dropDownValue);


    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(children: [
        Text(
          "All Support",
          style: heading4.copyWith(fontWeight: bold),
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: greenMedium),
          onPressed: (() {
            buildForm(context, donationsName.sublist(1), request);
          }),
          child: Text(
            "Give Support",
            style: defaultText.copyWith(
              color: brokenWhite,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
                child: FutureBuilder(
              future: donations,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  for (var name in snapshot.data) {
                    if (!donationsName.contains(name.fields.title)) {
                      donationsName.add(name.fields.title);
                    }
                  }
                  return DropdownButton(
                      isExpanded: true,
                      value: dropDownValue,
                      items: donationsName.map((String name) {
                        return DropdownMenuItem(value: name, child: Text(name));
                      }).toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          dropDownValue = newVal!;
                        });
                      });
                }
              },
            ))
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: FutureBuilder(
              future: listMessages,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return Column(
                      children: [
                        Text(
                          "Tidak Ada Support Message :(",
                          style: myTextTheme.headline3,
                        ),
                        const SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0),
                        itemCount: snapshot.data.length,
                        itemBuilder: ((context, index) {
                          return Card(
                            color: greenMedium,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            shadowColor: darkColor,
                            elevation: 20,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                Text(
                                  snapshot.data[index].authorName,
                                  style: defaultText.copyWith(
                                      color: brokenWhite,
                                      fontSize: 20,
                                      fontWeight: bold),
                                ),
                                Text(
                                  snapshot.data[index].donationName,
                                  style: defaultText.copyWith(
                                      color: brokenWhite,
                                      fontSize: 15,
                                      fontWeight: medium),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SingleChildScrollView(
                                      child: Text(
                                        snapshot.data[index].message,
                                        style: defaultText.copyWith(
                                            color: brokenWhite,
                                            fontSize: 15,
                                            fontWeight: medium),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.favorite,
                                          color: orangeLight,
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          snapshot.data[index].likesCount
                                              .toString(),
                                          style: defaultText.copyWith(
                                              color: orangeLight),
                                        )
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: (() {
                                        likePost(request, context,
                                            snapshot.data[index].pk);
                                        setState(() {});
                                      }),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              snapshot.data[index].likeStatus
                                                  ? orangeDark
                                                  : orangeLight),
                                      child: getText(snapshot, index),
                                    )
                                  ],
                                )
                              ]),
                            ),
                          );
                        }));
                  }
                }
              }),
        ),
      ]),
    );
  }
}
