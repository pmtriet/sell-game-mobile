import 'package:flutter/material.dart';

import '../../../../../generated/colors.gen.dart';
import '../../infrastructure/models/bank_model.dart';
import '../components/bank_item_widget.dart';

class ListViewBanksWidget extends StatefulWidget {
  const ListViewBanksWidget(
      {super.key,
      required this.banks,
      required this.refresh,
      required this.loadMore,
      required this.selected});
  final List<BankModel> banks;
  final Future<void> Function() refresh;
  final Future<void> Function() loadMore;
  final Function(BankModel) selected;

  @override
  State<ListViewBanksWidget> createState() => _ListViewBanksWidgetState();
}

class _ListViewBanksWidgetState extends State<ListViewBanksWidget> {
  bool isLoadingMore = false;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _onScroll() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!isLoadingMore) {
        if (mounted) {
          setState(() {
            isLoadingMore = true;
          });
        }
        await widget.loadMore();
        if (mounted) {
          setState(() {
            isLoadingMore = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: ColorName.primary,
      onRefresh: () async {
        await widget.refresh();
      },
      child: Stack(
        children: [
          ListView(),
          ListView.builder(
            controller: scrollController,
            itemCount: widget.banks.length + 1,
            itemBuilder: (context, index) {
              if (index == widget.banks.length) {
                if (isLoadingMore) {
                  return const SizedBox(
                    height: 80,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ColorName.primary,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              } else {
                return BankItemWidget(
                  bank: widget.banks[index],
                  onTap: () {
                    widget.selected(widget.banks[index]);
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
