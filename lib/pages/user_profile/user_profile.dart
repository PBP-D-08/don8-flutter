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
import '../../widgets/drawer.dart';
import 'topup.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    User? user = getUser(request);
    String username = user!.username;
    // UserProfile? profile = 
    int balance = user!.balance;
    // int money_donated = UserProfile.
    
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
                "Welcome, $username!",
                style: myTextTheme.headline2!.copyWith(fontSize: 45),
                textAlign: TextAlign.left,
              ),
              Text(
                "You have donated:",
                style: defaultText.copyWith(color: orangeDark, fontSize: 30),
                textAlign: TextAlign.left,
              ),
              Text(
                "jumlahnya",
                style: myTextTheme.displayMedium!.copyWith(fontSize: 40),
                textAlign: TextAlign.left,
              ),
              Text(
                "Balance:",
                style: defaultText.copyWith(color: orangeDark, fontSize: 30),
                textAlign: TextAlign.left,
              ),
              Text(
                balance.toString(),
                style: myTextTheme.displayMedium!.copyWith(fontSize: 40),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 30,
              ),
              
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: greenMedium),
                onPressed: (() {
                  buildForm(context, request);
                }),
                child: Text(
                  "Top Up",
                  style: defaultText.copyWith(
                    color: brokenWhite,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
