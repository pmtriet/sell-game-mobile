import 'package:asuka/asuka.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../core/infrastructure/datasources/local/storage.dart';
import '../../../app/app_router.dart';
import '../../../auth/presentation/pages/login_page/login_page.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../marketplace/presentation/page/marketplace_page.dart';
import '../../../notification/presentation/pages/notification_page.dart';
import '../../../profile/presentation/page/profile_page.dart';

@RoutePage()
class TabBarPage extends StatelessWidget {
  const TabBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: const TabBarBody(),
    );
  }
}

class TabBarBody extends StatefulWidget {
  const TabBarBody({super.key});

  @override
  State<TabBarBody> createState() => _TabBarBodyState();
}

class _TabBarBodyState extends State<TabBarBody> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    MarketplacePage(),
    SizedBox.shrink(),
    NotificationPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      if (Storage.user != null) {
        context.router.push(const PostRoute());
      } else {
        AppDialogs.show(
          type: AlertType.notice,
          titleAction1: context.s.close,
          titleAction2: context.s.login,
          content: context.s.login_please,
          action2: () {
            Asuka.showModalBottomSheet(
              builder: (BuildContext context) {
                return const AuthPage();
              },
              isDismissible: true,
              elevation: 10,
              isScrollControlled: true,
            );
          },
        );
      }
    } else if (index == 3) {
      if (Storage.user == null) {
        AppDialogs.show(
          type: AlertType.notice,
          titleAction1: context.s.close,
          titleAction2: context.s.login,
          content: context.s.login_please,
          action2: () {
            Asuka.showModalBottomSheet(
              builder: (BuildContext context) {
                return const AuthPage();
              },
              isDismissible: true,
              elevation: 10,
              isScrollControlled: true,
            );
          },
        );
      } else {
        setState(() {
          _selectedIndex = index;
        });
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.background,
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Assets.icons.tabbarHome.svg(
              color: _selectedIndex == 0
                  ? ColorName.primary
                  : ColorName.whiteF1F1F1,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.tabbarCart.svg(
              color: _selectedIndex == 1
                  ? ColorName.primary
                  : ColorName.whiteF1F1F1,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.add.svg(
              width: 56.w,
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.tabbarNotification.svg(
              color: _selectedIndex == 3
                  ? ColorName.primary
                  : ColorName.whiteF1F1F1,
            ),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.tabbarProfile.svg(
              color: _selectedIndex == 4
                  ? ColorName.primary
                  : ColorName.whiteF1F1F1,
            ),
            label: 'Personal',
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: ColorName.primary,
        // unselectedItemColor: ColorName.whiteF1F1F1,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorName.background,
      ),
    );
  }
}
