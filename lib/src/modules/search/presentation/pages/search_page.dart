import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../application/search_cubit.dart';
import '../../domain/interfaces/search_repository_interface.dart';
import '../widgets/search_body.dart';

@RoutePage()
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.background,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SearchCubit(getIt<ISearchRepository>()),
          child: const SearchBody(),
        ),
      ),
    );
  }
}
