import 'package:flutter/material.dart';
import 'package:memezitos_land_admin/auth.dart';
import 'package:memezitos_land_admin/routes.dart';

void main() => runApp(new LoginApp());

class LoginApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Memezitos Admin',
      theme: new ThemeData(
        primarySwatch: Colors.yellow,
      ),
      routes: routes,
    );
  }


}