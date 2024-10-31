part of '../pages/post_page.dart';

class RankDropdownRowWidget extends StatefulWidget {
  const RankDropdownRowWidget(
      {super.key, required this.title, required this.ranks});
  final String title;
  final List<String> ranks;

  @override
  State<RankDropdownRowWidget> createState() => _RankDropdownRowWidgetState();
}

class _RankDropdownRowWidgetState extends State<RankDropdownRowWidget> {
  String? selectedRank;
  List<String>? previousRanks;
  bool enableRebuild = false;

  @override
  void didUpdateWidget(covariant RankDropdownRowWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    //if list ranks change -> rebuld UI
    if (widget.ranks != oldWidget.ranks) {
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
                child: DropdownButtonFormField2<String>(
                  key: enableRebuild ? UniqueKey() : null,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                    border: InputBorder.none,
                  ),
                  style: context.textTheme.bodyMedium,
                  items: widget.ranks
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.bodyMedium
                                  .copyWith(color: ColorName.whiteF1F1F1),
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select rank';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (value != null) {
                      context.read<RanksCubit>().onSelect(value);
                    }
                  },
                  onSaved: (value) {
                    selectedRank = value;
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: IconStyleData(
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: (widget.ranks.isNotEmpty)
                          ? ColorName.primary
                          : ColorName.grey353535,
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
