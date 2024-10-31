import '../../../generated/l10n.dart';

enum ReportReasonType{
  scamUser,
  incorrectPersonalInfor,
  spam,
  otherReason
}

String getReportReason(ReportReasonType type) {
  switch (type) {
    case ReportReasonType.scamUser:
      return S.current.scam_user;
    case ReportReasonType.incorrectPersonalInfor:
      return S.current.incorrect_personal_info;
    case ReportReasonType.spam:
      return S.current.spam;
    case ReportReasonType.otherReason:
      return S.current.other_reason;
    default:
      return '';
  }
}