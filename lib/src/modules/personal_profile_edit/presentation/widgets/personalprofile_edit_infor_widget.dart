import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../common/extensions/build_context_x.dart';
import '../../../app/app_router.dart';
import '../../../auth/domain/entities/user.dart';
import '../pages/personalprofile_edit_page.dart';

class PersonalProfileEditInforWidget extends StatelessWidget {
  const PersonalProfileEditInforWidget({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //name
        RowInforWidget(
            enable: true,
            title: context.s.username,
            content: user.fullname,
            onTap: () =>
                context.router.push(NameEditionRoute(name: user.fullname))),
        
        //phone number
        // RowInforWidget(
        //   enable: user.phone.isNotEmpty ? false : true,
        //   title: context.s.phone,
        //   content:
        //       user.phone.isNotEmpty ? user.phone.toHidePhoneFormat() : null,
        //   onTap: user.phone.isEmpty
        //       ? () {
        //           context.router.push(const PhoneEditionRoute());
        //         }
        //       : null,
        // ),

        //email
        RowInforWidget(
          enable: false,
          title: context.s.email,
          content: user.email,
        ),
      ],
    );
  }
}
