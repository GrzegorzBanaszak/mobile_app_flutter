// ignore_for_file: prefer_conditional_assignment, omit_local_variable_types, prefer_final_locals

import 'package:flutter/material.dart';
import 'package:mobile_app/pages/home.dart';
import 'package:mobile_app/pages/log_in.dart';
import 'package:mobile_app/pages/sing_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLogin = prefs.getBool('isLogin') ?? false;
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => isLogin ? const Home() : const LogIn(),
        '/singin': (context) => const SingUp(),
        '/home': (context) => isLogin ? const Home() : const LogIn(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}
