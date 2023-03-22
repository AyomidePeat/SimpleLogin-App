import 'package:flutter/material.dart';
import 'package:simple_login_app/model/user_model.dart';
import 'package:simple_login_app/repositories/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirestoreClass firestore = FirestoreClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Home Screen')),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Center(
        child: FutureBuilder<UserDetails?>(
          future: firestore.getUser(),
          builder: (BuildContext context, AsyncSnapshot<UserDetails?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasData) {
                return Text('Welcome, ${snapshot.data!.name}!');
              } else {
                return const Text('User not found');
              }
            }
          },
        ),
      ),
      ),
    );
  }
}
