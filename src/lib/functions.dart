bool isNumeric(String value) {
  if (value == null) {
    return false;
  }
  return double.tryParse(value) != null;
}

int dateYear(String value) {
  int year;
  if (value == '') {
    year = DateTime.now().year;
  } else {
    List _dateArr = value.split("-");
    year = int.parse(_dateArr[0]);
  }
  return year;
}

int dateDay(String value) {
  int day;
  if (value == '') {
    day = DateTime.now().day;
  } else {
    List _dateArr = value.split("-");
    day = int.parse(_dateArr[2]);
  }
  return day;
}

int dateMonth(String value) {
  int month;
  if (value == '') {
    month = DateTime.now().day;
  } else {
    List _dateArr = value.split("-");
    month = int.parse(_dateArr[1]);
  }
  return month;
}
