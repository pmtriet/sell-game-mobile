part of '../pages/bank_edition_page.dart';

class BankEditionBody extends StatelessWidget {
  const BankEditionBody({super.key});

  @override
  Widget build(BuildContext context) {
    var accountNumberBankController = TextEditingController();
    var cardHolderNameController = TextEditingController();

    void createWalletBankSuccess(BankAccountModel bankAccount) {
      context.read<BankEditionCubit>().clear();
      context.router.maybePop(bankAccount);
    }

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                context.read<BankEditionCubit>().clear();
                context.router.maybePop();
              },
              child: const Icon(
                Icons.arrow_back,
                color: ColorName.primary,
              ),
            ),
            titleSpacing: 0,
            title: Text(
              context.s.enter_bank_infor,
              style: context.textTheme.headlineSmall,
            ),
            surfaceTintColor: Colors.transparent,
            backgroundColor: ColorName.background,
          ),
          backgroundColor: ColorName.background,
          resizeToAvoidBottomInset: false,
          body: BlocConsumer<BankEditionCubit, BankEditionState>(
              listener: (context, state) {
            state.whenOrNull(
              initial: (selectedBank, error, bankAccount, isLoading) async {
                if (error != null) {
                  AppDialogs.show(type: AlertType.error, content: error);
                } else if (bankAccount != null) {
                  await AppDialogs.show(
                      type: AlertType.notice,
                      content: context.s.success_create_bank_account);
                  createWalletBankSuccess(bankAccount);
                }
              },
            );
          }, builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: UIConstants.padding),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //select bank
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const SafeArea(
                                            child: BankSearchPage());
                                      },
                                      isDismissible: true,
                                      elevation: 10,
                                      isScrollControlled: true,
                                      useSafeArea: true);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: ColorName.black1E1E1E,
                                      borderRadius: BorderRadius.circular(
                                          UIConstants.itemRadius),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        children: [
                                          Text(
                                            context.s.select_bank,
                                            style: context.textTheme.titleLarge,
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            BlocBuilder<BankEditionCubit, BankEditionState>(
                                builder: (context, state) {
                              return state.when(initial:
                                  (selectedBank, error, success, isLoading) {
                                return selectedBank != null
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: ColorName.black1E1E1E,
                                          borderRadius: BorderRadius.circular(
                                              UIConstants.itemRadius),
                                        ),
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: UIConstants.padding),
                                          child: BankItemWidget(
                                              bank: selectedBank,
                                              noEndLine: true),
                                        )),
                                      )
                                    : const SizedBox.shrink();
                              });
                            }),
                            //bank account number
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.s.bank_account_number,
                                    style: context.textTheme.headlineSmall,
                                  ),

                                  //textfield of bank account number
                                  WithdrawTextFieldWidget(
                                    controller: accountNumberBankController,
                                    isNumberEditting: true,
                                    hintText:
                                        context.s.enter_bank_account_number,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ],
                              ),
                            ),

                            //cardholder's name
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.s.card_holder_name,
                                    style: context.textTheme.headlineSmall,
                                  ),

                                  //textfield of bank account number
                                  WithdrawTextFieldWidget(
                                      controller: cardHolderNameController,
                                      hintText: context.s.enter_name,
                                      textInputAction: TextInputAction.done,
                                      enableUpperCase: true),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //button continue
                      BlocBuilder<BankEditionCubit, BankEditionState>(
                          builder: (context, state) {
                        return state.when(
                            initial: (selectedBank, error, success, isLoading) {
                          return ButtonWidget(
                            title: context.s.next,
                            onTextButtonPressed: selectedBank == null
                                ? () {
                                    AppDialogs.show(
                                        type: AlertType.error,
                                        content: context.s.select_bank);
                                  }
                                : () {
                                    context
                                        .read<BankEditionCubit>()
                                        .clickButton(
                                            accountNumberBankController.text,
                                            cardHolderNameController.text,
                                            selectedBank);
                                  },
                          );
                        });
                      }),
                    ],
                  ),
                ),
                if (state.isLoading != null && state.isLoading == true)
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(child: CircularProgressIndicator()),
                  )
              ],
            );
          }),
        ),
      ),
    );
  }
}
