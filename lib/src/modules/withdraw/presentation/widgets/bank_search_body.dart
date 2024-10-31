part of '../pages/bank_search_page.dart';

class BankSearchBody extends StatelessWidget {
  const BankSearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.background,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            UIConstants.padding, UIConstants.padding, UIConstants.padding, 0),
        child: Column(children: [
          //back button & search
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //back button
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () {
                    context.router.maybePop();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: ColorName.primary,
                  ),
                ),
              ),

              //search bar
              const SearchbarWidget(),
            ],
          ),

          //list banks

          Expanded(
            child: BlocBuilder<BankSearchCubit, BankSearchState>(
              builder: (context, state) {
                return state.when(initial: (isLoading, banks) {
                  return Stack(
                    children: [
                      banks != null && banks.isNotEmpty
                          ? ListViewBanksWidget(
                              banks: banks,
                              refresh: context.read<BankSearchCubit>().refresh,
                              loadMore:
                                  context.read<BankSearchCubit>().loadmore,
                              selected: (BankModel bank) {
                                context
                                    .read<BankSearchCubit>()
                                    .onSearchTextChanged('');
                                getIt<BankEditionCubit>().selectBank(bank);
                                context.router.maybePop();
                              },
                            )
                          : Center(
                              child: NoPostWidget(
                                  content: context.s.no_products_found),
                            ),
                      if (isLoading)
                        Container(
                          color: ColorName.background.withOpacity(0.5),
                          child: const Center(
                              child: CircularProgressIndicator(
                            color: ColorName.primary,
                          )),
                        )
                    ],
                  );
                });
              },
            ),
          ),
        ]),
      ),
    );
  }
}
