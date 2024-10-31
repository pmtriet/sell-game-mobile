import 'package:url_launcher/url_launcher.dart';

class OpenDeeplink {
  Future<void> openFacebook() async {
    Uri facebookUrl = Uri.parse('fb://profile');
    Uri urlFallback = Uri.parse('https://www.facebook.com');

    await _launchDeeplink(facebookUrl, urlFallback);
  }

  Future<void> _launchDeeplink(Uri deeplink, Uri fallbackUrl) async {
    if (await canLaunchUrl(deeplink)) {
      await launchUrl(deeplink);
    } else if (await canLaunchUrl(fallbackUrl)) {
      await launchUrl(fallbackUrl);
    } else {
      throw 'Error ${fallbackUrl.toString()}';
    }
  }
}
