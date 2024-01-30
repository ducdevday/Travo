import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/features/default/widgets/bottombar/my_bottom_nav_bar_cubit.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBottomNavBarCubit, int>(
      builder: (context, selectedPage) {
        return Container(
          padding: EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 24),
          color: Colors.white,
          child: GNav(
              rippleColor: AppColor.nonactiveColor,
              hoverColor: AppColor.nonactiveColor,
              haptic: true,
              tabBorderRadius: 24,
              gap: 8,
              color: AppColor.secondaryColor,
              activeColor: AppColor.primaryColor,
              iconSize: 24,
              tabBackgroundColor: AppColor.secondaryColor,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              selectedIndex: selectedPage,
              onTabChange: (page) {
                context.read<MyBottomNavBarCubit>().selectPage(page);
              },
              tabs: [
                GButton(
                  icon: Icons.home_rounded,
                  text: 'Home',
                  leading: SvgPicture.asset(AppPath.icHome, color: selectedPage == 0 ? AppColor.primaryColor : AppColor.secondaryColor,width: 24, height: 24,),
                ),
                GButton(
                  icon: Icons.favorite_rounded,
                  text: 'Favourite',
                  leading: SvgPicture.asset(AppPath.icFavourite, color: selectedPage == 1? AppColor.primaryColor : AppColor.secondaryColor,width: 24, height: 24,),
                ),
                GButton(
                  icon: Icons.work_rounded,
                  text: 'Payment',
                  leading: SvgPicture.asset(AppPath.icPayment, color: selectedPage == 2 ? AppColor.primaryColor : AppColor.secondaryColor,width: 24, height: 24,),
                ),
                GButton(
                  icon: Icons.account_circle_rounded,
                  text: 'Profile',
                  leading: SvgPicture.asset(AppPath.icProfile, color: selectedPage == 3 ? AppColor.primaryColor : AppColor.secondaryColor,width: 24, height: 24,),
                )
              ]),
        );
      },
    );
  }
}
