part of '../../page/preview_post_page.dart';

class PreviewPostBody extends StatelessWidget {
  const PreviewPostBody({
    super.key,
    required this.post,
    required this.avatar,
    required this.username,
    required this.previousPost,
    required this.selectedRemainingImages,
    required this.deletedImages,
  });
  final PostModel post;
  final UserProductModel previousPost;
  final List<ProductImageModel>? selectedRemainingImages;
  final List<String>? deletedImages;
  final String avatar;
  final String username;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PreviewPostCubit, PreviewPostState>(
      listener: (context, state) {
        if (state.error != null) {
          AppDialogs.show(type: AlertType.error, content: state.error!);
        } else if (state.isSuccess == true) {
          context.router.popUntil((route) => route.isFirst);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  //images

                  Container(
                    height: 240.h,
                    color: ColorName.black1E1E1E,
                    child: Center(
                      child: SizedBox(
                        height: 200.w,
                        width: double.infinity,
                        child: selectedRemainingImages != null &&
                                (selectedRemainingImages ?? []).isNotEmpty
                            ? CacheImageWidget(
                                url: selectedRemainingImages![0].filePath,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                post.images[0],
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: UIConstants.padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //user
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Container(
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: ColorName.black1E1E1E,
                              borderRadius:
                                  BorderRadius.circular(UIConstants.itemRadius),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  //Avatar
                                  Container(
                                    width: 39.w,
                                    height: 39.w,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipOval(
                                      child: CacheImageWidget(
                                        url: avatar,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  //name
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      username,
                                      overflow: TextOverflow.ellipsis,
                                      style: context.textTheme.bodyLarge,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //title
                        ProductTitleWidget(
                            title: post.title,
                            gameName: post.category.name,
                            id: null,
                            timeAgo: null),

                        //Price
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            '${post.price.toNumberFormat()} ${context.s.currency_unit}',
                            style: context.textTheme.productTitle,
                          ),
                        ),

                        //text Detail Infor
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            context.s.detail_info,
                            style: context.textTheme.titleSmall
                                .copyWith(color: ColorName.whiteF1F1F1),
                          ),
                        ),

                        //detail infor
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: DetailInforsWidget(
                            attributes: post.attributes,
                            rank: post.rank,
                          ),
                        ),

                        //detail description
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: DescriptionContainerWidget(
                            title: context.s.detail_description,
                            description: post.description,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PostButtonWidget(
                                enable: false,
                                title: context.s.edit_post,
                                onTap: () {
                                  context.router.maybePop();
                                },
                              ),
                              PostButtonWidget(
                                  enable: true,
                                  title: context.s.update_post,
                                  onTap: () {
                                    context.read<PreviewPostCubit>().updatePost(
                                        post, previousPost, deletedImages);
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (state.isLoading == true)
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                color: Colors.black.withOpacity(0.5),
                child: const Center(child: CircularProgressIndicator()),
              )
          ],
        );
      },
    );
  }
}
