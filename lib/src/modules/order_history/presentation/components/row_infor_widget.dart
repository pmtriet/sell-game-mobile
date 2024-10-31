part of '../page/order_history_page.dart';

class RowInforWidget extends StatelessWidget {
  final String title;
  final TextStyle titleTextStyle;
  final String content;
  final TextStyle contentTextStyle;
  const RowInforWidget({
    super.key,
    required this.title,
    required this.titleTextStyle,
    required this.content,
    required this.contentTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //title
          Text(
            title,
            style: titleTextStyle,
          ),
          //content
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              content,
              style: contentTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
