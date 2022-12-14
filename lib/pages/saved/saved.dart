import 'package:don8_flutter/utils/get_user.dart';
import 'package:flutter/material.dart';
import 'package:don8_flutter/common/constants.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:don8_flutter/utils/fetch_donations.dart';

import 'package:don8_flutter/models/User.dart';
import 'package:don8_flutter/models/globals/available_donation.dart';
import 'package:don8_flutter/pages/donation_page/donation.dart';
import 'package:don8_flutter/utils/delete_saved.dart';

import '../../models/Donation.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    User? user = getUser(request);

    String url = "$API_URL/saved/json/${user?.username}/";
    Future<List<Donation>> _savedDonations = fetchDonations(request, url);

    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
            child: Column(children: [
              Text(
                "Donations",
                style: myTextTheme.headline4,
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                  future: _savedDonations,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.data.length == 0) {
                        return Column(
                          children: const [
                            Text(
                              "Maaf, anda tidak menyimpan donasi apapun.",
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
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
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
                                          'Rp ${snapshot.data![index].fields.moneyAccumulated} terkumpul',
                                          style: const TextStyle(
                                              color: brokenWhite),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: LinearProgressIndicator(
                                            value: snapshot.data![index].fields
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
                                                    child: const Text("Donasi",
                                                        style: TextStyle(
                                                            color: orangeDark,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                              ),
                                              if (request.loggedIn)
                                                IconButton(
                                                    onPressed: (() => {
                                                          deleteSaved(
                                                              request,
                                                              context,
                                                              snapshot
                                                                  .data![index]
                                                                  .pk),
                                                          setState(() {
                                                            _savedDonations =
                                                                fetchDonations(
                                                                    request,
                                                                    url);
                                                          })
                                                        }),
                                                    icon: const Icon(
                                                      Icons.bookmark,
                                                      color: orangeLight,
                                                      size: 30,
                                                    ))
                                            ]),
                                      ),
                                    ],
                                  ),
                                ));
                      }
                    }
                  }),
            ])));
  }
}
