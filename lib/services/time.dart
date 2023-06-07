class Time {
  static String hour(DateTime date) => date.hour.toString().padLeft(2, "0");

  static String minute(DateTime date) => date.minute.toString().padLeft(2, "0");

  static String dayHour(DateTime date) => "${hour(date)}:${minute(date)}";

  static String day(DateTime date) => date.day.toString().padLeft(2, "0");

  static String month(DateTime date) => date.month.toString().padLeft(2, "0");

  static String year(DateTime date) => date.year.toString().padLeft(2, "0");

  static String yearDay(DateTime date) =>
      "${day(date)}/${month(date)}/${year(date)}";

  static List<String> weekDays = [
    "Domingo",
    "Segunda-feira",
    "Terça-feira",
    "Quarta-feira",
    "Quinta-feira",
    "Sexta-feira",
    "Sábado",
  ];
}
