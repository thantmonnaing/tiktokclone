import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tiktokclone/constants.dart';
import 'package:tiktokclone/views/screens/auth/signup_screen.dart';
import 'package:tiktokclone/views/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "TikTok Clone",
            style: TextStyle(
                color: buttonColor, fontSize: 35, fontWeight: FontWeight.w900),
          ),
          const Text(
            "Login",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
                controller: _emailController,
                icon: Icons.email,
                labelText: "Email"),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _passwordController,
              icon: Icons.lock,
              labelText: "Password",
              isObscre: true,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () => {
              authController.loginUser(
                  _emailController.text, _passwordController.text),
              print("login success")
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const Center(
                child: Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account?",
                style: TextStyle(fontSize: 20),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignupScreen()));
                },
                child: Text(
                  " Register",
                  style: TextStyle(fontSize: 20, color: buttonColor),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
