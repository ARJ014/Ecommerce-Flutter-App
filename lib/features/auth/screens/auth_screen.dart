import 'package:amazon_clone/common/widget/button.dart';
import 'package:amazon_clone/common/widget/textField.dart';
import 'package:amazon_clone/constants/golabal_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth { signIn, signUp }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const String name = "Authpage";
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth auth = Auth.signUp;
  final signInFormkey = GlobalKey<FormState>();
  final signUpFormkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final authService authservice = authService();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    passController.dispose();
  }

  void signup() {
    authservice.signUpUser(
        name: nameController.text,
        email: emailController.text,
        password: passController.text,
        context: context);
  }

  void signin() {
    authservice.signInUser(
        email: emailController.text,
        password: passController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 15),
            ListTile(
              tileColor: (auth == Auth.signUp)
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                "Create Account",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signUp,
                  groupValue: auth,
                  onChanged: (value) {
                    setState(() {
                      auth = value!;
                    });
                  }),
            ),
            if (auth == Auth.signUp)
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: signUpFormkey,
                  child: Column(children: [
                    CustomTextField(
                        controller: nameController, hintText: "Name"),
                    const SizedBox(height: 10),
                    CustomTextField(
                        controller: emailController, hintText: "Email"),
                    const SizedBox(height: 10),
                    CustomTextField(
                        controller: passController, hintText: "Password"),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                          text: "Sign Up",
                          ontap: () {
                            if (signUpFormkey.currentState!.validate()) {
                              signup();
                            }
                          }),
                    )
                  ]),
                ),
              ),
            const SizedBox(height: 20),
            ListTile(
              tileColor: (auth == Auth.signIn)
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                "Sign In.",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signIn,
                  groupValue: auth,
                  onChanged: (value) {
                    setState(() {
                      auth = value!;
                    });
                  }),
            ),
            if (auth == Auth.signIn)
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: signInFormkey,
                  child: Column(children: [
                    const SizedBox(height: 10),
                    CustomTextField(
                        controller: emailController, hintText: "Email"),
                    const SizedBox(height: 10),
                    CustomTextField(
                        controller: passController, hintText: "Password"),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                          text: "Sign In",
                          ontap: () {
                            if (signInFormkey.currentState!.validate()) {
                              signin();
                            }
                          }),
                    )
                  ]),
                ),
              ),
          ],
        ),
      )),
    );
  }
}
