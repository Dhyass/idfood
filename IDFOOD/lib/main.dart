import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:idfood/constants/constants.dart';
import 'package:idfood/firebase_options.dart';
import 'package:idfood/views/entrypoint.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

const Widget defaultHome = MainScreen();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: "assets/.env");

  //print("dotenv.env : ${dotenv.env}");

  if (!kIsWeb) {
    Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? "";
    await Stripe.instance.applySettings();
  }

 /*
  await dotenv.load(fileName: ".env");
  Stripe.publishableKey=dotenv.env["STRIPE_PUBLISHABLE_KEY"]!;
  await Stripe.instance.applySettings();*/
 // HttpClient client = HttpClient()..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 825),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'IDFOOD',
          theme: ThemeData(
            scaffoldBackgroundColor: kOffWhite,
            iconTheme: const IconThemeData(color: kDark),
            primarySwatch: Colors.grey,
          ),
          home: defaultHome,
        );
      },
    );
  }
}


//redegnim.com
//idmeal.com
//idmiza.com
//moromiza.com
// idtona.com
// B8A6jLUZLjizLBVV
// mongodb+srv://magnoudewanonzoou:B8A6jLUZLjizLBVV@idfood.llybiox.mongodb.net/
//mongodb+srv://magnoudewanonzoou:<password>@idfood.llybiox.mongodb.net/

// vqNqs5JSsPqR28Gz
//mongodb+srv://magnoudewanonzoou:vqNqs5JSsPqR28Gz@idfood.hky2fyd.mongodb.net/

// nom projet : idmeal
// username : idfood
// cluser : idfood
// password: QVxh1wxvlwJcnXl7
// connexion: mongodb+srv://idfood:QVxh1wxvlwJcnXl7@idfood.ptre1gr.mongodb.net/
// connexion string : mongodb+srv://idfood:<password>@idfood.ptre1gr.mongodb.net/
//monplat.com