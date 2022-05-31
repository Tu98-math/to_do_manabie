import 'package:flutter/material.dart';
import 'package:to_do_manabie/model/task_model.dart';

import '/base/base_state.dart';
import '/gen/app_colors.dart';
import 'home_provider.dart';
import 'home_vm.dart';
import 'tab/all/all_tab.dart';
import 'tab/complete/complete_tab.dart';
import 'tab/incomplete/incomplete_tab.dart';
import '/util/extension/extension.dart';

class HomePage extends StatefulWidget {
  final ScopedReader watch;

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
  final PageController tabController = PageController();
  int currentTab = 0;

  List<Widget> tab = [];

  int countComplete = 0, countIncomplete = 0;

  @override
  void initState() {
    getVm().bsLoading.listen((value) {
      if (!value) {
        tab = [
          AllTab.instance(),
          CompleteTab.instance(() => tabClick(2)),
          IncompleteTab.instance(),
        ];
        setState(() {});
      }
    });

    getVm().bsTask.listen((value) {
      countComplete = 0;
      countIncomplete = 0;
      for (int i = 0; i < (value ?? []).length; i++) {
        if (value![i].completed ?? true) {
          countComplete++;
        } else {
          countIncomplete++;
        }
      }
      if (countComplete + countIncomplete == 0) {
        tab = [
          AllTab.instance(),
        ];
      } else {
        tab = [
          AllTab.instance(),
          CompleteTab.instance(() => tabClick(2)),
          IncompleteTab.instance(),
        ];
      }
      setState(() {});
    });
    super.initState();
  }

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
      backgroundColor: Colors.white,
      bottomNavigationBar: (countIncomplete + countComplete) > 0
          ? buildBottomNavigationBar(
              currentIndex: currentTab,
              press: tabClick,
            )
          : null,
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
      items: <BottomNavigationBarItem>[
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
      icon: Column(
        children: [
          Icon(
            icon,
            color: currentTab != index
                ? AppColors.neutral.grey
                : AppColors.primary.blue,
          ),
          SizedBox(height: 4.w),
          title
              .plain()
              .color(
                currentTab != index
                    ? AppColors.neutral.grey
                    : AppColors.primary.blue,
              )
              .fSize(12)
              .b(),
        ],
      ).pad(4),
      label: title,
    );
  }

  @override
  HomeViewModel getVm() => widget.watch(viewModelProvider).state;
}
