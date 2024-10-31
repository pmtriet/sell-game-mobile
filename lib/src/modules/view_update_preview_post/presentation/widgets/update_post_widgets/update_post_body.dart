part of '../../page/update_post_page.dart';

class UpdatePostBody extends StatelessWidget {
  final UserProductModel previousPost;
  const UpdatePostBody({super.key, required this.previousPost});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: previousPost.title);
    final descriptionController =
        TextEditingController(text: previousPost.description);
    final priceController =
        TextEditingController(text: previousPost.price.toNumberFormat());
    final accountGameController =
        TextEditingController(text: previousPost.productInfo.account);
    final pwdGameController =
        TextEditingController(text: previousPost.productInfo.password);
    return BlocConsumer<UpdatePostCubit, UpdatePostState>(
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
                    BlocBuilder<CategoryGameCubit, CategoryGameState>(
                      builder: (context, state) {
                        return CategoryDropdownWidget(
                          games: state.category,
                          selectedId: state.selected,
                          // onSelectedItemDropDown: (CategoryModel item) {
                          //   context
                          //       .read<CategoryGameCubit>()
                          //       .selectItemDropdown(item);
                          // },
                        );
                      },
                    ),
                    //add images
                    BlocBuilder<AddImageCubit, AddImageState>(
                      builder: (context, state) {
                        return AddImagesWidget(
                          newImages: state.newImages,
                          selectedRemainingImages:
                              state.selectedRemainingImages,
                          onSelectNewImage: (File image) {
                            context.read<AddImageCubit>().onSelectImage(image);
                          },
                          onDeleteSelectedRemainingImage: (fileName) {
                            context
                                .read<AddImageCubit>()
                                .onDeleteSelectedImage(fileName);
                          },
                          onDeleteNewImage: (file) {
                            context
                                .read<AddImageCubit>()
                                .onDeleteNewImage(file);
                          },
                          onLoading: () {
                            context.read<UpdatePostCubit>().onLoading();
                          },
                          unLoading: () {
                            context.read<UpdatePostCubit>().unLoading();
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
                    BlocListener<CategoryGameCubit, CategoryGameState>(
                        listenWhen: (previousState, currentState) {
                          return currentState.current != null;
                        },
                        listener: (context, state) {
                          context
                              .read<AttributeCubit>()
                              .init(state.current!.attributes);
                          context
                              .read<SignInMethodCubit>()
                              .init(state.current!.signInMethods);
                          context.read<RankCubit>().init(state.current!.ranks);
                        },
                        child: Column(
                          children: [
                            BlocBuilder<AttributeCubit, AttributeState>(
                              builder: (context, state) {
                                return state.attributes.isNotEmpty
                                    ? SelectTypeItemWidget(
                                        attributes: state.attributes,
                                        onAttributeValueChanged:
                                            (attribute, newValue) {
                                          context
                                              .read<AttributeCubit>()
                                              .addAttributeValue(
                                                  attribute, newValue);
                                        },
                                        onChange: (value) {
                                          context
                                              .read<AttributeCubit>()
                                              .onSelectAttribute(value);
                                        },
                                        onDeleteAttribute: (attribute) {
                                          context
                                              .read<AttributeCubit>()
                                              .deleteAttribute(attribute);
                                        },
                                      )
                                    : const SizedBox.shrink();
                              },
                            ),
                            //signinmethod
                            BlocBuilder<SignInMethodCubit, SignInMethodState>(
                              builder: (context, state) {
                                return state.signInMethods.isNotEmpty
                                    ? SignInMethodDropdownRowWidget(
                                        title: context.s.link_account,
                                        signInMethods: state.signInMethods,
                                        onSelectItemDropdown: (signInMethod) {
                                          context
                                              .read<SignInMethodCubit>()
                                              .onSelect(signInMethod);
                                        },
                                        selectedId: state.selectedId,
                                      )
                                    : const SizedBox.shrink();
                              },
                            ),
                            //rank
                            BlocBuilder<RankCubit, RankState>(
                              builder: (context, state) {
                                return state.ranks != null
                                    ? RankDropdownRowWidget(
                                        title: context.s.rank,
                                        ranks: state.ranks!,
                                        selected: state.selected,
                                        onSelectRank: (rank) {
                                          context
                                              .read<RankCubit>()
                                              .onSelect(rank);
                                        },
                                      )
                                    : const SizedBox.shrink();
                              },
                            ),
                          ],
                        )),

                    //description
                    DetailDescriptionTextFieldWidget(
                      controller: descriptionController,
                      maxLength: AppConstants.maxLengthDescription,
                    ),
                    //text game infor
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
                    //button
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //preview button
                          PostButtonWidget(
                            enable: false,
                            title: context.s.preview,
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
                          //update post button
                          PostButtonWidget(
                              enable: true,
                              title: context.s.update_post,
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
            if (state == const UpdatePostState.loading())
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

    CategoryModel? category =
        context.read<CategoryGameCubit>().getCurrentCategory();
    List<File>? newImages = context.read<AddImageCubit>().getNewImages();
    List<CategoryAttributeModel>? attributes =
        context.read<AttributeCubit>().getAttributes();
    CategorySigninMethodModel? signInMethod =
        context.read<SignInMethodCubit>().getSignInMethod();
    String? rank = context.read<RankCubit>().getRank();

    List<ProductImageModel>? selectedRemainingImages =
        context.read<AddImageCubit>().getSelectedRemainingImages();

    final updatePost = context.read<UpdatePostCubit>().validate(
        category,
        newImages,
        selectedRemainingImages,
        title,
        price,
        attributes,
        rank,
        signInMethod,
        description,
        account,
        password);

    if (updatePost != null) {
      List<String>? deletedImages =
          context.read<AddImageCubit>().getDeletedImages();
      //edit
      if (function == 1) {
        onPreview(context, updatePost, selectedRemainingImages, deletedImages);
      }
      //post
      else {
        onPost(context, updatePost, deletedImages);
      }
    }
  }

  void onPost(
      BuildContext context, PostModel updatePost, List<String>? deletedImages) {
    context
        .read<UpdatePostCubit>()
        .updatePost(updatePost, previousPost, deletedImages);
  }

  void onPreview(
      BuildContext context,
      PostModel post,
      List<ProductImageModel>? selectedRemainingImages,
      List<String>? deletedImages) {
    final user = Storage.user;
    if (user != null) {
      context.router.push(PreviewPostRoute(
          post: post,
          username: user.fullname,
          avatar: user.avatar.filePath,
          selectedRemainingImages: selectedRemainingImages,
          deletedImages: deletedImages,
          previousPost: previousPost));
    }
  }
}
