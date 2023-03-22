import 'package:flutter/material.dart';
import 'package:simple_login_app/repositories/firebase_auth.dart';
import 'package:simple_login_app/screens/login_screen.dart';
import 'package:simple_login_app/widget/textfield_widget.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool isLoading = false;
  AuthenticationMethod authMethod = AuthenticationMethod();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
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
                "Create Account",
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
                  hint: 'Username',
                  obscure: false,
                  controller: usernameController),
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
                   String message= await authMethod.signUp(
                    username: usernameController.text,
                        email: emailController.text,
                        password: passwordController.text);
                        if (message=='Success' ){
                            
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                 
                                  content: Text("Account created successfully",
                                    
                                      style: TextStyle(fontSize: 16))));
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            } else {
                                setState(() {
                            isLoading = false;
                          });
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                
                                  content: Text(message,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16))));
                            }
                  },//write a function to sign in to firebase
                  
                  child: isLoading
                      ? const SizedBox(
                          height: 15,
                          child: AspectRatio(
                              aspectRatio: 1.0,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              )))
                      : const Text('Create Account',
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
                    'Do you have an account?',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: const Text(
                      'Login',
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
