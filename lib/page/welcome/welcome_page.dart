import 'package:flutter/material.dart';
import '/util/extension/extension.dart';

import '/base/base_state.dart';
import '/gen/assets.gen.dart';
import '/routing/app_routes.dart';
import 'welcome_provider.dart';
import 'welcome_vm.dart';

class WelcomePage extends StatefulWidget {
  final WidgetRef watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return WelcomePage._(watch);
    });
  }

  const WelcomePage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return WelcomeState();
  }
}

class WelcomeState extends BaseState<WelcomePage, WelcomeViewModel> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAndToNamed(AppRoutes.HOME);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      color: Colors.white,
      width: screenWidth,
      child: Assets.images.logo.image().center(),
    );
  }

  @override
  WelcomeViewModel getVm() => widget.watch.watch(viewModelProvider);
}
