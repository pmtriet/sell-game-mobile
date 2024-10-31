part of '../page/rating_page.dart';

class RemarkTextfieldWidget extends StatelessWidget {
  const RemarkTextfieldWidget({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(UIConstants.itemRadius),
        border: Border.all(color: ColorName.grey353535),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextFormField(
          controller: controller,
          textInputAction: TextInputAction.done,
          maxLines: 5,
          style: context.textTheme.bodyMedium
              .copyWith(color: ColorName.whiteF1F1F1),
          decoration: InputDecoration(
              hintText: '${context.s.share_your_remark}...',
              hintStyle: context.textTheme.bodyMedium
                  .copyWith(color: ColorName.grey787878),
              border: InputBorder.none),
        ),
      ),
    );
  }
}
