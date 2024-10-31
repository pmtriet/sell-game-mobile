part of '../pages/personalprofile_edit_page.dart';

class RowInforWidget extends StatelessWidget {
  const RowInforWidget(
      {super.key,
      required this.enable,
      required this.title,
      required this.content,
      this.onTap});
  final bool enable;
  final String title;
  final String? content;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 37.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //title, content
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //title
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text(
                      title,
                      style: context.textTheme.displaySmall,
                    ),
                  ),

                  //content
                  if (content != null)
                    Flexible(
                      child: Text(
                        content!,
                        style: context.textTheme.headlineSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                ],
              ),
            ),
            //button
            if (enable)
              Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16.w,
                  color: ColorName.greyBBBBBB,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
