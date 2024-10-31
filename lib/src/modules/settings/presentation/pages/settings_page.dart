import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/extensions/build_context_x.dart';
import '../../../auth/application/cubit/auth_cubit.dart';
import '../widgets/settings_body.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(context.s.settings),
          surfaceTintColor: Colors.transparent,
          titleSpacing: 0,
        ),
        body: state.maybeWhen(
          orElse: () => const Center(child: CircularProgressIndicator()),
          authenticated: (_) => const SettingsBody(),
        ),
      ),
    );
  }
}
