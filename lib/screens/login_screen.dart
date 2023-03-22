import 'package:flutter/material.dart';
import 'package:simple_login_app/repositories/firebase_auth.dart';
import 'package:simple_login_app/screens/create_account_screen.dart';
import 'package:simple_login_app/screens/homepage.dart';

import 'package:simple_login_app/widget/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthenticationMethod authMethod = AuthenticationMethod();
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(45.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.25),
              const Text(
                "Login",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'poppins',
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFieldWidegt(
                  hint: 'Email', obscure: false, controller: emailController),
              const SizedBox(height: 10),
              TextFieldWidegt(
                  hint: 'Password',
                  obscure: true,
                  controller: passwordController),
              const SizedBox(height: 10),
              SizedBox(
                width: 400,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                   String message = await authMethod.signIn(
                        email: emailController.text,
                        password: passwordController.text);
                          if (message=='Success' ){
                            
                            
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            } else {
                                setState(() {
                            isLoading = false;
                          });
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                
                                  content: Text(message,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16))));
                            }
                  },
                  child: isLoading
                      ? const SizedBox(
                          height: 15,
                          child: AspectRatio(
                              aspectRatio: 1.0,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              )))
                      : const Text('Login',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                ),
              ),
              //const SizedBox(height: ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateAccountScreen()));
                    },
                    child: const Text(
                      'Create',
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
