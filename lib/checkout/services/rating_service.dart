import 'dart:io';

import 'package:in_app_review/in_app_review.dart';

class RatingService {
  final InAppReview _inAppReview = InAppReview.instance;

  String platformRecognition() {
    const String playStoreId = 'com.aljouf.aljouf';
    const String appleStoreId = '1661838035';

    if (Platform.isAndroid) {
      return playStoreId;
    } else if (Platform.isIOS) {
      return appleStoreId;
    }
    return playStoreId;
  }

  Future<bool> showRating() async {
    try {
      final isAvailable = await _inAppReview.isAvailable();
      if (isAvailable) {
        _inAppReview.openStoreListing(
          appStoreId: platformRecognition(),
        );
        // _inAppReview.requestReview();
      }
      /*(isAvailable)
          ? _inAppReview.requestReview()
          : _inAppReview.openStoreListing(
              appStoreId: platformRecognition(),
            );*/
      return isAvailable;
    } catch (e) {
      return false;
    }
  }
}
