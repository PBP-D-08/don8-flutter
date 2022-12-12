import 'package:don8_flutter/models/Donation.dart';
import 'package:flutter/material.dart';
import 'package:don8_flutter/common/constants.dart';
import 'package:intl/intl.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:don8_flutter/pages/donation_page/donation.dart';
import 'package:don8_flutter/utils/get_user.dart';
import 'package:don8_flutter/models/User.dart';
import 'package:don8_flutter/models/globals/available_donation.dart';
import 'package:don8_flutter/widgets/drawer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:don8_flutter/models/User.dart';
import 'package:don8_flutter/models/org_profile_data.dart';
import 'package:don8_flutter/utils/fetch_org_prof.dart';
import 'dart:convert';


import '../../utils/fetch_donations.dart';

class OrgProfile extends StatefulWidget {
  final User user;
  final String status;
  const OrgProfile({Key? key, required this.user, required this.status}) : super(key: key);



  @override
  _OrgProfileState createState() => _OrgProfileState();
}

class _OrgProfileState extends State<OrgProfile> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    var url = "${dotenv.env['API_URL']}/profile/org/${widget.user
        .username}/donationsf";
    if (widget.status == "cmp") {
      url = "${dotenv.env['API_URL']}/profile/org/${widget.user
          .username}/donationscompf";
    } else if (widget.status == "exp") {
      url = "${dotenv.env['API_URL']}/profile/org/${widget.user
          .username}/donationsexpf";
    } else {
      url = "${dotenv.env['API_URL']}/profile/org/${widget.user
          .username}/donationsprof";
    }

    Future<List<Donation>> donations =
    fetchDonations(request, url);
    Future<List<UserOrg>> prof = fetchOrg(request, "${dotenv.env['API_URL']}/profile/org/${widget.user
        .username}/donationsshow");

    final userView = request.cookies["user"];

    if (userView != null) {
      final userData = User.fromJson(jsonDecode(userView!));
      if (userData.username == widget.user.username) {
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
              padding: const EdgeInsets.fromLTRB(20, 80, 20, 40),
              child: Column(
                children: [
                  Text(
                    widget.user.username,
                    style: myTextTheme.headline2,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Wrap(
                    direction: Axis.vertical,
                    spacing: 10,
                    children: [
                      FutureBuilder(
                          future: fetchOrg(request, "${dotenv.env['API_URL']}/profile/org/${widget.user.username}/donationsshow"),
                          builder: (context, AsyncSnapshot snapshot) {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Berhasil Mengumpulkan",
                                  style: myTextTheme.headline3,
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  "Rp. ${widget.user.balance} ,00",
                                  style:  heading2.copyWith(color: orangeMedium),
                                  textAlign: TextAlign.justify,
                                ),
                                Wrap(
                                  direction: Axis.horizontal,
                                  spacing: 10,
                                  children: [
                                    Text(
                                      "Dari ",
                                      style: myTextTheme.headline3,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "${snapshot.data[0].fields.total_campaign}",
                                      style: heading3.copyWith(color: orangeMedium),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      " Donasi",
                                      style: myTextTheme.headline3,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                              ],
                            );
                          }
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 140,
                  ),
                  Text(
                    "Donations",
                    style: myTextTheme.headline4,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context, MaterialPageRoute(builder:
                                (context) =>
                                OrgProfile(
                                  user: widget.user,
                                  status: "all",
                                )
                            ),
                            );
                          }, child: const Text("All")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context, MaterialPageRoute(builder:
                                (context) =>
                                OrgProfile(
                                  user: widget.user,
                                  status: "cmp",
                                )
                            ),
                            );
                          }, child: const Text("Completed")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context, MaterialPageRoute(builder:
                                (context) =>
                                OrgProfile(
                                  user: widget.user,
                                  status: "exp",
                                )
                            ),
                            );
                          }, child: const Text("Expired")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context, MaterialPageRoute(builder:
                                (context) =>
                                OrgProfile(
                                  user: widget.user,
                                  status: "asd",
                                )
                            ),
                            );
                          }, child: const Text("In Progress")),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                      future: fetchDonations(
                          request, url),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return const Center(child: CircularProgressIndicator());
                        } else {
                          if (snapshot!.data.length == 0) {
                            return Column(
                              children: const [
                                Text(
                                  "Maaf, saat ini tidak ada donasi apapun.",
                                  style: TextStyle(
                                      color: greenDark, fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8),
                              ],
                            );
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (_, index) =>
                                    Card(
                                      clipBehavior: Clip.antiAlias,
                                      color: greenMedium,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                  4),
                                              child: Image.network(snapshot
                                                  .data![index].fields.imageUrl),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              snapshot.data![index].fields.title,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: brokenWhite),
                                              textAlign: TextAlign.center,
                                            ),
                                            subtitle: Text(
                                              'Rp ${snapshot.data![index].fields
                                                  .moneyAccumulated} terkumpul',
                                              style:
                                              const TextStyle(color: brokenWhite),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                  50),
                                              child: LinearProgressIndicator(
                                                value: snapshot.data![index]
                                                    .fields
                                                    .moneyAccumulated /
                                                    snapshot.data![index].fields
                                                        .moneyNeeded,
                                                backgroundColor: brokenWhite,
                                                color: orangeMedium,
                                                minHeight: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                          }
                        }
                      }),
                ],
              ),
            ),
          ),
        );
      } else {
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
              padding: const EdgeInsets.fromLTRB(20, 80, 20, 40),
              child: Column(
                children: [
                  Text(
                    widget.user.username,
                    style: myTextTheme.headline2,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Wrap(
                    direction: Axis.vertical,
                    spacing: 10,
                    children: [
                      // FutureBuilder(
                      //     future: fetchOrg(request, "${dotenv.env['API_URL']}/profile/org/${widget.user.username}/donationsshow"),
                      //     builder: (context, AsyncSnapshot snapshot) {
                      //       return Column(
                      //         children: [
                      //           Text(
                      //             snapshot.data[0],
                      //             style: TextStyle(
                      //                 color: greenDark, fontSize: 20),
                      //             textAlign: TextAlign.center,
                      //           ),
                      //           SizedBox(height: 8),
                      //         ],
                      //       );
                      //   }
                      // )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Berhasil Mengumpulkan",
                    style: myTextTheme.headline3,
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    "Rp. ${widget.user.balance} ,00",
                    style:  heading2.copyWith(color: orangeMedium),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 140,
                  ),
                  Text(
                    "Donations",
                    style: myTextTheme.headline4,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context, MaterialPageRoute(builder:
                                (context) =>
                                OrgProfile(
                                  user: widget.user,
                                  status: "all",
                                )
                            ),
                            );
                          }, child: const Text("All")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context, MaterialPageRoute(builder:
                                (context) =>
                                OrgProfile(
                                  user: widget.user,
                                  status: "cmp",
                                )
                            ),
                            );
                          }, child: const Text("Completed")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context, MaterialPageRoute(builder:
                                (context) =>
                                OrgProfile(
                                  user: widget.user,
                                  status: "exp",
                                )
                            ),
                            );
                          }, child: const Text("Expired")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context, MaterialPageRoute(builder:
                                (context) =>
                                OrgProfile(
                                  user: widget.user,
                                  status: "asd",
                                )
                            ),
                            );
                          }, child: const Text("In Progress")),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                      future: fetchDonations(
                          request, url),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return const Center(child: CircularProgressIndicator());
                        } else {
                          if (snapshot!.data.length == 0) {
                            return Column(
                              children: const [
                                Text(
                                  "Maaf, saat ini tidak ada donasi apapun.",
                                  style: TextStyle(
                                      color: greenDark, fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8),
                              ],
                            );
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (_, index) =>
                                    Card(
                                      clipBehavior: Clip.antiAlias,
                                      color: greenMedium,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                  4),
                                              child: Image.network(snapshot
                                                  .data![index].fields.imageUrl),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              snapshot.data![index].fields.title,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: brokenWhite),
                                              textAlign: TextAlign.center,
                                            ),
                                            subtitle: Text(
                                              'Rp ${snapshot.data![index].fields
                                                  .moneyAccumulated} terkumpul',
                                              style:
                                              const TextStyle(color: brokenWhite),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                  50),
                                              child: LinearProgressIndicator(
                                                value: snapshot.data![index]
                                                    .fields
                                                    .moneyAccumulated /
                                                    snapshot.data![index].fields
                                                        .moneyNeeded,
                                                backgroundColor: brokenWhite,
                                                color: orangeMedium,
                                                minHeight: 10,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: Wrap(
                                                spacing: 10,
                                                alignment: WrapAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(top: 8),
                                                    child: ElevatedButton(
                                                        onPressed: (() =>
                                                        {
                                                          AvailableDonation
                                                              .addToList(snapshot
                                                              .data![index]
                                                              .pk),
                                                          Navigator
                                                              .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (
                                                                    context) =>
                                                                    DonationPage(
                                                                        donation:
                                                                        snapshot
                                                                            .data![index]),
                                                              ))
                                                        }),
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                orangeLight)),
                                                        child: const Text(
                                                            "Donasi",
                                                            style: TextStyle(
                                                                color: orangeDark,
                                                                fontWeight: FontWeight
                                                                    .bold))),
                                                  ),
                                                ]),
                                          ),
                                        ],
                                      ),
                                    ));
                          }
                        }
                      }),
                ],
              ),
            ),
          ),
        );
      }
    } else {
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
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 40),
            child: Column(
              children: [
                Text(
                  widget.user.username,
                  style: myTextTheme.headline2,
                ),
                const SizedBox(
                  height: 40,
                ),
                Wrap(
                  direction: Axis.vertical,
                  spacing: 10,
                  children: [
                    // FutureBuilder(
                    //     future: fetchOrg(request, "${dotenv.env['API_URL']}/profile/org/${widget.user.username}/donationsshow"),
                    //     builder: (context, AsyncSnapshot snapshot) {
                    //       return Column(
                    //         children: [
                    //           Text(
                    //             snapshot.data[0],
                    //             style: TextStyle(
                    //                 color: greenDark, fontSize: 20),
                    //             textAlign: TextAlign.center,
                    //           ),
                    //           SizedBox(height: 8),
                    //         ],
                    //       );
                    //   }
                    // )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Berhasil Mengumpulkan",
                  style: myTextTheme.headline3,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  "Rp. ${widget.user.balance} ,00",
                  style:  heading2.copyWith(color: orangeMedium),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 140,
                ),
                Text(
                  "Donations",
                  style: myTextTheme.headline4,
                ),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 10,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context, MaterialPageRoute(builder:
                              (context) =>
                              OrgProfile(
                                user: widget.user,
                                status: "all",
                              )
                          ),
                          );
                        }, child: const Text("All")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context, MaterialPageRoute(builder:
                              (context) =>
                              OrgProfile(
                                user: widget.user,
                                status: "cmp",
                              )
                          ),
                          );
                        }, child: const Text("Completed")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context, MaterialPageRoute(builder:
                              (context) =>
                              OrgProfile(
                                user: widget.user,
                                status: "exp",
                              )
                          ),
                          );
                        }, child: const Text("Expired")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context, MaterialPageRoute(builder:
                              (context) =>
                              OrgProfile(
                                user: widget.user,
                                status: "asd",
                              )
                          ),
                          );
                        }, child: const Text("In Progress")),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                    future: fetchDonations(
                        request, url),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        if (snapshot!.data.length == 0) {
                          return Column(
                            children: const [
                              Text(
                                "Maaf, saat ini tidak ada donasi apapun.",
                                style: TextStyle(
                                    color: greenDark, fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                            ],
                          );
                        } else {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, index) =>
                                  Card(
                                    clipBehavior: Clip.antiAlias,
                                    color: greenMedium,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                4),
                                            child: Image.network(snapshot
                                                .data![index].fields.imageUrl),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            snapshot.data![index].fields.title,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: brokenWhite),
                                            textAlign: TextAlign.center,
                                          ),
                                          subtitle: Text(
                                            'Rp ${snapshot.data![index].fields
                                                .moneyAccumulated} terkumpul',
                                            style:
                                            const TextStyle(color: brokenWhite),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                50),
                                            child: LinearProgressIndicator(
                                              value: snapshot.data![index]
                                                  .fields
                                                  .moneyAccumulated /
                                                  snapshot.data![index].fields
                                                      .moneyNeeded,
                                              backgroundColor: brokenWhite,
                                              color: orangeMedium,
                                              minHeight: 10,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 20),
                                          child: Wrap(
                                              spacing: 10,
                                              alignment: WrapAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(top: 8),
                                                  child: ElevatedButton(
                                                      onPressed: (() =>
                                                      {
                                                        AvailableDonation
                                                            .addToList(snapshot
                                                            .data![index]
                                                            .pk),
                                                        Navigator
                                                            .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  DonationPage(
                                                                      donation:
                                                                      snapshot
                                                                          .data![index]),
                                                            ))
                                                      }),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                              orangeLight)),
                                                      child: const Text(
                                                          "Donasi",
                                                          style: TextStyle(
                                                              color: orangeDark,
                                                              fontWeight: FontWeight
                                                                  .bold))),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ));
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      );
    }
  }
}