import 'package:chat_app/cubit/authcubit.dart';
import 'package:chat_app/repositries/routes.dart';
import 'package:chat_app/repositries/servicelocator.dart';
import 'package:chat_app/screens/login.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap:() async{
              await getit<Authcubit>().signout();

              getit<Approute>().pushutil(LoginPage());
            },
            child: Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: const Center(
        child: Text("authenticated"),
      ),
    );
  }
}