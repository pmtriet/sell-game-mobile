part of '../pages/post_page.dart';

class SignInMethodDropdownRowWidget extends StatefulWidget {
  const SignInMethodDropdownRowWidget(
      {super.key, required this.title, required this.signInMethods});
  final String title;
  final List<CategorySigninMethodModel> signInMethods;

  @override
  State<SignInMethodDropdownRowWidget> createState() =>
      _SignInMethodDropdownRowWidgetState();
}

class _SignInMethodDropdownRowWidgetState
    extends State<SignInMethodDropdownRowWidget> {
  bool enableRebuild = false;

  @override
  void didUpdateWidget(covariant SignInMethodDropdownRowWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    //if list signInMethods change -> rebuld UI
    if (widget.signInMethods != oldWidget.signInMethods) {
      setState(() {
        enableRebuild = true;
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        enableRebuild = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(UIConstants.itemRadius),
          border: Border.all(color: ColorName.grey353535),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 160.w,
                child: Text(
                  widget.title,
                  style: context.textTheme.bodyMedium,
                ),
              ),
              Container(
                height: 30,
                width: 1,
                color: ColorName.grey8E8E8E,
              ),
              Expanded(
                child: DropdownButtonFormField2<CategorySigninMethodModel>(
                  key: enableRebuild ? UniqueKey() : null,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                    border: InputBorder.none,
                  ),
                  style: context.textTheme.bodyMedium,
                  items: widget.signInMethods
                      .map(
                          (item) => DropdownMenuItem<CategorySigninMethodModel>(
                                value: item,
                                child: Text(
                                  item.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.bodyMedium
                                      .copyWith(color: ColorName.whiteF1F1F1),
                                ),
                              ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select sign in method';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (value != null) {
                      context.read<SignInMethodsCubit>().onSelect(value);
                    }
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: ColorName.primary,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorName.grey353535,
                    ),
                    maxHeight: 200,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
