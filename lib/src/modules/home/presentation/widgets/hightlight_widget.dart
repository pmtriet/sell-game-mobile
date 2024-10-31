part of '../pages/home_page.dart';

class HighlightWidget extends StatelessWidget {
  const HighlightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.w),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HighlightCardWidget(
            gradientColor: ColorName.primary,
            label: 'TOP #10 SHOP ĐƯỢC ĐÁNH GIÁ CAO NHẤT',
          ),
          HighlightCardWidget(
            gradientColor: ColorName.pink9F2986,
            label: 'TOP XU HƯỚNG TÌM KIẾM TUẦN QUA',
          ),
        ],
      ),
    );
  }
}
