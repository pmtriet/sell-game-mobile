part of '../../page/view_post_page.dart';

class ViewPostBody extends StatelessWidget {
  final bool enableToUpdatePost;
  final int? navigationToManagementPostIndex;
  const ViewPostBody(
      {super.key,
      required this.enableToUpdatePost,
      this.navigationToManagementPostIndex});

  @override
  Widget build(BuildContext context) {
    var loginAccountController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocListener<ViewPostCubit, ViewPostState>(
      listener: (context, state) {
        if (state.product != null) {
          loginAccountController.text = state.product!.productInfo.account;
          passwordController.text = state.product!.productInfo.password;
        }
        if (state.errorMessage != null) {
          AppDialogs.show(type: AlertType.error, content: state.errorMessage!);
        } else if (state.isDeletedSuccess != null) {
          AppToasts.show(context.s.delete_post_success);
          context.router.popUntilRoot();

          context.router.push(ManagementPostRoute(
              navigatingIndex: navigationToManagementPostIndex));
        }
      },
      child:
          BlocBuilder<ViewPostCubit, ViewPostState>(builder: (context, state) {
        return Stack(
          children: [
            state.product != null
                ? Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CarouselSlider(
                                items: state.product!.images
                                    .map((image) => SizedBox(
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: image.filePath.isNotEmpty
                                              ? CacheImageWidget(
                                                  url: image.filePath,
                                                  fit: BoxFit.cover,
                                                )
                                              : Assets.icons.deletedImage.svg(),
                                        ))
                                    .toList(),
                                options: CarouselOptions(
                                  viewportFraction: 1,
                                  height: 200.h,
                                  autoPlay: state.product!.images.length > 1,
                                  enableInfiniteScroll:
                                      state.product!.images.length > 1,
                                  enlargeCenterPage: true,
                                  onPageChanged: (index, reason) {
                                    context
                                        .read<ViewPostCubit>()
                                        .updateCarouselIndex(index);
                                  },
                                ),
                              ),
                              // Page Indicator
                              BlocBuilder<ViewPostCubit, ViewPostState>(
                                builder: (context, state) {
                                  final currentIndex = state.carouselIndex ?? 0;
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: state.product!.images
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      return GestureDetector(
                                        onTap: () {
                                          context
                                              .read<ViewPostCubit>()
                                              .updateCarouselIndex(entry.key);
                                        },
                                        child: Container(
                                          width: currentIndex == entry.key
                                              ? 50.w
                                              : 4.w,
                                          height: 4.h,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 8.h, horizontal: 4.w),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                            color: currentIndex == entry.key
                                                ? ColorName.primary
                                                : ColorName.grey626262,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: UIConstants.padding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //price
                                    Text(
                                      state.product!.price.toVND(),
                                      style: context.textTheme.productTitle,
                                    ),

                                    SizedBox(height: 8.h),
                                    //title
                                    ProductTitleWidget(
                                      title: state.product!.title,
                                      gameName: state.product!.category.name,
                                      id: state.product!.code,
                                      timeAgo: state.product!.updatedAt
                                          .toDurationFormat(),
                                    ),
                                    SizedBox(height: 16.h),
                                    //attribute
                                    ProductAttributeWidget(
                                      attributes: state.product!.attributes,
                                      rank: state.product!.rank,
                                    ),
                                    //account product
                                    AccountProductWidget(
                                      loginAccountController:
                                          loginAccountController,
                                      passwordController: passwordController,
                                    ),
                                    SizedBox(height: 16.h),
                                    //signinmethod
                                    AccountLinkWidget(
                                      title: context.s.link_account,
                                      accountName:
                                          state.product!.signInMethod.title,
                                    ),
                                    SizedBox(height: 16.h),
                                    //description
                                    DescriptionContainerWidget(
                                        title: context.s.detail_description,
                                        description:
                                            state.product!.description),
                                    SizedBox(height: 16.h),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //button
                      Padding(
                        padding: const EdgeInsets.all(UIConstants.padding),
                        child: enableToUpdatePost
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  PostButtonWidget(
                                    enable: false,
                                    title: context.s.delete.toUpperCase(),
                                    onTap: () {
                                      onDeletePost(context);
                                    },
                                  ),
                                  PostButtonWidget(
                                      enable: true,
                                      title: context.s.edit.toUpperCase(),
                                      icon: Assets.icons.edit.svg(),
                                      onTap: () {
                                        context.router.push(UpdatePostRoute(
                                          post: state.product!,
                                        ));
                                      }),
                                ],
                              )
                            : ButtonWidget(
                                title: context.s.sold,
                                onTextButtonPressed: () {},
                                isDisable: !enableToUpdatePost,
                              ),
                      ),
                    ],
                  )
                : state.isLoading
                    ? const SizedBox.shrink()
                    : const Center(child: NoPostWidget(content: '')),
            if (state.isLoading)
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.5),
                child: const Center(child: CircularProgressIndicator()),
              )
          ],
        );
      }),
    );
  }

  void onDeletePost(BuildContext context) {
    AppDialogs.show(
      type: AlertType.warning,
      content: context.s.comfirm_delete_post,
      action1: () {
        context.read<ViewPostCubit>().deletePost();
      },
    );
  }
}
