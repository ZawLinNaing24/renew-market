import 'package:flutter/material.dart';
import 'package:renew_market/constatns/app_theme.dart';
import 'package:renew_market/screens/sign_in_screen.dart';
import 'package:renew_market/widgets/custom_input_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPwdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPwdController.dispose();
    _nameController.dispose();
    _nickNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  introductoryText,
                  style: title1,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: text,
                  ),
                ),
              ),
              CustomInputField(
                type: "email",
                lines: 1,
                controller: _emailController,
                validationMessage: "Email cannot be Blank.",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: text,
                  ),
                ),
              ),
              CustomInputField(
                type: "password",
                lines: 1,
                controller: _passwordController,
                validationMessage: "Password cannot be Blank.",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Confirm Password",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: text,
                  ),
                ),
              ),
              CustomInputField(
                type: "confirm_password",
                lines: 1,
                controller: _confirmPwdController,
                validationMessage: "Confirm Password cannot be Blank.",
                originalPassword: _passwordController.text,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: text,
                  ),
                ),
              ),
              CustomInputField(
                lines: 1,
                controller: _nameController,
                validationMessage: "Name cannot be Blank.",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Nickname",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: text,
                  ),
                ),
              ),
              CustomInputField(
                lines: 1,
                controller: _nickNameController,
                validationMessage: "NickName cannot be Blank.",
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black38, width: 1)),
        ),
        child: BottomAppBar(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                }
              },
              child: Text(
                "Sign up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
