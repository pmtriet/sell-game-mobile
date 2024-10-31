// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../common/widgets/login_text_widget.dart';
// import '../../../auth/application/cubit/auth_cubit.dart';
// import 'budget_widget.dart';
// import 'order_management_widget.dart';
// import 'other_widget.dart';
// import 'sell_management_widget.dart';
// import 'user_infor_widget.dart';
// import 'utilities_widget.dart';
part of '../page/profile_page.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = false;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.w,
                    ),

                    state.maybeMap(authenticated: (state) {
                      isLoggedIn = true;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //account
                          UserInforWidget(
                              name: state.user.fullname,
                              img: state.user.avatar.filePath,
                              followings: state.user.following.length,
                              followers: state.user.follower.length),
                          //budget
                          BudgetWidget(
                            availableBalance: state.user.balance,
                            pendingBalance: state.user.pendingBalance,
                          )
                        ],
                      );
                    }, orElse: () {
                      isLoggedIn = false;
                      return const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LoginTextWidget(),
                          //budget
                          BudgetWidget(),
                        ],
                      );
                    }),

                    //sell magnagement
                    SellManagementWidget(
                      isLoggedIn: isLoggedIn,
                    ),
                    //order management
                    OrderManagementWidget(
                      isLoggedIn: isLoggedIn,
                    ),
                    //utilities
                    UtilitiesWidget(
                      isLoggedIn: isLoggedIn,
                    ),
                    //other
                    OtherWidget(isLoggedIn: isLoggedIn)
                  ],
                ),
                if (state == const AuthState.loading())
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height,
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(child: CircularProgressIndicator()),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
