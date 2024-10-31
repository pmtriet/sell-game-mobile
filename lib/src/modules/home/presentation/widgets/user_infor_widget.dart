part of '../pages/home_page.dart';

class UserInforWidget extends StatelessWidget {
  const UserInforWidget({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                //Avatar
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    width: 39.w,
                    height: 39.w,
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
                //Name
                Expanded(
                  child: Text(
                    user.fullname,
                    style: context.textTheme.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [
                //amount
                Text(
                  '${user.balance.toNumberFormat()}${context.s.currency_unit}',
                  style: context.textTheme.contentMedium,
                ),
                //
                SizedBox(width: 8.w),

                // Budget Icon Button
                GestureDetector(
                  onTap: () {
                    //TODO: add money to account
                  },
                  child: Container(
                    height: 20.w,
                    width: 20.w,
                    decoration: BoxDecoration(
                      color: ColorName.primary,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: ColorName.black,
                        size: 20.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
