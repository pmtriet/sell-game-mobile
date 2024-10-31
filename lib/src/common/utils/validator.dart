import '../constants/app_constants.dart';

class Validator {
  Validator._();

  static const _emailRegExpString =
      r'^(?!.*\.\.)(?!^\.)([a-zA-Z0-9\+\.\_\%\-\+]{1,256}[a-zA-Z0-9])\@[a-zA-Z0-9]'
      r'[a-zA-Z0-9\-]{0,64}(\.[a-zA-Z0-9][a-zA-Z0-9\-]{0,25})+$';
  static final _emailRegex = RegExp(_emailRegExpString, caseSensitive: false);

  static bool isValidEmail(String email) => _emailRegex.hasMatch(email);

  static bool isEmptyEmail(String email) => email.isEmpty;

  static const _passwordRegExpString = r'^[\x21-\x7E]{8,}$';
  static final _passwordRegex =
      RegExp(_passwordRegExpString, caseSensitive: false);
  static bool isValidPassword(String password) =>
      _passwordRegex.hasMatch(password);

  static bool isEmptyPassword(String password) => password.isEmpty;

  static bool isValidPasswordLength(String password) => password.length >= 8;

  static const _usernameRegExpString = r'^(?=.*\S)[a-zA-Z\s]+$';
  static final _usernameRegex =
      RegExp(_usernameRegExpString, caseSensitive: false);
  static bool isValidUserName(String userName) =>
      _usernameRegex.hasMatch(userName);

  static const _fullnameRegExpString = r'^\s*\S.*$';
  static final _fullnameRegex =
      RegExp(_fullnameRegExpString, caseSensitive: false);
  static bool isValidFullName(String fullName) =>
      _fullnameRegex.hasMatch(fullName);

  static bool isEmptyUserName(String userName) => userName.isEmpty;

  static bool isEmptyPhone(String phone) => phone.isEmpty;

  static const _phoneRegExpString = r'^0\d{9}$';
  static final _phoneRegex = RegExp(_phoneRegExpString, caseSensitive: false);
  static bool isValidPhone(String phone) => _phoneRegex.hasMatch(phone);

  static bool isEmptyOtp(String otp) => otp.isEmpty;

  static const _otpRegExpString = r'^.{6}$';
  static final _otpRegex = RegExp(_otpRegExpString, caseSensitive: false);
  static bool isValidOtp(String otp) => _otpRegex.hasMatch(otp);

  static bool isEmptyCardHolderName(String name) => name.isEmpty;

  static bool isEmptyCardNumber(String cardNumber) => cardNumber.isEmpty;

  static const _cardNumberRegExpString = r'^\d{12}$';
  static final _cardNumberRegex =
      RegExp(_cardNumberRegExpString, caseSensitive: false);
  static bool isValidCardNumber(String cardNumber) =>
      _cardNumberRegex.hasMatch(cardNumber);

  static bool isEmptyAmount(String amount) => amount.isEmpty;

  static bool isValidSellingPrice(int price) {
    if (price > 0 && price <= AppConstants.maxSellingPrice) {
      return true;
    }
    return false;
  }

  // static const _postTitleRegExpString = r'^(?=.*[a-zA-Z0-9]).+$';
  // static final _postTitleRegex =
  //     RegExp(_postTitleRegExpString, caseSensitive: false);
  static bool isValidPostTitle(String title) =>
      title.length <= AppConstants.maxLengthPostTitle;

  static bool isEmptyContent(String content) => content.isEmpty;
}
