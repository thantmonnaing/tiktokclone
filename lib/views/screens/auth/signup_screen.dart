import 'package:flutter/material.dart';
import 'package:tiktokclone/constants.dart';
import 'package:tiktokclone/controllers/auth_controller.dart';
import 'package:tiktokclone/views/screens/auth/login_screen.dart';
import 'package:tiktokclone/views/widgets/text_input_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                "TikTok Clone",
                style: TextStyle(
                    color: buttonColor, fontSize: 35, fontWeight: FontWeight.w900),
                        ),
                        const Text(
                "Register",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(
                height: 15,
                        ),
                        Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://icon-library.com/images/default-user-icon/default-user-icon-13.jpg'),
                    backgroundColor: Colors.black,
                  ),
                  Positioned(
                      bottom: -12,
                      left: 60,
                      child: IconButton(
                          onPressed: () {
                            authController.pickImage();
                          },
                          icon: const Icon(Icons.camera_alt))),
                ],
                        ),
                        const SizedBox(
                height: 20,
                        ),
                        Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                    controller: _usernameController,
                    icon: Icons.person,
                    labelText: "Username"),
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
                onTap: () => authController.registerUser(
                    _usernameController.text,
                    _emailController.text,
                    _passwordController.text,
                    authController.profilePhoto),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Center(
                    child: Text(
                      "Sign up",
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
                    "Already have an account?",
                    style: TextStyle(fontSize: 20),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      " Login",
                      style: TextStyle(fontSize: 20, color: buttonColor),
                    ),
                  )
                ],
                        )
                      ],
                ),
              ),
            )),
    );
  }
}
