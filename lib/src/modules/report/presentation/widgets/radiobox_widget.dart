part of '../page/report_page.dart';

class RadioboxWidget extends StatefulWidget {
  final Function(ReportReasonType reportReasonType) onSelectReasonType;
  const RadioboxWidget({super.key, required this.onSelectReasonType});

  @override
  State<RadioboxWidget> createState() => _RadioboxWidgetState();
}

class _RadioboxWidgetState extends State<RadioboxWidget> {
  ReportReasonType _selectedValue = ReportReasonType.scamUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Text(context.s.scam_user),
          titleTextStyle: context.textTheme.headlineSmall,
          leading: Radio<ReportReasonType>(
            value: ReportReasonType.scamUser,
            groupValue: _selectedValue,
            activeColor: ColorName.primary,
            onChanged: (ReportReasonType? value) {
              if (value != null) {
                setState(() {
                  _selectedValue = value;
                  widget.onSelectReasonType(_selectedValue);
                });
              }
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Text(context.s.incorrect_personal_info),
          titleTextStyle: context.textTheme.headlineSmall,
          leading: Radio<ReportReasonType>(
            value: ReportReasonType.incorrectPersonalInfor,
            groupValue: _selectedValue,
            activeColor: ColorName.primary,
            onChanged: (ReportReasonType? value) {
              if (value != null) {
                setState(() {
                  _selectedValue = value;
                  widget.onSelectReasonType(_selectedValue);
                });
              }
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Text(context.s.spam),
          titleTextStyle: context.textTheme.headlineSmall,
          leading: Radio<ReportReasonType>(
            value: ReportReasonType.spam,
            groupValue: _selectedValue,
            activeColor: ColorName.primary,
            onChanged: (ReportReasonType? value) {
              if (value != null) {
                setState(() {
                  _selectedValue = value;
                  widget.onSelectReasonType(_selectedValue);
                });
              }
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Text(context.s.other_reason),
          titleTextStyle: context.textTheme.headlineSmall,
          leading: Radio<ReportReasonType>(
            value: ReportReasonType.otherReason,
            groupValue: _selectedValue,
            activeColor: ColorName.primary,
            onChanged: (ReportReasonType? value) {
              if (value != null) {
                setState(() {
                  _selectedValue = value;
                  widget.onSelectReasonType(_selectedValue);
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
