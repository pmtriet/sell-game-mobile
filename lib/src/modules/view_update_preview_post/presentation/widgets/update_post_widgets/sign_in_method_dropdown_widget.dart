part of '../../page/update_post_page.dart';

class SignInMethodDropdownRowWidget extends StatefulWidget {
  SignInMethodDropdownRowWidget(
      {required this.title,
      required this.signInMethods,
      required this.onSelectItemDropdown,
      required this.selectedId})
      : super(key: ValueKey(selectedId));
  final String title;
  final List<CategorySigninMethodModel> signInMethods;
  final int? selectedId;
  final Function(CategorySigninMethodModel signInMethod) onSelectItemDropdown;

  @override
  State<SignInMethodDropdownRowWidget> createState() =>
      _SignInMethodDropdownRowWidgetState();
}

class _SignInMethodDropdownRowWidgetState
    extends State<SignInMethodDropdownRowWidget> {
  CategorySigninMethodModel? selectedSignInMethod;

  @override
  void initState() {
    super.initState();
    {
      if (widget.selectedId != null) {
        for (var signInMethod in widget.signInMethods) {
          if (signInMethod.id == widget.selectedId) {
            selectedSignInMethod = signInMethod;
            break;
          }
        }
      }
    }
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
                  isExpanded: true,
                  value: selectedSignInMethod,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                    border: InputBorder.none,
                  ),
                  style: context.textTheme.bodyMedium,
                  items: widget.signInMethods
                      .map(
                          (item) => DropdownMenuItem<CategorySigninMethodModel>(
                                key: UniqueKey(),
                                value: item,
                                child: Text(
                                  item.title,
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
                      widget.onSelectItemDropdown(value);
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
