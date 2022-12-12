import 'package:don8_flutter/utils/fetch_history.dart';
import 'package:don8_flutter/utils/fetch_user_donations.dart';
import 'package:don8_flutter/utils/get_user.dart';
import 'package:don8_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:don8_flutter/common/constants.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:don8_flutter/models/User.dart';
import 'package:don8_flutter/models/globals/available_donation.dart';
import 'package:don8_flutter/pages/donation_page/donation.dart';
import '../../models/Donation.dart';
import '../../models/user_donation.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    User? user = getUser(request);

    String url = "${dotenv.env['API_URL']}/profile/user/${user?.username}/history/json/";
    Future<List<UserDonation>> _donationsHistory = fetchUserDonation();

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
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
            child: Column(children: [
              Text(
                "History",
                style: myTextTheme.headline2,
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                  future: _donationsHistory,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot!.data.length == 0) {
                        return Column(
                          children: const [
                            Text(
                              "Anda belum pernah melakukan donasi :(",
                              style: TextStyle(color: greenDark, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),
                          ],
                        );
                      } else {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => Card(
                                  clipBehavior: Clip.antiAlias,
                                  color: greenMedium,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                          'Rp ${snapshot.data![index].fields.amount_of_donation}',
                                          style: const TextStyle(
                                              color: brokenWhite),
                                          textAlign: TextAlign.center,
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
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: ElevatedButton(
                                                    onPressed: (() => {
                                                          AvailableDonation
                                                              .addToList(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .pk),
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    DonationPage(
                                                                        donation:
                                                                            snapshot.data![index]),
                                                              ))
                                                        }),
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    orangeLight)),
                                                    child: const Text("Donasi lagi",
                                                        style: TextStyle(
                                                            color: orangeDark,
                                                            fontWeight:
                                                                FontWeight
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
            ])
        )
      )
    );
  }
}
