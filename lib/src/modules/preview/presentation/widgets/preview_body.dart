part of '../page/preview_page.dart';

class PreviewBody extends StatelessWidget {
  const PreviewBody({
    super.key,
    required this.post,
    required this.avatar,
    required this.username,
  });
  final PostModel post;
  final String avatar;
  final String username;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PreviewCubit, PreviewState>(
      listener: (context, state) {
        if (state.error != null) {
          AppDialogs.show(type: AlertType.error, content: state.error ?? '');
        } else if (state.isSuccess == true) {
          AppToasts.show(context.s.success_post);
          context.router.popUntilRoot();
          context.router.push(ManagementPostRoute(navigatingIndex: 2));
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
                        child: Image.file(
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
                                      child: avatar.isNotEmpty
                                          ? CacheImageWidget(
                                              url: avatar,
                                              fit: BoxFit.cover,
                                            )
                                          : Assets.images.defaultUserAvatar
                                              .image(),
                                    ),
                                  ),
                                  //name
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        username,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: context.textTheme.bodyLarge,
                                      ),
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

                        Text(
                          post.category.name,
                          style: context.textTheme.contentSmall
                              .copyWith(color: ColorName.greyBBBBBB),
                        ),

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
                                title: context.s.edit_post.toUpperCase(),
                                onTap: () {
                                  context.router.maybePop();
                                },
                              ),
                              PostButtonWidget(
                                  enable: true,
                                  title: context.s.post_now.toUpperCase(),
                                  onTap: () {
                                    context.read<PreviewCubit>().post(post);
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
