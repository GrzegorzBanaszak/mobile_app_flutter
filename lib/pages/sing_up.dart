import 'package:flutter/material.dart';
import 'package:mobile_app/components/sign_up_form.dart';
import 'package:mobile_app/utilis/my_colors.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.keyboard_arrow_left_rounded),
                          Text('Back'),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -90,
                    right: 0,
                    child: Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999999),
                        color: MyColors.purpleColor,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -50,
                    right: -80,
                    child: Container(
                      width: 142,
                      height: 142,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999999),
                        color: MyColors.pinkColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sing up',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: MyColors.purpleColor,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const SignUpForm(),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account ?',
                        style: TextStyle(
                          fontSize: 15,
                          color: MyColors.purpleColor,
                        ),
                      ),
                      TextButton(
                        child: Text(
                          'Sing In',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: MyColors.purpleColor),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
