import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../buy/infrastructor/models/category_product.dart';
import '../../../category/application/filter_cubit/filter_option_cubit/filter_option_cubit.dart';
import '../../../category/application/filter_cubit/filter_price_cubit/filter_price_cubit.dart';

import '../../application/search_cubit.dart';
import '../../domain/interfaces/search_repository_interface.dart';
import '../widgets/search_results_body.dart';


@RoutePage()
class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({super.key, required this.products, required this.keyword});
  final List<ProductModel> products;
  final String keyword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.background,
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => SearchCubit(getIt<ISearchRepository>())), 
            BlocProvider(create: (_) => FilterOptionCubit()),
            BlocProvider(create: (_) => FilterPriceCubit()),
          ],
          child: SearchResultsBody(
            products: products,
            keyword: keyword,
          ),
        ),
      ),
    );
  }
}
