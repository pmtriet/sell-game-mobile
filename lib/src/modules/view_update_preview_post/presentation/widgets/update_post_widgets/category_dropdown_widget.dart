part of '../../page/update_post_page.dart';

class CategoryDropdownWidget extends StatefulWidget {
  CategoryDropdownWidget({
    required this.games,
    required this.selectedId,
  }) : super(key: ValueKey(selectedId));

  final List<CategoryModel> games;
  final int? selectedId;

  @override
  State<CategoryDropdownWidget> createState() => _CategoryDropdownWidgetState();
}

class _CategoryDropdownWidgetState extends State<CategoryDropdownWidget> {
  CategoryModel? selectedGame;

  @override
  void initState() {
    super.initState();
    {
      if (widget.selectedId != null) {
        for (var game in widget.games) {
          if (game.id == widget.selectedId) {
            selectedGame = game;
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
      child: DropdownButtonFormField2<CategoryModel>(
        isExpanded: true,
        value: selectedGame,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(UIConstants.itemRadius),
            borderSide: const BorderSide(color: ColorName.grey353535),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(UIConstants.itemRadius),
            borderSide: const BorderSide(color: ColorName.grey353535),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(UIConstants.itemRadius),
            borderSide: const BorderSide(color: ColorName.grey353535),
          ),
        ),
        hint: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: context.s.select_game_name,
                style: context.textTheme.titleSmall
                    .copyWith(color: ColorName.whiteF1F1F1, fontSize: 18),
              ),
              TextSpan(
                text: ' ${context.s.necessary_symbol}',
                style: context.textTheme.titleSmall
                    .copyWith(color: ColorName.primary, fontSize: 18),
              ),
            ],
          ),
        ),
        style: context.textTheme.bodyMedium,
        items: widget.games
            .map((item) => DropdownMenuItem<CategoryModel>(
                  value: item,
                  child: Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium
                        .copyWith(color: ColorName.whiteF1F1F1),
                  ),
                ))
            .toList(),
        validator: (value) {
          if (value == null) {
            return 'Please select game';
          }
          return null;
        },
        onChanged: null,
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.only(right: 8),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: ColorName.background,
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
    );
  }
}
