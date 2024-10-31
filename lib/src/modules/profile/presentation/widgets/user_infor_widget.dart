
part of '../page/profile_page.dart';

class UserInforWidget extends StatelessWidget {
  const UserInforWidget(
      {super.key,
      required this.name,
      required this.img,
      required this.followers,
      required this.followings});
  final String name;
  final String img;
  final int? followers;
  final int? followings;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(const PersonalProfileRoute());
      },
      child: SizedBox(
        height: 64.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //avatar
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Container(
                width: 48.w,
                height: 48.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: img.isNotEmpty
                      ? CacheImageWidget(
                          url: img,
                          fit: BoxFit.cover,
                        )
                      : Assets.images.defaultUserAvatar.image(),
                ),
              ),
            ),
            //Name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //name
                  Text(
                    name.toUpperCase(),
                    style: context.textTheme.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  //followings, followers
                  // Row(
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
                  //             text: followers.toString(),
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
                  //             text: followers.toString(),
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
          ],
        ),
      ),
    );
  }
}
