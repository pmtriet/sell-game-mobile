part of '../page/rating_page.dart';

class RatingBody extends StatelessWidget {
  const RatingBody({
    super.key,
    required this.value,
    required this.code,
    required this.images,
    required this.title,
    this.popRoute,
  });
  final int value;
  final String code;
  final List<ProductImageModel> images;
  final String title;
  final PageRouteInfo<dynamic>? popRoute;

  @override
  Widget build(BuildContext context) {
    var remarkController = TextEditingController();

    return BlocListener<RatingCubit, RatingState>(
      listener: (context, state) {
        if (state.error != null) {
          AppDialogs.show(
            type: AlertType.error,
            content: state.error!,
          );
        } else if (state.isSuccess != null) {
          AppDialogs.show(
            type: AlertType.notice,
            content: context.s.rating_success,
          );
          context.router.popUntilRoot();
          popRoute != null
              ? context.router.push(popRoute!)
              : context.router.push(const TransactionHistoryRoute());
        }
      },
      child: BlocBuilder<RatingCubit, RatingState>(
        builder: (context, state) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: UIConstants.padding),
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            OrderWidget(
                              value: value,
                              code: code,
                              images: images,
                              title: title,
                            ),
                            RatingStarWidget(
                              onRatingStart: (numberStar) {
                                context
                                    .read<RatingCubit>()
                                    .onTapOnStarRating(numberStar);
                              },
                            ),
                            RemarkTextfieldWidget(
                              controller: remarkController,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: ButtonWidget(
                                title: context.s.review,
                                onTextButtonPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  context
                                      .read<RatingCubit>()
                                      .onRate(remarkController.text);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      if (state.isLoading == true)
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.5),
                          child:
                              const Center(child: CircularProgressIndicator()),
                        )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
