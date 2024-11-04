import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth{
  static String PASSWORD = "fpEV.JY.R2zw7Uv";
  static Future<Map<String,String>?> signin()async{
   GoogleSignInAccount? gUser=await GoogleSignIn().signIn();
   if(gUser!=null){
     return {
       "email":gUser.email,
       "name":gUser.displayName??'',
       "password":PASSWORD
     };
   }
   return null;
  }

}