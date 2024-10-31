part of '../pages/category_page.dart';

class FilterModule extends StatelessWidget {
  const FilterModule({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.w,
        decoration: BoxDecoration(
          color: ColorName.primary,
          borderRadius: BorderRadius.circular(UIConstants.itemRadius),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //label
                Text(
                  context.s.filter,
                  style: context.textTheme
                      .titleMedium
                      .copyWith(fontSize: 12),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Assets.icons.filter.svg()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
