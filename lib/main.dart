import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:daily_workout/lib_control/theme_control.dart';
import 'package:daily_workout/calendar/calendar_control.dart';
import 'package:daily_workout/login_page/splash.dart';
import 'package:daily_workout/settings/settings.dart';
import 'package:daily_workout/daily_workout/mainpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  await FirebaseAdMob.instance
      .initialize(appId: 'ca-app-pub-9496987862300851~7069103904');
  initializeDateFormatting().then((dynamic) => runApp(StartWorkout()
      /*ChangeNotifierProvider(
          create: (context) => SimpleState(),
          child: StateLoginDemo(),*/
      ));
}

class StartWorkout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //double width = MediaQuery.of(context).size.width;
    return GetMaterialApp(
      title: 'MainPage',
      theme: ThemeControl.firstDesign,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/c',
          page: () => CalendarPage(
            title: 'Table Calendar Demo',
          ),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: '/h',
          page: () => MainPage(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: '/s',
          page: () => Settings(),
          transition: Transition.noTransition,
        ),
      ],
      //rootnavigator false 페이지 유지가능 Navigator.of(context, rootNavigator: false).pushNamed("/route");
      // Get.to(page,{argument,transition})
      //Get.argument
      //Get.back
      // async{
      // final data = await Get.to()}
      //Get.back(result:)
      //getPages:[
      // GetPage(
      // name:,
      // page:()=>]
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.data == null) {
            return Scaffold(
              backgroundColor: color1,
              body: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Daily Workout',
                            style: TextStyle(
                                color: colorWhite,
                                fontFamily: 'godo',
                                fontWeight: FontWeight.bold,
                                fontSize: 40),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'Simple & Easy Workout Tracker',
                            style: TextStyle(fontFamily: 'godo'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                              onTap: () {
                                signInWithFacebook();
                              },
                              child: Image.asset(
                                'images/facebook.png',
                                width: 200,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                              onTap: () {
                                signInWithGoogle();
                              },
                              child: Image.asset(
                                'images/google.png',
                                width: 205,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            //print(FirebaseAuth.instance.currentUser.uid);
            return Splash();
            /*return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${snapshot.data.displayName}님 환영합니다."),
                    FlatButton(
                      color: Colors.grey.withOpacity(0.3),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: Text("로그아웃"),
                    ),
                  ],
                ),
              );*/
          }
        },
      ),
      builder: (BuildContext context, Widget child) {
        return new Padding(
          child: child,
          padding: EdgeInsets.only(bottom: 55.0),
        );
      },
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    try {print('!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      final AccessToken accessToken = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final FacebookAuthCredential credential = FacebookAuthProvider.credential(
        accessToken.token,
      );
      print(credential);
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FacebookAuthException catch (e) {
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          print("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          print("login cancelled");
          break;
        case FacebookAuthErrorCode.FAILED:
          print("login failed");
          break;
      }
      // handle the FacebookAuthException
    } on FirebaseAuthException catch (e) {
      // handle the FirebaseAuthException
    } finally {}
    return null;
  }
}
