part of '../pages/post_page.dart';

class PostBody extends StatelessWidget {
  const PostBody({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();
    final accountGameController = TextEditingController();
    final pwdGameController = TextEditingController();
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
        state.whenOrNull(
            error: (error) =>
                AppDialogs.show(type: AlertType.error, content: error),
            success: () {
              AppToasts.show(context.s.success_post);
              context.router.popUntilRoot(); 
              context.router.push(ManagementPostRoute(navigatingIndex: 2));
            });
      },
      builder: (context, state) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: UIConstants.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //dropdown category
                    BlocBuilder<GameCubit, GameState>(
                      builder: (context, state) {
                        return state.category != null
                            ? CategoryDropdownWidget(
                                games: state.category!,
                              )
                            : const CategoryDropdownWidget(
                                games: [],
                              );
                      },
                    ),
                    //add images
                    BlocBuilder<AddImageCubit, AddImageState>(
                      builder: (context, state) {
                        return AddImagesWidget(
                          images: state.images,
                          onLoading: () {
                            context.read<PostCubit>().setStateLoading();
                          },
                          unLoading: () {
                            context.read<PostCubit>().setStateInitial();
                          },
                        );
                      },
                    ),
                    //title
                    TitleTextfieldWidget(
                      title: context.s.title,
                      controller: titleController,
                    ),
                    //selling price
                    PriceTextfieldWidget(
                      title: context.s.selling_price,
                      suffixText: context.s.currency_unit,
                      controller: priceController,
                      maxLength: 11,
                    ),
                    //text Detail Infor
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        context.s.detail_info,
                        style: context.textTheme.titleSmall
                            .copyWith(color: ColorName.whiteF1F1F1),
                      ),
                    ),
                    //select type's item
                    BlocListener<GameCubit, GameState>(
                        listener: (context, state) {
                          if (state.selectedGame != null) {
                            context
                                .read<AttributesCubit>()
                                .init(state.selectedGame!.attributes);
                            context
                                .read<SignInMethodsCubit>()
                                .init(state.selectedGame!.signInMethods);
                            context
                                .read<RanksCubit>()
                                .init(state.selectedGame!.ranks);
                          }
                        },
                        child: Column(
                          children: [
                            BlocBuilder<AttributesCubit, AttributesState>(
                              builder: (context, state) {
                                return state.attributes != null
                                    ? SelectTypeItemWidget(
                                        attributes: state.attributes!,
                                        onAttributeValueChanged:
                                            (attribute, newValue) {
                                          context
                                              .read<AttributesCubit>()
                                              .addAttributeValue(
                                                  attribute, newValue);
                                        },
                                        onChange: (value) {
                                          context
                                              .read<AttributesCubit>()
                                              .onSelectAttribute(value);
                                        },
                                        onDeleteAttribute: (attribute) {
                                          context
                                              .read<AttributesCubit>()
                                              .deleteAttribute(attribute);
                                        },
                                      )
                                    : const SizedBox.shrink();
                              },
                            ),
                            BlocBuilder<SignInMethodsCubit, SignInMethodsState>(
                              builder: (context, state) {
                                return state.signInMethods != null
                                    ? SignInMethodDropdownRowWidget(
                                        title: context.s.link_account,
                                        signInMethods: state.signInMethods!,
                                      )
                                    : const SizedBox.shrink();
                              },
                            ),
                            BlocBuilder<RanksCubit, RanksState>(
                              builder: (context, state) {
                                return state.ranks != null
                                    ? RankDropdownRowWidget(
                                        title: context.s.rank,
                                        ranks: state.ranks!,
                                      )
                                    : const SizedBox.shrink();
                              },
                            ),
                          ],
                        )),
                    DetailDescriptionTextFieldWidget(
                      controller: descriptionController,
                      maxLength: AppConstants.maxLengthDescription,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        context.s.account_game_information,
                        style: context.textTheme.titleSmall
                            .copyWith(color: ColorName.whiteF1F1F1),
                      ),
                    ),
                    //account game
                    AccountGameTextFieldWidget(
                      title: context.s.account_game,
                      controller: accountGameController,
                    ),
                    //password game
                    AccountGameTextFieldWidget(
                      title: context.s.password,
                      controller: pwdGameController,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PostButtonWidget(
                            enable: false,
                            title: context.s.preview.toUpperCase(),
                            onTap: () {
                              onClickButton(
                                  context,
                                  1,
                                  titleController.text,
                                  descriptionController.text,
                                  priceController.text,
                                  accountGameController.text,
                                  pwdGameController.text);
                            },
                          ),
                          PostButtonWidget(
                              enable: true,
                              title: context.s.post.toUpperCase(),
                              onTap: () {
                                onClickButton(
                                    context,
                                    2,
                                    titleController.text,
                                    descriptionController.text,
                                    priceController.text,
                                    accountGameController.text,
                                    pwdGameController.text);
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (state == const PostState.loading())
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

  Future<void> onClickButton(BuildContext context, int function, String title,
      String description, String price, String account, String password) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Category? category = context.read<GameCubit>().getSelectedCategory();
    List<File>? images = context.read<AddImageCubit>().getImages();
    List<CategoryAttributeModel>? attributes =
        context.read<AttributesCubit>().getAttributes();
    CategorySigninMethodModel? signInMethod =
        context.read<SignInMethodsCubit>().getSignInMethod();
    String? rank = context.read<RanksCubit>().getRank();

    final post = context.read<PostCubit>().validate(category, images, title,
        price, attributes, rank, signInMethod, description, account, password);

    if (post != null) {
      //edit
      if (function == 1) {
        onPreview(context, post);
      }
      //post
      else {
        onPost(context, post);
      }
    }
  }

  void onPost(BuildContext context, PostModel post) {
    context.read<PostCubit>().post(post);
  }

  void onPreview(BuildContext context, PostModel post) {
    final user = Storage.user;
    if (user != null) {
      context.router.push(PreviewRoute(
          post: post, username: user.fullname, avatar: user.avatar.filePath));
    }
  }
}
