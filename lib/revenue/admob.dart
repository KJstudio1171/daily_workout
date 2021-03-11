import 'package:firebase_admob/firebase_admob.dart';

class RevenueAdMob {
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  String appID =
      'ca-app-pub-9496987862300851~7069103904'; // Android Test App ID
  String bannerID = 'ca-app-pub-9496987862300851/8282661967';

  //String bannerID = BannerAd.testAdUnitId;
  String interstitialID = 'ca-app-pub-9496987862300851/6138046050';

  //String interstitialID = InterstitialAd.testAdUnitId;

  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['workout', 'protein', 'gym', 'fitness'],
    testDevices: <String>[],
  );

  init() async {
    _bannerAd = createBannerAd();
    _interstitialAd = createInterstitialAd();
    _bannerAd
      ..load()
      ..show();
  }

  dispose() {
    _bannerAd.dispose();
  }

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: bannerID,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: interstitialID,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
  }

  showInterstitialAd() {
    _interstitialAd
      ..load()
      ..show();
  }
}
