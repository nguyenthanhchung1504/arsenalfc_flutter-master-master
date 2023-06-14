import 'package:arsenalfc_flutter/ui/search/searchnews/search_news_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../extension/extension.dart';
import '../../../routes/routes_const.dart';
import '../../../utils/messages.dart';

class SearchNewsScreen extends GetView<SearchNewsController> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            KeyString.KEY_SEARCH_NEW.tr,
            style: const TextStyle(
                fontFamily: "montserrat_black",
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            child:
            const Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
            onTap: () {
              Get.back();
            },
          ),
        ),
        body: GestureDetector(
          onTap: () => {
          FocusScope.of(context).requestFocus(FocusNode())
        },
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 12),
                child: TextField(
                  onChanged: (value) {
                    controller.search = value;
                    controller.getNewsPaging(false);
                  },
                  decoration: const InputDecoration(
                      hintText: "Tìm kiếm",
                      prefixIcon: Icon(Icons.search, color: Colors.grey,),
                      iconColor: Colors.grey,
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          borderSide: BorderSide(color: Colors.grey, width: 1)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          borderSide: BorderSide(color: Colors.grey, width: 1)),
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: const NewListSearch()
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}


class NewListSearch extends GetView<SearchNewsController> {
  const NewListSearch({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Obx(() =>
    controller.list.isNotEmpty ?
    ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: controller.list.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(AppConst.DETAIL_NEWS,
                  arguments: [controller.list.elementAt(index)]);
            },
            child: Container(
                margin: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: (MediaQuery
                              .of(context)
                              .size
                              .width / 2) - 20,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: controller.list
                                  .elementAt(index)
                                  .thumbnail ?? "",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                              placeholder: (context, url) => Image.asset(
                                "assets/images/loading.gif",
                                fit: BoxFit.cover,),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                            ),
                          )),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                controller.list
                                    .elementAt(index)
                                    .title ?? "",
                                overflow:
                                TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight:
                                    FontWeight.w700,
                                    fontFamily: "montserrat_black",
                                    color: HexColor.fromHex(
                                        "0A1220")),
                                maxLines: 2,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child:
                              Text(
                                "${DateFormat("dd/MM/yyyy").format(
                                    DateTime.parse(controller.list
                                        .elementAt(index)
                                        .createdDate!
                                        .split("T")
                                        .first))} - ${controller.list
                                    .elementAt(index)
                                    .views} lượt xem",
                                style: const TextStyle(fontSize: 10,
                                    fontFamily: "montserrat_black",
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      )


                    ],
                  ),
                )),
          );
        }) :
    Container());
  }

}
