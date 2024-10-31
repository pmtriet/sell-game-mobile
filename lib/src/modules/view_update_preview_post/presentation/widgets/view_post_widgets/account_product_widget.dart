part of '../../page/view_post_page.dart';

class AccountProductWidget extends StatefulWidget {
  const AccountProductWidget(
      {super.key,
      required this.loginAccountController,
      required this.passwordController,
      this.isReadOnly});
  final TextEditingController loginAccountController;
  final TextEditingController passwordController;
  final bool? isReadOnly;

  @override
  State<AccountProductWidget> createState() => _AccountProductWidgetState();
}

class _AccountProductWidgetState extends State<AccountProductWidget> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //name account
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${context.s.account_game_information}:',
              style: context.textTheme.headlineSmall,
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                icon: Icon(
                  _passwordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                )),
          ],
        ),

        //account product
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorName.black1E1E1E,
              borderRadius: BorderRadius.circular(UIConstants.itemRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: UIConstants.padding, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // field
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.s.login_name,
                        style: context.textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        context.s.password,
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  //line
                  Container(
                    color: ColorName.grey353535,
                    height: 50.h,
                    width: 2,
                  ),
                  // textfield
                  SizedBox(
                    width: 160.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 34.h,
                          child: TextField(
                            maxLines: 1,
                            textAlign: TextAlign.right,
                            controller: widget.loginAccountController,
                            obscureText: !_passwordVisible,
                            style: context.textTheme.bodyMedium,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            readOnly: widget.isReadOnly != null,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 34.h,
                          child: TextField(
                            textAlign: TextAlign.right,
                            controller: widget.passwordController,
                            obscureText: !_passwordVisible,
                            style: context.textTheme.bodyMedium,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            readOnly: widget.isReadOnly != null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
