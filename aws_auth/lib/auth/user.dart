/* To be updated! */
import 'package:aws_auth/auth/date.dart';

class User {
  int id;
  String name;
  String email;
  int isSplashScreenOne;
  int isSplashScreenTwo;
  String dateStart;
  String dateEnd;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.isSplashScreenOne,
      required this.isSplashScreenTwo,
      required this.dateStart,
      required this.dateEnd});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        isSplashScreenOne: json['splashOne'],
        isSplashScreenTwo: json['splashTwo'],
        dateStart: json['dateStart'],
        dateEnd: json['dateEnd']);
  }
}
