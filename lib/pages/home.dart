import 'package:flutter/material.dart';
import 'package:mobile_app/components/circle.dart';
import 'package:mobile_app/db/user_db.dart';
import 'package:mobile_app/models/user.dart';
import 'package:mobile_app/pages/log_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user;
  String test = 'Hello';
  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final db = UserDB();
    User item = await db.getById(prefs.getInt('userId')!);
    setState(() {
      user = item;
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLogin", false);
    await prefs.setInt("userId", 0);

    Navigator.pop(context);
    await Navigator.push(
      // ignore: inference_failure_on_instance_creation
      context, MaterialPageRoute(builder: (context) => const LogIn()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          const Positioned(
            top: -150,
            left: -20,
            child: Circle(
              color: '#BB84E8',
              size: 250,
            ),
          ),
          const Positioned(
            top: -120,
            right: -120,
            child: Circle(
              color: '#471AA0',
              size: 300,
            ),
          ),
          const Positioned(
            bottom: -170,
            left: -50,
            child: Circle(
              color: '#471AA0',
              size: 320,
            ),
          ),
          const Positioned(
            bottom: -180,
            right: -70,
            child: Circle(
              color: '#BB84E8',
              size: 250,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Welcome'),
                Text(user?.fullName ?? ""),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: logout,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
