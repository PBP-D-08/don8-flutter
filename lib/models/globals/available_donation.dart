class AvailableDonation {
  static List<String> pkList = [];

  static void addToList(int donationPk) {
    if (!AvailableDonation.pkList.contains(donationPk.toString())) {
      AvailableDonation.pkList.add(donationPk.toString());
    }
  }
}