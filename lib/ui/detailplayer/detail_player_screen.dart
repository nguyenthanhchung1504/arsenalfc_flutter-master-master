
import 'package:arsenalfc_flutter/ui/detailplayer/detail_player_controller.dart';
import 'package:arsenalfc_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../extension/extension.dart';

class DetailPlayerScreen extends GetView<DetailPlayerController>{
  const DetailPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: (){Get.back();},
              icon: const Icon(Icons.arrow_back,color: Colors.black,)
          ),
          title: Text(controller.playerModel.name??"",
              style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontFamily: "montserrat_black",
                  fontWeight: FontWeight.w700)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/ic_bg.png"),fit: BoxFit.cover)
                ),
                height: MediaQuery.of(context).size.height / 2 + 50,
                child: Stack(
                  children: [
                    Positioned(
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset("assets/images/logo_afcvn.png",color: Colors.redAccent,width: MediaQuery.of(context).size.width - 60,),
                        )
                    ),

                    Positioned(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset("assets/images/${controller.playerModel.imageContactNew}"),
                        )
                    ),

                    buildInfoPlayer()

                  ],
                )
              ),



              buildStory(),
            ],
          ),
        ),
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
      ),
    );
  }

  Positioned buildInfoPlayer() {
    return Positioned(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 12),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    gradient: const LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Color(AppColors.GRAY_LIGHT),
                                        Colors.grey
                                      ]
                                    )
                                  ),

                                  child: Stack(
                                    children:  [
                                      const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text("Số:",style: TextStyle(fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "montserrat_black",color: Colors.red),),
                                      ),

                                      Positioned(child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(controller.playerModel.number ?? "",
                                            style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w700,
                                              fontFamily: "montserrat_black",color: Colors.red),),
                                        ),
                                      ))
                                    ],
                                  ),
                                )
                            ),
                            Expanded(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 12),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3), // changes position of shadow
                                      ),
                                    ],  gradient: const LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Color(AppColors.GRAY_LIGHT),
                                        Colors.grey
                                      ]
                                  )
                                  ),

                                  child: Stack(
                                    children:  [
                                      const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text("Tuổi:",style: TextStyle(fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "montserrat_black",color: Colors.red),),
                                      ),

                                      Positioned(child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(controller.getCurrentYear(),
                                            style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w700,
                                              fontFamily: "montserrat_black",color: Colors.red),),
                                        ),
                                      ))
                                    ],
                                  ),
                                )
                            ),
                            Expanded(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 12),
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                      gradient: const LinearGradient(
                                          colors: [
                                            Colors.white,
                                            Color(AppColors.GRAY_LIGHT),
                                            Colors.grey
                                          ]
                                      )
                                  ),

                                  child: Stack(
                                    children:  [
                                      const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text("Quốc gia:",style: TextStyle(fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "montserrat_black",color: Colors.red),),
                                      ),

                                      Positioned(child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(35),
                                            child: Image.network(controller.playerModel.nation ?? "",
                                              height: 35,
                                              width: 35,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ))
                                    ],
                                  ),
                                )
                            ),
                          ],
                        ),
                      )
                  );
  }

  Container buildStory() => Container(
    padding: const EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 32),
    child: Text(controller.playerModel.story ?? "",style: const TextStyle(
      fontSize: 14,
      fontFamily: "montserrat_black",
      color: Colors.black
    ),),
  );

}