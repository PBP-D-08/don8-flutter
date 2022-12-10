import 'package:don8_flutter/models/globals/available_donation.dart';

class LastDonation {
  static Map<String, dynamic> time = {};

  static String getTime(int donationId) {
    if (LastDonation.time[donationId.toString()] == null) {
      return "-";
    }
    return LastDonation.time[donationId.toString()];
  }

  static void reset() {
    for (var i = 0; i < AvailableDonation.pkList.length; i++) {
      LastDonation.time[AvailableDonation.pkList[i]] = "-";
    }
  }
}