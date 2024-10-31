part of '../pages/transaction_history_page.dart';

class TransactionHistoryBody extends StatelessWidget {
  TransactionHistoryBody({super.key});

  final ordersWidget = BlocBuilder<OrdersCubit, OrdersState>(
    builder: (context, state) {
      return state.maybeWhen(
          initial: (start, end, isLoading, orders) {
            return Column(
              children: [
                //date picker
                BlocConsumer<OrderDatePickerCubit, OrderDatePickerState>(
                  listener: (context, state) {
                    if (state.errorMessage != null) {
                      AppDialogs.show(
                          type: AlertType.error,
                          content: state.errorMessage ?? '');
                    } else if (state.isValid != null) {
                      context
                          .read<OrdersCubit>()
                          .setTimePicker(state.start, state.end);
                    }
                  },
                  builder: (context, state) {
                    return DatePickerWidget(
                      start: state.start,
                      end: state.end,
                      isInOrderTab: true,
                    );
                  },
                ),

                //list orders
                Expanded(
                  child: Stack(
                    children: [
                      ListViewOrdersWidget(
                        orders: orders ?? [],
                        refresh: context.read<OrdersCubit>().refreshOrders,
                        loadMore: context.read<OrdersCubit>().loadmoreOrders,
                        onTapToOrder: (id) {
                          context.router
                              .push(OrderHistoryRoute(transactionId: id));
                        },
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
                  ),
                ),
              ],
            );
          },
          orElse: () => const SizedBox.shrink());
    },
  );

  final transactionsWidget = BlocBuilder<PaymentCubit, PaymentState>(
    builder: (context, state) {
      return state.maybeWhen(
        initial: (start, end, isLoading, transactions) {
          return Column(
            children: [
              //date picker
              BlocConsumer<PaymentDatePickerCubit, PaymentDatePickerState>(
                listener: (context, state) {
                  if (state.errorMessage != null) {
                    AppDialogs.show(
                        type: AlertType.error,
                        content: state.errorMessage ?? '');
                  } else if (state.isValid != null) {
                    context
                        .read<PaymentCubit>()
                        .setTimePicker(state.start, state.end);
                  }
                },
                builder: (context, state) {
                  return DatePickerWidget(
                    start: state.start,
                    end: state.end,
                    isInOrderTab: false,
                  );
                },
              ),

              //list payment
              Expanded(
                  child: Stack(
                children: [
                  ListViewPaymentWidget(
                    transactions: transactions ?? [],
                    refresh: context.read<PaymentCubit>().refresh,
                    loadMore: context.read<PaymentCubit>().loadmore,
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
              )),
            ],
          );
        },
        orElse: () => const SizedBox.shrink(),
      );
    },
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: context.router.maybePop,
              icon: const Icon(
                Icons.arrow_back,
                color: ColorName.primary,
              )),
          titleSpacing: 0,
          title: Text(
            context.s.transaction_history.toUpperCase(),
            style: context.textTheme.headlineSmall,
          ),
          surfaceTintColor: Colors.transparent,
          backgroundColor: ColorName.background,
        ),
        backgroundColor: ColorName.background,
        body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: UIConstants.padding),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              BlocBuilder<TransactionHistoryTabbarCubit,
                  TransactionHistoryTabbarState>(builder: (context, state) {
                return state.when(
                  initial: (index) {
                    if (index == 1) {
                      //tabbar
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TabItemWidget(
                                label: context.s.order,
                                isSelected: true,
                                onTap: null,
                              ),
                              TabItemWidget(
                                label: context.s.payment,
                                isSelected: false,
                                onTap: () {
                                  context
                                      .read<TransactionHistoryTabbarCubit>()
                                      .onTapToPaymentTab();
                                },
                              ),
                            ],
                          ),
                          //heading text of date picker
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: UIConstants.padding),
                            child: Text(
                              context.s.filter_by_purchase_time,
                              style: context.textTheme.headlineSmall,
                            ),
                          ),
                        ],
                      );
                    } else {
                      {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //tabbar
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TabItemWidget(
                                    label: context.s.order,
                                    isSelected: false,
                                    onTap: () {
                                      context
                                          .read<TransactionHistoryTabbarCubit>()
                                          .onTapToProductTab();
                                    },
                                  ),
                                  TabItemWidget(
                                    label: context.s.payment,
                                    isSelected: true,
                                  ),
                                ],
                              ),
                              //heading text of date picker
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: UIConstants.padding),
                                child: Text(
                                  context.s.filter_by_deposit_time,
                                  style: context.textTheme.headlineSmall,
                                ),
                              ),
                            ]);
                      }
                    }
                  },
                );
              }),
              Expanded(
                child: BlocBuilder<TransactionHistoryTabbarCubit,
                    TransactionHistoryTabbarState>(
                  builder: (context, state) {
                    return Stack(
                      children: [
                        Offstage(
                          offstage: state.index == 2 ? true : false,
                          child: ordersWidget,
                        ),
                        Offstage(
                          offstage: state.index == 1 ? true : false,
                          child: transactionsWidget,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ])));
  }
}
