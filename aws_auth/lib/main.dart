import 'package:aws_auth/auth/auth_service.dart';
import 'package:aws_auth/signin/signin_page.dart';
import 'package:aws_auth/utils/date_simple_preferences.dart';
import 'package:aws_auth/widgets/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/auth.dart';

const SERVER_IP = 'http://192.168.42.75:8000';
//final storage = FlutterSecureStorage();
void main() async {
  // await DateSimplePreferences.init();
  runApp(ChangeNotifierProvider(
    create: (context) => Auth(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences sharedPreferences;
  final storage = new FlutterSecureStorage();
  String _dateEndString = "";

  void _tryToAuthenticate() async {
    var token = await storage.read(key: 'token');
    var dateEnd = await storage.read(key: 'dateEnd');
    //var isSplashOne = await storage.read(key: 'isSplashOne');

    Provider.of<Auth>(context, listen: false).attempt(token: token);
    // Provider.of<Auth>(context, listen: false).attemptDate(endDate: dateEnd);
  }

  _loadDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _dateEndString = (prefs.getString('endDatePref') ?? "");
    });
  }
  /*
  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null) return "";
    return jwt;
  }
  */

/*
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => SignInPage()),
          (Route<dynamic> route) => false);
    }
  }
*/
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _tryToAuthenticate();
    _loadDate();
    // _authService.showLogIn();
  }

/*
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => SignInPage()),
          (Route<dynamic> route) => false);
    }
  }
*/
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        /*
      routes: {
        '/': (context) => const SignInPage(),
        '/feed-page': (context) => const FeedPage(),
        '/sign-up': (context) => const SignUpPage(),
      },
      */

        home: SignInPage());
  }
}
