/* To be updated! */
class User {
  int id;
  String name;
  String email;
  int isSplashScreenOne;
  int isSplashScreenTwo;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.isSplashScreenOne,
      required this.isSplashScreenTwo});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        isSplashScreenOne: json['splashOne'],
        isSplashScreenTwo: json['splashTwo']);
  }
}
