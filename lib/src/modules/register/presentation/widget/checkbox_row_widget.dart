part of '../page/register_page.dart';

class CheckboxRowWidget extends StatefulWidget {
  const CheckboxRowWidget({super.key});

  @override
  State<CheckboxRowWidget> createState() => _CheckboxRowWidgetState();
}

class _CheckboxRowWidgetState extends State<CheckboxRowWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Checkbox
          Checkbox(
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
              context.read<CheckboxCubit>().onCheck(isChecked);
            },
            checkColor: Colors.white,
            fillColor: WidgetStateProperty.resolveWith((states) {
              if (!states.contains(WidgetState.selected)) {
                return ColorName.grey8E8E8E;
              }
              return null;
            }),
            activeColor: ColorName.primary,
            side: const BorderSide(
              color: ColorName.grey8E8E8E,
            ),
          ),

          // Text links
          Expanded(
            child: RichText(
              text: TextSpan(
                text: context.s.agree_with,
                style: context.textTheme.bodyMedium,
                children: <TextSpan>[
                  TextSpan(
                    text: context.s.terms_of_service,
                    style: context.textTheme.caption,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.router.push(WebViewRoute(
                            url: 'https://gamesmarket.vn/terms-of-service',
                            title: context.s.terms_of_service));
                      },
                  ),
                  TextSpan(
                    text: context.s.and,
                    style: context.textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: context.s.registration_privacy_policy,
                    style: context.textTheme.caption,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.router.push(WebViewRoute(
                            url: 'https://gamesmarket.vn/privacy-policy',
                            title: context.s.registration_privacy_policy));
                      },
                  ),
                  TextSpan(
                    text: context.s.our,
                    style: context.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
