class IsSplashScreens {
  int id;
  String name;
  String email;
  int isSplashScreenOne;
  int isSplashScreenTwo;

  IsSplashScreens(
      {required this.id,
      required this.name,
      required this.email,
      required this.isSplashScreenOne,
      required this.isSplashScreenTwo});

  factory IsSplashScreens.fromJson(Map<String, dynamic> json) {
    return IsSplashScreens(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        isSplashScreenOne: json['splashOne'],
        isSplashScreenTwo: json['splashTwo']);
  }
}
