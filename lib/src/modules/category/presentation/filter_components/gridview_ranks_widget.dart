part of '../pages/category_page.dart';

class GridviewRanksWidget extends StatelessWidget {
  const GridviewRanksWidget(
      {super.key,
      required this.ranks,
      required this.viewMore,
      this.selectedranks, required this.onTap});
  final List<String> ranks;
  final List<String>? selectedranks;
  final bool? viewMore;
  final Function(String selectedRank) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 90 / 50,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.w,
          ),
          itemCount: ranks.length,
          itemBuilder: (context, index) {
            return RankWidget(
              rankName: ranks[index],
              onTap: () => onTap(ranks[index]),
              isSelected: selectedranks?.any((rank) => rank == ranks[index]) ?? false,
            );
          },
        ),
        viewMore == true
            ? GestureDetector(
                onTap: () {
                  context.read<RanksFilterCubit>().viewmore();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.s.view_more,
                        style:
                            context.textTheme.bodyMedium.copyWith(fontSize: 12),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 20.0,
                        color: ColorName.grey8E8E8E,
                      )
                    ],
                  ),
                ),
              )
            : viewMore == false
                ? GestureDetector(
                    onTap: () {
                      context.read<RanksFilterCubit>().shortcut();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context.s.shortcut,
                            style: context.textTheme.bodyMedium
                                .copyWith(fontSize: 12),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_up,
                            size: 20.0,
                            color: ColorName.grey8E8E8E,
                          )
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink()
      ],
    );
  }
}
