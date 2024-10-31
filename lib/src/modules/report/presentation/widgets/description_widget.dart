part of '../page/report_page.dart';

class DescriptionWidget extends StatelessWidget {
  final TextEditingController controller;
  const DescriptionWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(UIConstants.itemRadius),
        border: Border.all(color: ColorName.grey353535),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: controller,
              maxLines: 5,
              style: context.textTheme.bodyMedium
                  .copyWith(color: ColorName.whiteF1F1F1),
              decoration: InputDecoration(
                hintText: context.s.description_reason_report,
                hintStyle: context.textTheme.bodyMedium
                    .copyWith(color: ColorName.grey787878),
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
