import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/assets.gen.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/int_x.dart';
import '../../../../common/utils/enum_product_type.dart';
import '../../../auth/application/cubit/auth_cubit.dart';
import '../../application/cubits/buy_cubit.dart';
import '../../application/cubits/buy_state.dart';
import '../widgets/balance_widget.dart';
import '../widgets/confirm_button_widget.dart';
import '../widgets/discount_code_widget.dart';
import '../widgets/product_details_widget.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../widgets/product_summary_widget.dart';
import '../widgets/summary_widget.dart';

class BuyBody extends StatefulWidget {
  const BuyBody({super.key});

  @override
  State<BuyBody> createState() => _BuyBodyState();
}

class _BuyBodyState extends State<BuyBody> {
  bool _isLoading = false;

  void _toggleLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  String? appliedVoucherCode;
  void onBackToRoot() {
    context.router.popUntilRoot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.background,
      resizeToAvoidBottomInset:
          true, // Ensures the view adjusts for the keyboard
      appBar: AppBar(
        titleSpacing: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 24.sp,
            color: ColorName.green3BD9AC,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        leadingWidth: 55.w,
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              context.s.confirm_payment,
              style: context.textTheme.displayLarge,
            ),
          ),
        ),
        titleTextStyle: const TextStyle(),
      ),
      body: BlocConsumer<BuyCubit, BuyState>(
          listener: (previous, current) => current.maybeWhen(
                error: (message, timestamp) {
                  AppDialogs.show(type: AlertType.error, content: message);
                  return null;
                },
                success: () async {
                  await AppDialogs.show(
                      type: AlertType.notice,
                      content: context.s.purchase_success);
                  onBackToRoot();
                  return null;
                },
                orElse: () {
                  return null;
                },
              ),
          buildWhen: (previous, current) {
            return !(current == const BuyState.success() ||
                current.maybeWhen(
                  error: (_, timestamp) => true,
                  orElse: () => false,
                ));
          },
          builder: (ctx, state) {
            final buyCubit = ctx.read<BuyCubit>();
            return state.when(
              success: () => const SizedBox.shrink(),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              loaded: (product, appliedVoucherCode) =>
                  LayoutBuilder(builder: (context, constraints) {
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        padding: EdgeInsets.all(16.w),
                        child: Container(
                          constraints: BoxConstraints(
                              minHeight: constraints.maxHeight - 32.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  ProductSummaryWidget(
                                    priceBeforeSale:
                                        product.price != product.currentPrice &&
                                                product.currentPrice != 0
                                            ? product.price.toInt().toVND()
                                            : null,
                                    imagePath: product.images.isNotEmpty
                                        ? product.images.first.filePath
                                        : '',
                                    title: product.title,
                                    gameName: product.category.name,
                                    code: product.code,
                                    price: product.currentPrice != 0
                                        ? product.currentPrice.toInt().toVND()
                                        : product.price.toInt().toVND(),
                                  ),
                                  SizedBox(height: 24.h),
                                  ProductDetailsWidgetInColumn(
                                    attributes: product.attributes,
                                    product: product,
                                  ),
                                  SizedBox(height: 24.h),
                                  BlocBuilder<AuthCubit, AuthState>(
                                    builder: (context, authState) {
                                      return authState.maybeWhen(
                                        authenticated: (user) => BalanceWidget(
                                          label: context.s.balance_account,
                                          balance: user.balance.toVND(),
                                          svgIconPath: Assets.icons.addBuy.path,
                                          onIconPressed: () {
                                            // TODO: Handle action
                                          },
                                        ),
                                        orElse: () => BalanceWidget(
                                          label: context.s.balance_account,
                                          balance: '0',
                                          svgIconPath: Assets.icons.addBuy.path,
                                          onIconPressed: null,
                                        ),
                                      );
                                    },
                                  ),
                                  // Discount Code Input Field with Focus and Scroll

                                  if (getProductTypeFromString(
                                          product.productType) ==
                                      ProductType.b2c)
                                    Column(
                                      children: [
                                        SizedBox(height: 24.h),
                                        DiscountCodeWidget(
                                          hintText: context.s.discount_code,
                                          buttonText: context.s.apply,
                                          svgIconPath:
                                              Assets.icons.discount.path,
                                          onApplyPressed: (code) {
                                            if (code.isEmpty) {
                                              AppDialogs.show(
                                                type: AlertType.warning,
                                                content: context
                                                    .s.empty_discount_code,
                                              );
                                              return;
                                            }
                                            _toggleLoading(true);
                                            buyCubit.setVoucherCode(code);
                                            buyCubit
                                                .applyVoucherCode(
                                                    code, product.id, context)
                                                .then((_) {
                                              _toggleLoading(
                                                  false); // Tắt lớp phủ mờ
                                            }).catchError((error) {
                                              _toggleLoading(
                                                  false); // Tắt lớp phủ mờ trong trường hợp lỗi
                                            });
                                          },
                                          onClearPressed: () {
                                            buyCubit.clearVoucherCode();
                                          },
                                        ),
                                      ],
                                    ),

                                  if (getProductTypeFromString(
                                          product.productType) ==
                                      ProductType.b2c)
                                    Column(
                                      children: [
                                        SizedBox(height: 24.h),
                                        SummaryWidget(
                                          summaryItems: [
                                            {
                                              'label': context.s.total_payment,
                                              'value': product.currentPrice
                                                  .toInt()
                                                  .toVND()
                                            },
                                            {
                                              'label': context.s.discount_code,
                                              'value': product.saleOff
                                                  .toInt()
                                                  .toVND()
                                            },
                                          ],
                                          voucherCode: appliedVoucherCode,
                                        ),
                                      ],
                                    )
                                  else
                                    SummaryWidget(
                                      summaryItems: [
                                        {
                                          'label': context.s.total_payment,
                                          'value': product.currentPrice != 0
                                              ? product.currentPrice
                                                  .toInt()
                                                  .toVND()
                                              : product.price.toInt().toVND(),
                                        },
                                      ],
                                    )
                                ],
                              ),
                              // SizedBox(height: 100.h), // Add some spacing
                              // Spacer(),
                              SafeArea(
                                child: ConfirmButtonWidget(
                                  title: context.s.confirm_buy,
                                  onPressed: () {
                                    _toggleLoading(true); // Bật lớp phủ mờ
                                    buyCubit.makePurchase(context).then((_) {
                                      _toggleLoading(
                                          false); // Tắt lớp phủ mờ khi hoàn thành
                                    }).catchError((error) {
                                      _toggleLoading(
                                          false); // Tắt lớp phủ mờ khi có lỗi
                                    });
                                  },
                                  totalLabel: context.s.final_price,
                                  totalValue: product.finalPrice == 0 &&
                                          product.currentPrice != 0
                                      ? product.currentPrice.toInt().toVND()
                                      : product.finalPrice != 0
                                          ? product.finalPrice.toInt().toVND()
                                          : product.price.toInt().toVND(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_isLoading)
                        Container(
                          color: Colors.black.withOpacity(0.5),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      // Confirm Button
                    ],
                  ),
                );
              }),
              error: (message, timestamp) => Center(
                child: Text(message),
              ),
            );
          }),
      // ),
    );
  }
}
