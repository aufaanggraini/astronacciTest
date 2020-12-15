import 'package:asstronacci/bloc/auth_bloc.dart';
import 'package:asstronacci/homePage.dart';
import 'package:asstronacci/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(create: (context)=>AuthBloc(),child: MaterialApp(
      home: LoginPage(),
    ),);
  }
}


