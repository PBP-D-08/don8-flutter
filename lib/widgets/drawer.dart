import 'dart:convert';

import 'package:don8_flutter/pages/org_profile/org_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:don8_flutter/models/globals/donated_money.dart';
import 'package:don8_flutter/models/globals/last_donation.dart';
import 'package:don8_flutter/models/User.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final user = request.cookies['user'];

    return Drawer(
      child: Column(
        children: [
          // Menambahkan clickable menu

          if (request.cookies["user"] != null)
            ListTile(
              title: const Text("Profil"),
              onTap: () {
                Navigator.pushReplacement( context, MaterialPageRoute( builder:
                    (context) => OrgProfile(
                      user: User.fromJson(jsonDecode(user!)),
                      status: "all",
                    )
                  ),
                );
              },
            ),

          ListTile(
            title: const Text('Home'),
            onTap: () {
              // Route menu ke halaman utama
              Navigator.pushNamed(context, '/');
            },
          ),
          if (!request.loggedIn)
            ListTile(
              title: const Text('Login'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            )
          else
            ListTile(
              title: const Text('Logout'),
              onTap: () async {
                final response =
                    await request.logout("${dotenv.env['API_URL']}/auth/logout_flutter/");
                DonatedMoney.amount = 0;
                LastDonation.reset();
                Navigator.pushNamed(context, '/login');
              },
            ),
          ListTile(
            title: const Text('Design System'),
            onTap: () {
              Navigator.pushNamed(context, '/example');
            },
          ),
        ],
      ),
    );
  }
}
