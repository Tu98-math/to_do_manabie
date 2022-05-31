import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_manabie/page/welcome/welcome_page.dart';

import '/gen/assets.gen.dart';
import '/routing/route_generator.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To Do Manabie',
      onGenerateRoute: RouteGenerator().onGenerateRoute,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Assets.font.poppinsRegular),
      home: WelcomePage.instance(),
      debugShowCheckedModeBanner: false,
    );
  }
}
