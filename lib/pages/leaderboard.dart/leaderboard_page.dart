import 'dart:convert';

import 'package:don8_flutter/models/User.dart';
import 'package:don8_flutter/pages/leaderboard.dart/sorted_donations.dart';
import 'package:don8_flutter/pages/saved/saved.dart';
import 'package:flutter/material.dart';
import 'package:don8_flutter/common/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:don8_flutter/widgets/drawer.dart';
import 'package:don8_flutter/utils/get_user.dart';
import 'package:don8_flutter/pages/homepage/home.dart';
import 'package:http/http.dart' as http;

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  Future<List<SortedDonations>> fetchLeaderboard() async {
    var url =
        Uri.parse('${dotenv.env['API_URL']}/leaderboard/show_json_sorted/');
    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Leaderboard
    List<SortedDonations> listSortedDonations = [];
    for (var d in data) {
      if (d != null) {
        listSortedDonations.add(SortedDonations.fromJson(d));
      }
    }

    return listSortedDonations;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //your widgets here...
                    Text(
                      "Leaderboard",
                      textAlign: TextAlign.center,
                      style: defaultText.copyWith(
                        // color: orangeDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                        "Leaderboard berdasarkan donasi dengan akumulasi terbesar",
                        textAlign: TextAlign.center,
                        style: defaultText.copyWith(
                          color: greenMedium,
                          // fontWeight: FontWeight.bold,
                          // fontSize: 30),
                        )),
                  ],
                ),
                FutureBuilder(
                    future: fetchLeaderboard(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        if (!snapshot.hasData) {
                          return Column(
                            children: const [
                              Text(
                                "Belum ada donasi untuk ditampilkan",
                                style: TextStyle(
                                    color: Color(0xff59A5D8), fontSize: 20),
                              ),
                              SizedBox(height: 8),
                            ],
                          );
                        } else {
                          return Container(
                              padding: const EdgeInsets.all(5),
                              // Data Table logic and code is in DataClass
                              child: DataClass(
                                  datalist:
                                      snapshot.data as List<SortedDonations>));
                        }
                      }
                    })
              ],
            )));
  }
}

class DataClass extends StatelessWidget {
  const DataClass({Key? key, required this.datalist}) : super(key: key);
  final List<SortedDonations> datalist;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        // Using scrollView for scrolling and formating
        scrollDirection: Axis.vertical,
        // using FittedBox for fitting complte table in screen horizontally.
        child: FittedBox(
            child: DataTable(
          sortColumnIndex: 1,
          showCheckboxColumn: false,
          border: TableBorder.all(
              width: 2.0,
              borderRadius: BorderRadius.circular(20),
              color: greenLight),
          // Data columns as required by APIs data.
          columns: const [
            DataColumn(
                label: Text(
              "Rank",
              style: TextStyle(
                  fontSize: 25,
                  color: orangeMedium,
                  fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              "Donation",
              style: TextStyle(
                  fontSize: 25,
                  color: orangeMedium,
                  fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              "Funds",
              style: TextStyle(
                  fontSize: 25,
                  color: orangeMedium,
                  fontWeight: FontWeight.bold),
            )),
          ],
          // Main logic and code for geting data and shoing it in table rows.
          rows: datalist
              .map(
                  //maping each rows with datalist data
                  (data) => DataRow(cells: [
                        DataCell(
                          Text((datalist.indexOf(data) + 1).toString(),
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(Text(data.fields.title.toString(),
                            style: const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w500))),
                        DataCell(
                          Text(data.fields.moneyAccumulated.toString(),
                              style: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.w500)),
                        ),
                      ]))
              .toList(), // converting at last into list.
        )));
  }
}
