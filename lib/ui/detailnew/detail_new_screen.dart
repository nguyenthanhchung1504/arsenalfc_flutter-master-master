
import 'package:arsenalfc_flutter/utils/messages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../extension/extension.dart';
import 'detail_new_controller.dart';

class DetailNewScreen extends GetView<DetailController>{
  const DetailNewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KeyString.KEY_DETAIL_NEW.tr,style: const TextStyle(fontFamily: "montserrat_black",fontWeight: FontWeight.w700,fontSize: 16,color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: GestureDetector(child: const Icon(Icons.arrow_back_ios_outlined,color: Colors.black),onTap: (){
          Get.back();
        },),

      ),
      body: WebViewWidget(controller: controller.webViewController),
      bottomNavigationBar: SizedBox(
        width: AdSize.banner.width.toDouble(),
        height: AdSize.banner.height.toDouble(),
        child: AdWidget(ad: BannerAd(
          adUnitId: StringUtils.getBannerAdUnitId(),
          request: const AdRequest(),
          size: AdSize.banner,
          listener: BannerAdListener(
            // Called when an ad is successfully received.
            onAdLoaded: (ad) {

            },
            // Called when an ad request failed.
            onAdFailedToLoad: (ad, err) {
              // Dispose the ad here to free resources.
              ad.dispose();
            },
            // Called when an ad opens an overlay that covers the screen.
            onAdOpened: (Ad ad) {},
            // Called when an ad removes an overlay that covers the screen.
            onAdClosed: (Ad ad) {},
            // Called when an impression occurs on the ad.
            onAdImpression: (Ad ad) {},
          ),
        )..load()),
      )
    );
  }

}