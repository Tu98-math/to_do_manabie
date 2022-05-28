import 'package:flutter/material.dart';

import '/base/base_state.dart';
import '/gen/app_colors.dart';
import '/util/dimens.dart';
import 'home_provider.dart';
import 'home_vm.dart';
import 'tab/all/all_tab.dart';
import 'tab/complete/complete_tab.dart';
import 'tab/incomplete/incomplete_tab.dart';

class HomePage extends StatefulWidget {
  final WidgetRef watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return HomePage._(watch);
    });
  }

  const HomePage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends BaseState<HomePage, HomeViewModel> {
  PageController tabController = PageController();
  int currentTab = 0;

  List<Widget> tab = [
    AllTab.instance(),
    CompleteTab.instance(),
    IncompleteTab.instance()
  ];

  void goTab(int index) {
    setState(() {
      currentTab = index;
    });
  }

  void tabClick(int index) {
    setState(() {
      currentTab = index;
    });
    tabController.animateToPage(
      currentTab,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      bottomNavigationBar: buildBottomNavigationBar(
        currentIndex: currentTab,
        press: tabClick,
      ),
    );
  }

  Widget buildBody() {
    return SizedBox(
      width: double.infinity,
      height: screenHeight,
      child: PageView.builder(
        itemCount: tab.length,
        onPageChanged: (index) => goTab(index),
        itemBuilder: (context, index) => tab[index],
        controller: tabController,
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar({
    required int currentIndex,
    required Function press,
  }) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      backgroundColor: Colors.white,
      items: [
        buildBottomNavigationBarItem(
          title: 'All',
          icon: Icons.list_alt,
          index: 0,
        ),
        buildBottomNavigationBarItem(
          title: 'Complete',
          icon: Icons.check_box_outlined,
          index: 1,
        ),
        buildBottomNavigationBarItem(
          title: 'Incomplete',
          icon: Icons.incomplete_circle,
          index: 2,
        ),
      ],
      onTap: (index) => press(index),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required String title,
    required IconData icon,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(
          top: 4,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: currentTab != index
                  ? AppColors.neutral.grey
                  : AppColors.primary.blue,
            ),
            SizedBox(height: 4.w),
            Text(
              title,
              style: TextStyle(
                color: currentTab != index
                    ? AppColors.neutral.grey
                    : AppColors.primary.blue,
                fontSize: 12.t,
              ),
            )
          ],
        ),
      ),
      label: title,
    );
  }

  @override
  HomeViewModel getVm() => widget.watch.watch(viewModelProvider);
}
