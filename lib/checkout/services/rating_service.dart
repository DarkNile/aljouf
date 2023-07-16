import 'dart:io';

import 'package:in_app_review/in_app_review.dart';

class RatingService {
  final InAppReview _inAppReview = InAppReview.instance;

  String platformRecognition() {
    const String appleStoreId = 'com.aljouf.aljouf';
    const String playStoreId = 'com.DigitalPartner.aljouf';

    if (Platform.isAndroid) {
      return playStoreId;
    } else if (Platform.isIOS) {
      return appleStoreId;
    }
    return appleStoreId;
  }

  Future<bool> showRating() async {
    try {
      final isAvailable = await _inAppReview.isAvailable();
      if(isAvailable){
        _inAppReview.openStoreListing(
          appStoreId: platformRecognition(),
        );
      }
      /*(isAvailable)
          ? _inAppReview.requestReview()
          : _inAppReview.openStoreListing(
              appStoreId: platformRecognition(),
            );*/
      return true;
    } catch (e) {
      return false;
    }
  }
}
