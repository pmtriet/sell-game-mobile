import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/double_x.dart';
import '../../../../common/extensions/string_x.dart';
import '../../../../common/utils/favourite_products.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../common/widgets/cache_image_widget.dart';
import '../../../../core/infrastructure/datasources/local/storage.dart';
import '../../../app/app_router.dart';
import '../../../auth/application/cubit/auth_cubit.dart';
import '../../application/cubit/marketplace_cubit.dart';
import '../../infrastructure/models/marketplace_product_follow_shop_model.dart';
import '../../infrastructure/models/marketplace_product_model.dart';

part '../widgets/marketplace_body.dart';
part '../widgets/shop_widget.dart';
part '../component/product_card_widget.dart';

class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<MarketplaceCubit>(),
          ),
          BlocProvider.value(
            value: getIt<AuthCubit>(),
          ),
        ],
        child: const Scaffold(
            backgroundColor: ColorName.background, body: MarketplaceBody()),
      ),
    );
  }
}
