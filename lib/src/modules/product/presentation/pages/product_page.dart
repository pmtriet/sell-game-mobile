import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/int_x.dart';
import '../../../../common/extensions/string_x.dart';
import '../../../../common/utils/enum_product_type.dart';
import '../../../../common/utils/favourite_products.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/widgets/button_widget.dart';
import '../../../../common/widgets/cache_image_widget.dart';
import '../../../app/app_router.dart';
import '../../../auth/application/cubit/auth_cubit.dart';
import '../../../buy/infrastructor/models/category_product.dart';
import '../../../marketplace/presentation/page/marketplace_page.dart';
import '../../../shop_profile/infrastructure/models/shop_account_model.dart';
import '../../../shop_profile/presentation/page/shop_profile_page.dart';
import '../../application/cubits/product_cubit.dart';
import '../../application/cubits/product_state.dart';
import '../../domain/interfaces/product_repository_interface.dart';
import '../../infrastructure/model/suggest_product_model.dart';

part '../widgets/shop_infor_widget.dart';
part '../widgets/account_link_widget.dart';
part '../widgets/description_container_widget.dart';
part '../widgets/product_details_widget.dart';
part '../widgets/product_price_widget.dart';
part '../widgets/product_title_widget.dart';
part 'product_body.dart';
part '../widgets/list_suggest_products_widget.dart';
part '../widgets/list_shop_products_widget.dart';

@RoutePage()
class ProductPage extends StatelessWidget {
  final int productId;
  final bool? sold;
  const ProductPage({super.key, required this.productId, this.sold});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCubit>(
          create: (_) => ProductCubit(productId, getIt<IProductRepository>()),
        ),
        BlocProvider.value(
          value: getIt<AuthCubit>(),
        ),
      ],
      child: Scaffold(
          backgroundColor: ColorName.background,
          body: ProductBody(
            productId: productId,
            sold: sold,
          )),
    );
  }
}
