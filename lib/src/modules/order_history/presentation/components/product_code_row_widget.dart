part of '../page/order_history_page.dart';

class ProductCodeRowWidget extends StatelessWidget {
  final String code;
  const ProductCodeRowWidget({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //title & code
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //title
                Text(
                  context.s.order_id,
                  style: context.textTheme.headlineSmall,
                ),
                //code
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    '#$code',
                    style: context.textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
          ),
          //copy button
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: GestureDetector(
              onTap: () {
                final data = ClipboardData(text: code);
                Clipboard.setData(data);
                AppDialogs.show(
                      type: AlertType.notice,
                      content: context.s.copied);
              },
              child: Text(
                context.s.copy,
                style: context.textTheme.caption,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
