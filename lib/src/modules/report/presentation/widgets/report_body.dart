part of '../page/report_page.dart';

class ReportBody extends StatelessWidget {
  final int transactionId;
  const ReportBody({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    var controler = TextEditingController();
    return BlocListener<ReportCubit, ReportState>(
      listener: (context, state) {
        if (state.error != null) {
          state.error!.when(
              apiResponse: (message) {
                AppDialogs.show(type: AlertType.error, content: message);
                context.router.popUntilRoot();
                context.router.push(const TransactionHistoryRoute());
              },
              other: (message) =>
                  AppDialogs.show(type: AlertType.error, content: message));
        } else if (state.isSuccess != null) {
          AppDialogs.show(
              type: AlertType.notice,
              content: context.s.report_success,
              action1: () {
                context.router.popUntilRoot();
                context.router.push(const TransactionHistoryRoute());
              });
        }
      },
      child: BlocBuilder<ReportCubit, ReportState>(
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: UIConstants.padding),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.s.report_reason,
                              style: context.textTheme.headlineSmall,
                            ),

                            //radio box
                            RadioboxWidget(
                              onSelectReasonType: (reportReasonType) {
                                context
                                    .read<ReportCubit>()
                                    .onSelectReportReasonType(reportReasonType);
                              },
                            ),

                            //description textfield
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: DescriptionWidget(
                                controller: controler,
                              ),
                            ),
                            //text: Image proof
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                context.s.image_proof,
                                style: context.textTheme.headlineSmall,
                              ),
                            ),

                            //image
                            AddImagesWidget(
                              images: state.images,
                              onSelectImage: (file) {
                                context.read<ReportCubit>().onSelectImage(file);
                              },
                              onDeleteImage: (File file) {
                                context.read<ReportCubit>().onDeleteImage(file);
                              },
                              setStateLoading: (bool isLoading) {
                                context
                                    .read<ReportCubit>()
                                    .setStateLoading(isLoading);
                              },
                            )
                          ],
                        ),
                      ),
                    ),

                    //report button
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ButtonWidget(
                        title: context.s.send_report,
                        onTextButtonPressed: () {
                          context.read<ReportCubit>().validate(controler.text);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (state.isLoading)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(child: CircularProgressIndicator()),
                )
            ],
          );
        },
      ),
    );
  }
}
