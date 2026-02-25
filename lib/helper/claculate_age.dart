class Helper{
  static String calculateAge(String? birthDate) {
    if(birthDate == '' || birthDate == null){
      return 'Not available';
    }

    DateTime birthDateTime = DateTime.parse(birthDate);

    DateTime currentDate = DateTime.now();

    int age = currentDate.year - birthDateTime.year;

    int month1 = currentDate.month;
    int month2 = birthDateTime.month;

    
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDateTime.day;

      if (day2 > day1) {
        age--;
      }
    }
    return age.toString();
  }
}
