import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/auth_screen.dart';
import 'package:flutter_chat_app/screens/chat_list_screen.dart';
import 'package:flutter_chat_app/widgets/bottom_nav_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final FirebaseApp app = await Firebase.initializeApp();
  await Firebase.initializeApp();
  // runApp(MyApp(app));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final FirebaseApp app;

  // MyApp(this.app);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.lightBlue.shade200,
          accentColor: Colors.lime.shade300,
          fontFamily: 'Lato',
          buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.lightBlue.shade200,
        )
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            return CustomBottomNavBar();
          } 
          return AuthScreen();
        }
      ),
      routes: {
        AuthScreen.routeName: (context) => AuthScreen(),
        ChatListScreen.routeName: (context) => ChatListScreen()
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startSplashScreen() {
    var duration = Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
    });
  }

  @override
  void initState() {
    startSplashScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(109, 180, 227, 1).withOpacity(0.8),
              Color.fromRGBO(227, 156, 109, 1).withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 1],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                width: deviceSize.width * 0.5,
                height: deviceSize.height * 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
