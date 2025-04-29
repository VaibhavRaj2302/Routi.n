class Helperfunction {
  static String convertDateTimeToHumanReadable({required DateTime date}) {
    DateTime now = DateTime.now();
    DateTime inputDate = date; // Replace with actual input
    Duration difference = inputDate.difference(now);

    if (difference.inDays == 0) {
      return "Today";
    } else if (difference.inDays == 1) {
      return "Tomorrow";
    } else {
      return " ${inputDate.day}-${inputDate.month}-${inputDate.year}";
    }
  }
}
