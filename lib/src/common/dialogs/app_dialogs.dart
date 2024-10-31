import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../generated/assets.gen.dart';
import '../../../generated/colors.gen.dart';
import '../../../generated/l10n.dart';
import '../extensions/build_context_x.dart';
import '../widgets/button_widget.dart';

enum AlertType {
  notice,
  warning,
  error,
  confirm,
}

class AppDialogs {
  static Future<void> show({
    // required String title,
    required String content,
    String? titleAction1,
    String? titleAction2,
    Function()? action1,
    Function()? action2,
    AlertType type = AlertType.notice,
  }) {
    return Asuka.showDialog(builder: (context) {
      return AlertDialog(
        backgroundColor: ColorName.black1E1E1E,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: SizedBox(
          width: context.isTablet ? 400 : 358.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: SizedBox(
                      width: 26,
                      height: 26,
                      child: Assets.icons.close.svg(),
                    ),
                  ),
                ],
              ),
              Center(
                child: _getIcon(type),
              ),
              const Gap(16),
              Center(
                  child: Text(
                _getTitleAlert(type).toUpperCase(),
                style: context.textTheme.captionLarge,
              )),
              const Gap(16),
              Center(
                  child: Text(content,
                      style: context.textTheme.contentSmall
                          .copyWith(color: ColorName.grey8E8E8E))),
              const Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (titleAction2 != null)
                    Expanded(
                      flex: 1,
                      child: ButtonWidget(
                        titleColor: ColorName.primary,
                        backgroundColor: ColorName.black1E1E1E,
                        borderSideColor: ColorName.primary,
                        title: titleAction2,
                        onTextButtonPressed: () {
                          Navigator.of(context).pop();
                          action2?.call();
                        },
                      ),
                    ),
                  const Gap(12),
                  Expanded(
                    flex: 1,
                    child: ButtonWidget(
                      title: titleAction1 ?? context.s.ok,
                      onTextButtonPressed: () {
                        Navigator.of(context).pop();
                        action1?.call();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  static SvgPicture _getIcon(AlertType type) {
    switch (type) {
      case AlertType.error:
        return Assets.icons.errorAlert.svg();
      case AlertType.warning:
        return Assets.icons.warningAlert.svg();
      case AlertType.notice:
        return Assets.icons.noticeAlert.svg();
      case AlertType.confirm:
        return Assets.icons.confirmAlert.svg();
    }
  }

  static String _getTitleAlert(AlertType type) {
    switch (type) {
      case AlertType.error:
        return S.current.error_alert;
      case AlertType.warning:
        return S.current.warning_alert;
      case AlertType.notice:
        return S.current.notice_alert;
      case AlertType.confirm:
        return S.current.confirm_alert;
    }
  }
}
