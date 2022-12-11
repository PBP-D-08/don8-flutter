import 'package:don8_flutter/common/constants.dart';
import 'package:don8_flutter/models/Donation.dart';
import 'package:don8_flutter/models/User.dart';
import 'package:don8_flutter/models/globals/available_donation.dart';
import 'package:don8_flutter/utils/add_saved.dart';
import 'package:don8_flutter/utils/delete_saved.dart';
import 'package:don8_flutter/utils/fetch_donations.dart';
import 'package:don8_flutter/utils/get_user.dart';
import 'package:don8_flutter/pages/donation_page/donation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    User? user = getUser(request);
    Future<List<Donation>> donations =
        fetchDonations(request, "${dotenv.env['API_URL']}/donation");

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 80, 20, 40),
        child: Column(
          children: [
            Image.asset('assets/images/donation_illustration.png'),
            const SizedBox(
              height: 40,
            ),
            Wrap(
              direction: Axis.horizontal,
              spacing: 10,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 80,
                    width: 80,
                    alignment: Alignment.center,
                  ),
                ),
                Text(
                  "Don8",
                  style: myTextTheme.headline2,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Sebuah platform donasi online yang menghubungkan donatur dengan organisasi, dimana organisasi dapat mendaftarkan kegiatan penggalangan dana. Platform donasi memberikan peluang bagi organisasi nonprofit untuk menggalang dana dan masyarakat umum untuk melakukan donasi.",
              style: defaultText.copyWith(
                  color: greenDark, fontWeight: FontWeight.w600),
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
            FutureBuilder(
                future: fetchDonations(
                    request, "${dotenv.env['API_URL']}/donation"),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot!.data.length == 0) {
                      return Column(
                        children: const [
                          Text(
                            "Maaf, saat ini tidak ada donasi apapun.",
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
                                        borderRadius: BorderRadius.circular(4),
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
                                        style:
                                            const TextStyle(color: brokenWhite),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
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
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: ElevatedButton(
                                                  onPressed: (() => {
                                                        AvailableDonation
                                                            .addToList(snapshot
                                                                .data![index]
                                                                .pk),
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
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
                                                  child: const Text("Donasi",
                                                      style: TextStyle(
                                                          color: orangeDark,
                                                          fontWeight: FontWeight
                                                              .bold))),
                                            ),
                                            if (request.loggedIn &&
                                                user?.role == 1)
                                              if (snapshot
                                                  .data![index].fields.isSaved)
                                                IconButton(
                                                    onPressed: (() => {
                                                          deleteSaved(
                                                              request,
                                                              context,
                                                              snapshot
                                                                  .data![index]
                                                                  .pk),
                                                          setState(() {
                                                            snapshot
                                                                .data![index]
                                                                .fields
                                                                .isSaved = false;
                                                          })
                                                        }),
                                                    icon: const Icon(
                                                      Icons.bookmark,
                                                      color: orangeLight,
                                                      size: 30,
                                                    ))
                                              else
                                                IconButton(
                                                    onPressed: () => {
                                                          addSaved(
                                                              request,
                                                              context,
                                                              snapshot
                                                                  .data![index]
                                                                  .pk),
                                                          setState(() {
                                                            snapshot
                                                                .data![index]
                                                                .fields
                                                                .isSaved = true;
                                                          })
                                                        },
                                                    icon: const Icon(
                                                      Icons.bookmark_border,
                                                      color: orangeLight,
                                                      size: 30,
                                                    )),
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
    );
  }
}
