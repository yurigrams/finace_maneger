import 'package:finace_maneger/components/app_colors.dart';
import 'package:finace_maneger/components/base_page.dart';
import 'package:finace_maneger/pages/home_page.dart';
import 'package:finace_maneger/pages/login_page.dart';
import 'package:finace_maneger/pages/register_expense_page.dart';
import 'package:finace_maneger/pages/register_user_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
      ThemeData(
          primaryColor: AppColors.primarygroundColor,
        colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primarygroundColor,
            primary: AppColors.backgroundColor,
        ),
          textTheme: GoogleFonts.robotoTextTheme(
            ThemeData.light().textTheme,
          ).apply(
            bodyColor: AppColors.white,
            displayColor: AppColors.white
          ),
          fontFamily: GoogleFonts.roboto().fontFamily,
          useMaterial3: false
      ),
      initialRoute: 'login',
      routes: {
        '/':(context)=>HomePage(),
        'login':(context)=>LoginPage(),
        'register/user':(context)=>UserRegistrationPage(),
        'register/expense':(context)=>RegisterExpensePage(),
        // 'chat':(context)=>ChatPage(),

      },
      // home: LoginPage(),
    ),
  );
}