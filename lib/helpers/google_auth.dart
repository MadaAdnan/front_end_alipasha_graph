import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class GoogleAuth {
  static String PASSWORD = "fpEV.JY.R2zw7Uv";

/*  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );
  static Future<Map<String, String>?> signin() async {
    GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser != null) {
      return {
        "email": gUser.email,
        "name": gUser.displayName ?? '',
        "password": PASSWORD
      };
    }
    return null;
  }*/
  static final  GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static Future<Map<String, String>?> signIn() async {

    try {
    _googleSignIn.initialize();
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      if (googleUser == null) return null;
Logger().i("GOOGLE USERT");
Logger().i(googleUser.email);
        return {
          "email": googleUser.email,
          "name": googleUser.displayName ?? '',
          "password": PASSWORD,
        };


      return null;
    } catch (error) {
      print("Google Sign-In Error: $error");
      return null;
    }
  }





  static Future<void> logOut() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.signOut();
    } catch (e) {}
  }
}
