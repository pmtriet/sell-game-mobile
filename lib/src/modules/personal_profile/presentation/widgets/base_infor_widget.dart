part of '../pages/personal_profile_page.dart';

//avatar, cover img, name, followings, followers
class BaseInforWidget extends StatelessWidget {
  const BaseInforWidget({super.key});
  // final ShopAccountModel user;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.maybeWhen(
            authenticated: (user) {
              return Padding(
                padding: EdgeInsets.only(bottom: 24.w),
                child: SizedBox(
                  height: 176.w,
                  width: 390.w,
                  child: Stack(
                    children: [
                      //cover img and background of infor widget
                      Column(
                        children: [
                          //cover img
                          SizedBox(
                            height: 120.w,
                            child: user.background.filePath.isNotEmpty
                                ? CacheImageWidget(
                                    url: user.background.filePath,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    color: ColorName.grey353535,
                                  ),
                          ),
                          Container(
                            height: 51,
                            color: ColorName.background,
                          )
                        ],
                      ),
                      //infor widget (avatar, name, followings, followers)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //avatar
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Container(
                                width: 72.w,
                                height: 72.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: user.avatar.filePath.isNotEmpty
                                      ? CacheImageWidget(
                                          url: user.avatar.filePath,
                                          fit: BoxFit.cover,
                                        )
                                      : Assets.images.defaultUserAvatar.image(),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: UIConstants.padding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //name
                                    Text(
                                      user.fullname,
                                      style: context.textTheme.bodyLarge,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    //followings, followers
                                    // Wrap(
                                    //   children: [
                                    //     //followers
                                    //     Text.rich(
                                    //       TextSpan(
                                    //         children: [
                                    //           TextSpan(
                                    //             text: context.s.follower,
                                    //             style: context.textTheme.bodyMedium,
                                    //           ),
                                    //           TextSpan(
                                    //             text: user.follower.length.toString(),
                                    //             style: context.textTheme.headlineSmall,
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ),
                                    //     SizedBox(
                                    //       width: 16.w,
                                    //     ),
                                    //     //following
                                    //     Text.rich(
                                    //       TextSpan(
                                    //         children: [
                                    //           TextSpan(
                                    //             text: context.s.following,
                                    //             style: context.textTheme.bodyMedium,
                                    //           ),
                                    //           TextSpan(
                                    //             text: user.following.length.toString(),
                                    //             style: context.textTheme.headlineSmall,
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ],
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            orElse: () => const SizedBox.shrink());
      },
    );
  }
}
