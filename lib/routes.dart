import 'package:flutter/material.dart';
import 'package:memezitos_land_admin/screens/home/home_screen.dart';
import 'package:memezitos_land_admin/screens/login/login_screen.dart';
import 'package:memezitos_land_admin/screens/instagramfeed/instagramfeed_screen.dart';

final routes = {
  '/login':           (BuildContext context) => new LoginScreen(),
  '/home':            (BuildContext context) => new HomeScreen(),
  '/':                (BuildContext context) => new LoginScreen(),
  '/instagram/feed' : (BuildContext context) => new InstagramFeedScreen(),
};