part of '../page/order_history_page.dart';

class OrderHistoryBody extends StatelessWidget {
  final int transactionId;
  const OrderHistoryBody({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    var loginAccountController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: context.router.maybePop,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: ColorName.primary,
                  )),
              titleSpacing: 0,
              title: Text(
                context.s.order_history.toUpperCase(),
                style: context.textTheme.headlineSmall,
              ),
              surfaceTintColor: Colors.transparent,
              backgroundColor: ColorName.background,
              actions: [
                state.maybeWhen(
                  loaded: (transaction) {
                    if (transaction != null) {
                      final DateTime createdAt =
                          DateTime.tryParse(transaction.createdAt)!;
                      final DateTime currentTime = DateTime.now();
                      final difference = currentTime.difference(createdAt).inDays;
          
                      if (getProductTypeFromString(
                                  transaction.product.productType) ==
                              ProductType.c2c &&
                          difference <= 1) {
                        return IconButton(
                          icon: Assets.icons.report.svg(),
                          onPressed: () {
                            context.router
                                .push(ReportRoute(transactionId: transactionId));
                          },
                        );
                      }
                    }
          
                    return const SizedBox.shrink();
                  },
                  orElse: () => const SizedBox.shrink(),
                ),
              ],
            ),
            backgroundColor: ColorName.background,
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: UIConstants.padding),
                          child: BlocListener<OrderHistoryCubit, OrderHistoryState>(
                            listener: (context, state) {
                              state.whenOrNull(
                                loaded: (transaction) {
                                  if (transaction != null) {
                                    loginAccountController.text =
                                        transaction.product.productInfo.account;
                                    passwordController.text =
                                        transaction.product.productInfo.password;
                                  }
                                },
                              );
                            },
                            child: Column(
                              children: [
                                state.maybeMap(
                                    loaded: (data) {
                                      return data.transaction != null
                                          ? Column(
                                              children: [
                                                // Order image, name, category, price
                                                ProductSummaryWidget(
                                                  imagePath: data.transaction!
                                                      .product.images[0].filePath,
                                                  title: data
                                                      .transaction!.product.title,
                                                  gameName: data.transaction!
                                                      .product.category.name,
                                                  code: data
                                                      .transaction!.product.code,
                                                  price:
                                                      '${data.transaction!.product.currentPrice.toNumberFormat()}${context.s.currency_unit}',
                                                  priceBeforeSale: data.transaction!
                                                              .product.price >
                                                          data.transaction!.value
                                                      ? '${data.transaction!.product.price.toNumberFormat()}${context.s.currency_unit}'
                                                      : null,
                                                ),
                                                // Attributes
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 8),
                                                  child:
                                                      ProductDetailsWidgetInColumn(
                                                    attributes: data.transaction!
                                                        .product.attributes,
                                                    transaction: data.transaction,
                                                  ),
                                                ),
                                                // Account game info
                                                AccountProductWidget(
                                                  loginAccountController:
                                                      loginAccountController,
                                                  passwordController:
                                                      passwordController,
                                                  isReadOnly: true,
                                                ),
                                                // Sign in method
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 8),
                                                  child: AccountLinkWidget(
                                                    title: context.s.link_account,
                                                    accountName: data.transaction!
                                                        .product.signInMethod.title,
                                                  ),
                                                ),
                                                // Total price
                                                RowInforWidget(
                                                  title: context.s.total_payment,
                                                  titleTextStyle:
                                                      context.textTheme.bodyMedium,
                                                  content:
                                                      '${data.transaction!.product.currentPrice.toNumberFormat()}${context.s.currency_unit}',
                                                  contentTextStyle:
                                                      context.textTheme.bodyMedium,
                                                ),
                                                // Sale
                                                getProductTypeFromString(data
                                                            .transaction!
                                                            .product
                                                            .productType) ==
                                                        ProductType.b2c
                                                    ? RowInforWidget(
                                                        title:
                                                            context.s.discount_code,
                                                        titleTextStyle: context
                                                            .textTheme.bodyMedium,
                                                        content:
                                                            '-${data.transaction!.voucherDiscount.toNumberFormat()}${context.s.currency_unit}',
                                                        contentTextStyle: context
                                                            .textTheme.bodyMedium,
                                                      )
                                                    : const SizedBox.shrink(),
                                                // Final price
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 8),
                                                  child: RowInforWidget(
                                                    title: context.s.final_price,
                                                    titleTextStyle: context
                                                        .textTheme.titleSmall
                                                        .copyWith(
                                                            color: ColorName
                                                                .whiteF1F1F1),
                                                    content:
                                                        '${data.transaction!.value.toNumberFormat()}${context.s.currency_unit}',
                                                    contentTextStyle: context
                                                        .textTheme.titleLarge,
                                                  ),
                                                ),
                                                // Code
                                                ProductCodeRowWidget(
                                                  code: data.transaction!.code,
                                                ),
                                                // Time
                                                RowInforWidget(
                                                  title: context.s.order_time,
                                                  titleTextStyle:
                                                      context.textTheme.bodyMedium,
                                                  content: data
                                                      .transaction!.createdAt
                                                      .toDateTimeFormat(),
                                                  contentTextStyle:
                                                      context.textTheme.bodyMedium,
                                                ),
                                              ],
                                            )
                                          : const SizedBox.shrink();
                                    },
                                    orElse: () => const SizedBox.shrink()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Button at the bottom
                    Padding(
                      padding: const EdgeInsets.all(UIConstants.padding),
                      child: ButtonWidget(
                        foregroundColor: ColorName.primary,
                        backgroundColor: ColorName.background,
                        borderSideColor: ColorName.primary,
                        title: context.s.contact.toUpperCase(),
                        titleColor: ColorName.primary,
                        onTextButtonPressed: () {
                          OpenDeeplink().openFacebook();
                        },
                      ),
                    ),
                  ],
                ),
                if (state == const OrderHistoryState.loading())
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
