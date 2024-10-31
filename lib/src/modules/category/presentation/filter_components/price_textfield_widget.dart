part of '../pages/category_page.dart';

class PriceTextFieldWidget extends StatelessWidget {
  const PriceTextFieldWidget(
      {super.key, required this.hintText, required this.controller});
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130.w,
      height: 38.w,
      child: Center(
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          style: context.textTheme.titleSmall.copyWith(fontSize: 14),
          maxLength: 11,
          buildCounter: (context,
              {required int currentLength,
              required bool isFocused,
              required int? maxLength}) {
            return null;
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            OnlyDigitsFormatter(),
            MoneyFormatter(),
          ],
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: context.textTheme.bodyMedium.copyWith(fontSize: 12),
            filled: true,
            fillColor: Colors.black,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(UIConstants.itemRadius),
              borderSide: const BorderSide(
                color: ColorName.grey353535,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(UIConstants.itemRadius),
              borderSide: const BorderSide(
                color: ColorName.grey353535,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(UIConstants.itemRadius),
              borderSide: const BorderSide(
                color: ColorName.grey353535,
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
