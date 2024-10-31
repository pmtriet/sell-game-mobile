part of '../pages/withdraw_money_page.dart';

class WithdrawMoneyBody extends StatelessWidget {
  const WithdrawMoneyBody({super.key});

  void resetWalletBanks(BuildContext context) {
    context.read<WithdrawMoneyCubit>().resetWalletBanks();
  }

  @override
  Widget build(BuildContext context) {
    int maxWalletBanks = 3;
    var controller = TextEditingController();
    int previousBalance = 0;

    return BlocConsumer<WithdrawMoneyCubit, WithdrawMoneyState>(
        listener: (context, state) {
      state.whenOrNull(
        initial: (balance, _, bankAccount, activeBank, deleteBank, error,
            success, isLoading) {
          if (error != null) {
            AppDialogs.show(type: AlertType.error, content: error);
          } else if (success != null) {
            context.router.maybePop();
          }
        },
      );
    }, builder: (context, state) {
      return state.when(
        initial: (balance, numberRemaining, bankAccounts, activeBank,
            deleteBank, error, success, isLoading) {
          return balance != null
              ? Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await Future.delayed(const Duration(seconds: 1));
                              getIt<AuthCubit>().getProfile();
                            },
                            color: ColorName.primary,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //available balance row
                                  BlocBuilder<AuthCubit, AuthState>(
                                    builder: (context, state) {
                                      return state.maybeWhen(
                                          authenticated: (user) {
                                            previousBalance = user.balance;
                                            return AvailableBalanceWidget(
                                                balance: user.balance);
                                          },
                                          loading: () => AvailableBalanceWidget(
                                              balance: previousBalance),
                                          orElse: () =>
                                              const AvailableBalanceWidget(
                                                  balance: 0));
                                    },
                                  ),
                                  //input money textfield
                                  WithdrawTextFieldWidget(
                                    controller: controller,
                                    textInputAction: TextInputAction.done,
                                    maxLength: 11,
                                    isNumberEditting: true,
                                    hintText: context.s.enter_amount,
                                    isMonneyFormatted: true,
                                    suffixWidget: TextButton(
                                      onPressed: null,
                                      child: Text(
                                        context.s.currency_unit,
                                        style: context.textTheme.displaySmall,
                                      ),
                                    ),
                                  ),

                                  //banks container: wallet banks, add new bank account
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: ColorName.black1E1E1E,
                                        borderRadius: BorderRadius.circular(
                                            UIConstants.itemRadius),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 16),
                                                child: Text(
                                                  context.s.receive_bank,
                                                  style: context
                                                      .textTheme.headlineSmall,
                                                )),

                                            //listview wallet banks
                                            bankAccounts != null
                                                ? _walletBankWidget(
                                                    bankAccounts,
                                                    activeBank,
                                                    deleteBank)
                                                : const SizedBox.shrink(),

                                            //add bank account row
                                            bankAccounts != null &&
                                                    bankAccounts.length <
                                                        maxWalletBanks
                                                ? AddingBankAccountWidget(
                                                    onPressed: () async {
                                                      //push to bank edition page
                                                      //edition page return new bank account
                                                      final bankAccount =
                                                          await context.router.push(
                                                              const BankEditionRoute());

                                                      if (context.mounted) {
                                                        //if return from page2 != null
                                                        if (bankAccount !=
                                                            null) {
                                                          resetWalletBanks(
                                                              context);
                                                        }
                                                      }
                                                    },
                                                  )
                                                : const SizedBox.shrink()
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        //button continue
                        BlocBuilder<WithdrawMoneyCubit, WithdrawMoneyState>(
                            builder: (context, state) {
                          return state.when(initial: (_,
                              numberRemaining,
                              bankAccounts,
                              activeBank,
                              deleteBank,
                              error,
                              success,
                              isLoading) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //number of withdrawals remaining
                                // numberRemaining != null
                                //     ? WithdrawRemainingNumberWidget(
                                //         numberRemaining: numberRemaining)
                                //     : const SizedBox.shrink(),
                                //button
                                ButtonWidget(
                                  title: context.s.withdraw.toUpperCase(),
                                  onTextButtonPressed: () {
                                    context
                                        .read<WithdrawMoneyCubit>()
                                        .withdraw(controller.text);
                                  },
                                ),
                              ],
                            );
                          });
                        }),
                      ],
                    ),
                    if (state.isLoading != null && state.isLoading == true)
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black.withOpacity(0.5),
                        child: const Center(child: CircularProgressIndicator()),
                      )
                  ],
                )
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: ColorName.background,
                  child: const Center(child: CircularProgressIndicator()),
                );
        },
      );
    });
  }

  Widget _walletBankWidget(List<BankAccountModel> bankAccount,
      BankAccountModel? activeBank, BankAccountModel? deleteBank) {
    return Column(
      children: bankAccount.map((account) {
        //active bank
        if (account == activeBank) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: BankAccountItemWidget(
              bankAccount: account,
              isActive: true,
              isDeleted: false,
            ),
          );
        }
        //delete bank
        else if (deleteBank != null && account == deleteBank) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: BankAccountItemWidget(
              bankAccount: account,
              isActive: false,
              isDeleted: true,
            ),
          );
        }
        //remaining
        else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: BankAccountItemWidget(
              bankAccount: account,
              isActive: false,
              isDeleted: false,
            ),
          );
        }
      }).toList(),
    );
  }
}
