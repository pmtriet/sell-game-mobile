// import 'package:flutter/material.dart';

// import '../../../generated/colors.gen.dart';
// import '../widgets/adaptive_dialog_action.dart';
// import 'build_context_x.dart';

// class DialogAction {
//   final String text;
//   final void Function()? onPressed;

//   DialogAction({required this.text, this.onPressed});
// }

// extension BuildContextDialog on BuildContext {
//   bool get isShowingDialog => ModalRoute.of(this)?.isCurrent != true;

//   void showError(String message) => showAlert(title: s.error, content: message);

//   Future<void> showAlert({
//     String? title,
//     String? content,
//     List<DialogAction> actions = const [],
//   }) async {
//     if (actions.isEmpty) {
//       actions = [DialogAction(text: s.ok)];
//     }
//     return showAdaptiveDialog(
//         context: this,
//         builder: (BuildContext context) => Theme(
//               data: Theme.of(context).copyWith(
//                 dialogBackgroundColor: ColorName.primary.withOpacity(0.8),
//                 textTheme: TextTheme(
//                   titleLarge: context.textTheme.headlineSmall,
//                   bodyMedium: context.textTheme.headlineSmall,
//                 ),
//               ),
//               child: AlertDialog.adaptive(
//                 title: title == null ? null : Text(title),
//                 content: content == null ? null : Text(content),
//                 actions: actions
//                     .map((action) => AdaptiveDialogAction(
//                           onPressed:
//                               action.onPressed ?? () => Navigator.pop(context),
//                           child: Text(
//                             action.text,
//                             style: context.textTheme.headlineSmall,
//                           ),
//                         ))
//                     .toList(),
//               ),
//             ));
//   }
// }
