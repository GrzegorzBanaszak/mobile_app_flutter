import 'package:flutter/material.dart';
import 'package:mobile_app/components/input_form.dart';
import 'package:mobile_app/db/user_db.dart';
import 'package:mobile_app/pages/home.dart';
import 'package:mobile_app/utilis/my_colors.dart';
import 'package:mobile_app/utilis/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> singin() async {
    if (_formKey.currentState!.validate()) {
      final db = UserDB();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Processing Data',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.blue[900],
        ),
      );
      FocusManager.instance.primaryFocus?.unfocus();

      final id = await db.login(
        loginValue: emailController.text,
        password: passwordController.text,
      );

      if (id != null) {
        final prefs = await SharedPreferences.getInstance();

        await prefs.setBool(
          'isLogin',
          true,
        );
        await prefs.setInt(
          'userId',
          id,
        );
        Navigator.pop(
          context,
        );
        await Navigator.push(
          // ignore: inference_failure_on_instance_creation
          context, MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Wrong username or password',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red[900],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Sing In',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: MyColors.purpleColor,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomInputForm(
            placeholder: 'Email or User Name',
            icon: CustomInputFormIcon.USER,
            validator: emailValidator,
            controller: emailController,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomInputForm(
            placeholder: 'Password',
            icon: CustomInputFormIcon.PASSWORD,
            validator: defaultValitator,
            controller: passwordController,
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              child: Text(
                'Forget password?',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: MyColors.purpleColor,
                ),
              ),
              onPressed: () {},
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: singin,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: MyColors.pinkColor,
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('Sing in'),
          ),
        ],
      ),
    );
  }
}
