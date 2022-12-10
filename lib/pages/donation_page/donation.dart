import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:don8_flutter/utils/fetch_donation_creator.dart';
import 'package:don8_flutter/utils/add_user_donation.dart';
import 'package:don8_flutter/models/user_donation.dart';
import 'package:don8_flutter/models/Donation.dart';
import 'package:don8_flutter/models/User.dart';
import 'package:don8_flutter/models/globals/last_donation.dart';
import 'package:don8_flutter/widgets/drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:don8_flutter/utils/get_user.dart';
import 'package:provider/provider.dart';

class DonationPage extends StatefulWidget {
  final Donation donation;

  const DonationPage({super.key, required this.donation});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final _formKey = GlobalKey<FormState>();

  User? currentUser; // pengguna saat ini
  int moneyAccumulated = 0;
  int amountOfDonation = 0;
  int temp = 0; // when user is still at this page, save sum of donated money in temp

  onPressed(BuildContext context, int organizationPk, int donationPk) {

    LastDonation.time[donationPk.toString()] = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    var data = UserDonation(userPk: currentUser!.id,
        organizationPk: organizationPk,
        donationPk: donationPk,
        date: LastDonation.time[donationPk.toString()],
        amountOfDonation: amountOfDonation);

    addUserDonation(data);
    ThankYouMessage();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    currentUser = getUser(request);
    moneyAccumulated = widget.donation.fields.moneyAccumulated + temp;

    String expiredDate = DateFormat('yyyy-MM-dd').format(widget.donation.fields.dateExpired);
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    int expiredYear = int.parse(expiredDate.substring(0, 4));
    int expiredMonth = int.parse(expiredDate.substring(5, 7));
    int expiredDay = int.parse(expiredDate.substring(8, 10));

    int currentYear = int.parse(currentDate.substring(0, 4));
    int currentMonth = int.parse(currentDate.substring(5, 7));
    int currentDay = int.parse(currentDate.substring(8, 10));

    print(LastDonation.time[widget.donation.pk.toString()]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Page'),
      ),
      drawer: const DrawerApp(),
      body: FutureBuilder(
          future: fetchDonationCreator(widget.donation.pk),
          builder: (context, AsyncSnapshot snapshot) {
            // if the data hasn't been loaded
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());

            } else {
              return SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 70),
                      color: Color(0xFFEDF6F9),
                      alignment: Alignment.center,
                      child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFF006d77),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(widget.donation.fields.imageUrl)
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                        widget.donation.fields.title,
                                        style: TextStyle(fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                            color: Color(0xFFFFDDD2))
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Rp ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Color(0xFFFFDDD2)),
                                            ),
                                            TextSpan(
                                              text: NumberFormat.decimalPattern('en_us').format(moneyAccumulated).toString().replaceAll(",", "."),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Color(0xFFEDF6F9)),
                                            ),
                                            TextSpan(
                                              text: " / ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Color(0xFFFFDDD2)),
                                            ),
                                            TextSpan(
                                              text: NumberFormat.decimalPattern('en_us').format(widget.donation.fields.moneyNeeded).toString().replaceAll(",", "."),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Color(0xFFEDF6F9)),
                                            ),
                                            TextSpan(
                                              text: " terkumpul",
                                              style: TextStyle(fontSize: 16,
                                                  color: Color(0xFFFFDDD2)),
                                            ),
                                          ]
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: LinearProgressIndicator(
                                            minHeight: 10,
                                            value: moneyAccumulated / widget.donation.fields.moneyNeeded,
                                            color: Color(0xFFE29578),
                                            backgroundColor: Color(0xFFEDF6F9),
                                          ),
                                        )
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Berakhir pada ",
                                              style: TextStyle(fontSize: 16,
                                                  color: Color(0xFFFFDDD2)),
                                            ),
                                            TextSpan(
                                              text: expiredDate,
                                              style: TextStyle(fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFEDF6F9)),
                                            ),
                                          ]
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(20),
                                      height: 35,
                                      child: ElevatedButton(
                                        child: Text("Donasi"),
                                        style: ElevatedButton.styleFrom(
                                          textStyle: TextStyle(fontWeight: FontWeight
                                              .bold),
                                          foregroundColor: Color(0xFFCC6842),
                                          backgroundColor: Color(0xFFFFDDD2),
                                        ),
                                        onPressed: () {
                                          if (currentUser == null || currentUser!.role != 1) {
                                              NotUserHandler();
                                          } else if (expiredYear < currentYear ||
                                              expiredYear == currentYear && expiredMonth < currentMonth ||
                                              expiredYear == currentYear && expiredMonth == currentMonth || expiredDay <= currentDay) {
                                              ExpiredDonationHandler();
                                          } else {
                                            showDonationForm(snapshot.data!.pk);
                                          }
                                        },
                                      ),
                                    )
                                  ]
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                                padding: const EdgeInsets.only(
                                    top: 15, right: 15, bottom: 15, left: 28),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFF006d77),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        snapshot.data!.organization,
                                        style: TextStyle(fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                            color: Color(0xFFFFDDD2))
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(20),
                                      height: 35,
                                      child: ElevatedButton(
                                        child: Text("Kunjungi Profil"),
                                        style: ElevatedButton.styleFrom(
                                          textStyle: TextStyle(fontWeight: FontWeight.bold),
                                          foregroundColor: Color(0xFFCC6842),
                                          backgroundColor: Color(0xFFFFDDD2),
                                        ),
                                        onPressed: () {
                                          // route ke profile organisasi
                                        },
                                      ),
                                    )
                                  ],
                                )
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 28, vertical: 28),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFF006d77),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          "Deskripsi",
                                          style: TextStyle(fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              color: Color(0xFFFFDDD2))
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: widget.donation.fields.description,
                                                style: TextStyle(fontSize: 16,
                                                    color: Color(0xFFEDF6F9)),
                                              ),
                                            ]
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            if (currentUser != null && currentUser!.role == 1)
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 28, vertical: 28),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF006d77),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              "Terakhir melakukan donasi: ",
                                              style: TextStyle(fontSize: 16,
                                                  color: Color(0xFFFFDDD2))
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child:
                                            Text(
                                              LastDonation.getTime(widget.donation.pk),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Color(0xFFEDF6F9))
                                            ),
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                          ]
                      )
                  )
              );
            }
          }
      )
      ,
    );
  }

  Future NotUserHandler() =>
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
                              "Anda harus login sebagai pengguna",
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
                                Navigator.pushNamed(context, '/login');
                              },
                            ),
                          ),
                        ]
                    )
                  ]
              ),
            ),
      );

  Future ExpiredDonationHandler() =>
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
                              "Maaf, donasi ini sudah tutup",
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

  Future showDonationForm(int organizationPk) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              // title: Text("Make a donation"),
              contentPadding: EdgeInsets.zero,
              backgroundColor: Color(0xFFEDF6F9),
              content: Stack(
                  children: [
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
                                    "Make a donation",
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
                                            "Amount of donation: ",
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
                                              } else
                                              if (int.tryParse(value) == null || int.parse(value) < 0) {
                                                Navigator.pop(context);
                                                InvalidFormatHandler();
                                                return "Invalid Input";

                                              } else if (currentUser!.balance - int.parse(value) < 0) {
                                                Navigator.pop(context);
                                                NoMoneyHandler();
                                                return "Invalid Input";

                                              } else {
                                                setState(() {
                                                  amountOfDonation = int.parse(value!);
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
                                        currentUser!.balance -= amountOfDonation;
                                        setState(() {
                                          temp += amountOfDonation;
                                        });
                                        Navigator.pop(context);
                                        onPressed(context, organizationPk, widget.donation.pk);
                                    }
                                  },
                                ),
                              ),
                            ]
                        )
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

  Future NoMoneyHandler() =>
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
                              "Uang Anda tidak cukup",
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
  Future ThankYouMessage() =>
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
                              "Terima kasih atas donasi Anda",
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
                                // Navigator.pushReplacementNamed(context, '/');
                              },
                            ),
                          ),
                        ]
                    )
                  ]
              ),
            ),
      );
}