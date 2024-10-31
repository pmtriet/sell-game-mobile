import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/colors.gen.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/widgets/cache_image_widget.dart';
import '../../infrastructure/models/bank_model.dart';

class BankItemWidget extends StatelessWidget {
  const BankItemWidget(
      {super.key, required this.bank, this.onTap, this.noEndLine});
  final BankModel bank;
  final VoidCallback? onTap;
  final bool? noEndLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 74.w,
            width: double.infinity,
            color: Colors.transparent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //image
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(UIConstants.imgRadius),
                        color: ColorName.black1E1E1E),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(UIConstants.imgRadius),
                      child: CacheImageWidget(
                        url: bank.bankLogoUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                //shortname & name
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        bank.shortName,
                        style: context.textTheme.headlineSmall,
                      ),
                      Text(
                        bank.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (noEndLine == null)
          const Divider(thickness: 1, color: ColorName.grey626262),
      ],
    );
  }
}
