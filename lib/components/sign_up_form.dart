import 'package:flutter/material.dart';
import 'package:mobile_app/components/input_form.dart';
import 'package:mobile_app/db/user_db.dart';
import 'package:mobile_app/pages/home.dart';
import 'package:mobile_app/utilis/my_colors.dart';
import 'package:mobile_app/utilis/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  Future<void> onSingUp() async {
    if (_formKey.currentState!.validate() &&
        passwordController.text == rePasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      FocusManager.instance.primaryFocus?.unfocus();

      try {
        final db = UserDB();
        final id = await db.create(
          email: emailController.text,
          fullName: fullNameController.text,
          password: passwordController.text,
        );

        final prefs = await SharedPreferences.getInstance();

        await prefs.setBool(
          'isLogin',
          true,
        );
        await prefs.setInt(
          'userId',
          id,
        );
        await Navigator.push(
          // ignore: inference_failure_on_instance_creation
          context, MaterialPageRoute(builder: (context) => const Home()),
        );
      } on DatabaseException catch (e) {
        if (e.getResultCode() == 2067) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'User on this email exist',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
      }
    } else if (_formKey.currentState!.validate() &&
        passwordController.text != rePasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Passwords must by the same',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red[800],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomInputForm(
            placeholder: 'Full Name',
            icon: CustomInputFormIcon.USER,
            validator: defaultValitator,
            controller: fullNameController,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomInputForm(
            placeholder: 'Email',
            icon: CustomInputFormIcon.EMAIL,
            validator: emailValidator,
            controller: emailController,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomInputForm(
            placeholder: 'Password',
            icon: CustomInputFormIcon.PASSWORD,
            validator: passwordValidation,
            controller: passwordController,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomInputForm(
            placeholder: 'Confirm Password',
            icon: CustomInputFormIcon.PASSWORD,
            validator: passwordValidation,
            controller: rePasswordController,
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: onSingUp,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: MyColors.pinkColor,
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('Sing Up'),
          ),
        ],
      ),
    );
  }
}
