import 'package:arsenalfc_flutter/extension/extension.dart';
import 'package:arsenalfc_flutter/routes/routes_const.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/videos/videos_controller.dart';
import 'package:arsenalfc_flutter/utils/messages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pageviewj/pageviewj.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class VideosScreen extends GetView<VideoController> {
  const VideosScreen({Key? key}) : super(key: key);



  Future<void> _pullRefresh() async {
    controller.getVideosPaging(true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: RefreshIndicator(
                  onRefresh: _pullRefresh,
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                          child: Stack(
                            children: [
                              Positioned(
                                  child:  Text(
                                    KeyString.KEY_VIDEO.tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "montserrat_black",
                                        fontSize: 24,
                                        color: Colors.black),
                                  ),
                              ),
                              Positioned(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(AppConst.SEARCH_VIDEO);
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(left: 16,top: 8),
                                          child: const Icon(Icons.search)
                                      ),
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                            child: Text(
                              KeyString.KEY_LATEST.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  fontFamily: "montserrat_black",
                                  color: HexColor.fromHex("#0A1220")),
                              textAlign: TextAlign.left,
                            )),
                        HeaderView(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: const VideosListView(),
                        ),

                      ],
                    ),
                  )))),
    );
  }
}

class HeaderView extends GetView<VideoController> {

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              SizedBox(
                  height: 365,
                  child: PageViewJ(
                    controller: pageController,
                    itemCount: controller.listHeader.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){
                          Get.toNamed(AppConst.DETAIL_VIDEOS,arguments: [controller.listHeader.value.elementAt(index)]);
                        },
                        child: Column(
                          children: [
                            Container(
                              child:  ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12)),
                                  child: CachedNetworkImage(
                                      imageUrl: controller.list
                                          .elementAt(index)
                                          .thumbnail ??
                                          "",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                      placeholder: (context, url) =>
                                          Image.asset("assets/images/loading.gif",fit: BoxFit.fill,width: Get.width),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error))),
                              height: 250,
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 16, bottom: 8),
                              child: Text(
                                controller.listHeader
                                        .elementAt(index)
                                        .title ??
                                    "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,fontFamily: "montserrat_black",fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Text(
                                  "${DateFormat("dd/MM/yyyy").format(DateTime.parse((controller.listHeader.elementAt(index).createdDate ?? "2022-11-01T100:00:00").split("T").first))}"
                                      " - ${controller.listHeader.elementAt(index).views ?? 0} lượt xem",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontFamily: "montserrat_black",fontWeight: FontWeight.w400),
                                )),
                          ],
                        ),
                      );
                    },
                    transform: ShuttersCubeTransform(),
                  )),


              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: controller.listHeader.length,
                  axisDirection: Axis.horizontal,
                  effect: const ExpandingDotsEffect(
                      spacing: 8.0,
                      radius: 6.0,
                      dotWidth: 6.0,
                      dotHeight: 6.0,
                      paintStyle: PaintingStyle.fill,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.red),
                ),
              )
            ],
          ),
        ));
  }
}

class VideosListView extends GetView<VideoController> {
  const VideosListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        itemCount: controller.list.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              Get.toNamed(AppConst.DETAIL_VIDEOS,arguments: [controller.list.value.elementAt(index)]);
            },
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Row(
                children: [
                  SizedBox(
                      width: (MediaQuery.of(context).size.width / 2) - 45,
                      height: 108,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl:
                              controller.list.elementAt(index).thumbnail ?? "",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              Image.asset("assets/images/loading.gif",fit: BoxFit.cover,),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      )),
                  SizedBox(
                    height: 108,
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      direction: Axis.vertical,
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width) -
                              ((MediaQuery.of(context).size.width / 2)),
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Text(
                            controller.list.elementAt(index).title ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13,fontFamily: "montserrat_black",fontWeight: FontWeight.w700,
                                color: HexColor.fromHex("0A1220")),
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          width: (MediaQuery.of(context).size.width) -
                              ((MediaQuery.of(context).size.width / 2)),
                          child: Text(
                            "${DateFormat("dd/MM/yyyy").format(DateTime.parse(controller.list.elementAt(index).createdDate!.split("T").first))} - ${controller.list.elementAt(index).views} lượt xem",
                            style: const TextStyle(fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
