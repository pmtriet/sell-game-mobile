import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/utils/getit_utils.dart';
import '../../../auth/application/cubit/auth_cubit.dart';
import '../../application/cubits/buy_cubit.dart';
import '../../infrastructor/models/category_product.dart';
import '../../infrastructor/repositories/buy_repository_interface.dart';
import 'buy_body.dart';

@RoutePage()
class BuyPage extends StatefulWidget {
  final ProductModel product;
  
  const BuyPage({super.key, required this.product});

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BuyCubit>(
          create: (_) => BuyCubit(widget.product, getIt<IBuyRepository>())..init(),
        ),
        BlocProvider.value(
          value: getIt<AuthCubit>(),
        ),

      ],
      child: const BuyBody(),
    );
  }
}
