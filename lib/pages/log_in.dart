import 'package:flutter/material.dart';
import 'package:mobile_app/components/login_form.dart';
import 'package:mobile_app/pages/sing_up.dart';
import 'package:mobile_app/utilis/my_colors.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  void navToSingUp() {
    Navigator.push(
      // ignore: inference_failure_on_instance_creation
      context, MaterialPageRoute(builder: (context) => const SingUp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              alignment: Alignment.center,
              child: const Image(image: AssetImage('assets/logo.png')),
            ),
            const SizedBox(
              height: 10,
            ),
            const LoginForm(),
            const SizedBox(
              height: 40,
            ),
            Align(
              child: Column(
                children: [
                  TextButton(
                    child: Text(
                      'Or sign in With',
                      style:
                          TextStyle(fontSize: 15, color: MyColors.purpleColor),
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          onPressed: () {},
                          child: Image.asset('assets/svg/google.png')),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          onPressed: () {},
                          child: Image.asset('assets/svg/facebook.png')),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                        ),
                        onPressed: () {},
                        child: Image.asset('assets/svg/twitter.png'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                        ),
                        onPressed: () {},
                        child: Image.asset('assets/svg/linkedin.png'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have account ?',
                        style: TextStyle(
                          fontSize: 15,
                          color: MyColors.purpleColor,
                        ),
                      ),
                      TextButton(
                        onPressed: navToSingUp,
                        child: Text(
                          'Sing Up',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: MyColors.purpleColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
