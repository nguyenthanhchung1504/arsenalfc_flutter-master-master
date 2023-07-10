import 'package:arsenalfc_flutter/routes/routes_const.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/more/more_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class MoreScreen extends GetView<MoreController>{
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    Container(
                      width: Get.width,
                      height: 180,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/ic_header_more.png"),
                            fit: BoxFit.fill),
                      ),
                      child: Image.asset("assets/images/bg_more.png",fit: BoxFit.fill,),
                    ),

                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 120),
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(48), // Image radius
                          child: Image.network('https://www.w3schools.com/w3images/avatar2.png', fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                width: Get.width,
                color: Colors.white,
                child: const Text("Gooners",style: TextStyle(fontSize: 14,color: Color(0xFF595959)),)
              ),

              Container(
                alignment: Alignment.center,
                width: Get.width,
                color: Colors.white,
                padding: const EdgeInsets.only(bottom: 16),
                child: Text("NGUYỄN THÀNH CHUNG".toUpperCase(),style: const TextStyle(fontSize: 16,color: Color(0xFF0A1220),fontWeight: FontWeight.w700),),
              ),


              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.symmetric(vertical: 16,horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Row(
                  children: [
                    Image.asset("assets/images/ic_profile.png",width: 24,height: 24,),
                    const SizedBox(width: 12,),
                    const Expanded(
                        child: Text("Thay đổi thông tin cá nhân",style: TextStyle(fontSize: 14,color: Color(0xFF595959),fontWeight: FontWeight.w400),)
                    ),
                    const SizedBox(width: 12,),
                    const Icon(Icons.keyboard_arrow_right_sharp,size: 24,color: Colors.grey,),
                  ],
                ),
              ),


              GestureDetector(
                onTap: (){
                  Get.toNamed(AppConst.PLAYERS);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 12),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight:  Radius.circular(12))
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/images/ic_newfeeds.png",width: 24,height: 24,),
                      const SizedBox(width: 12,),
                      const Expanded(
                          child: Text("Danh sách cầu thủ",style: TextStyle(fontSize: 14,color: Color(0xFF595959),fontWeight: FontWeight.w400),)
                      ),
                      const SizedBox(width: 12,),
                    ],
                  ),
                ),
              ),

              Container(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 12),
                child: Row(
                  children: [
                    Image.asset("assets/images/ic_share_app.png",width: 20,height: 20,),
                    const SizedBox(width: 12,),
                    const Expanded(
                        child: Text("Giới thiệu app cho bạn bè",style: TextStyle(fontSize: 14,color: Color(0xFF595959),fontWeight: FontWeight.w400),)
                    ),
                    const SizedBox(width: 12,),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 12),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight:  Radius.circular(12))
                ),
                child: Row(
                  children: [
                    Image.asset("assets/images/ic_rate_app.png",width: 24,height: 24,),
                    const SizedBox(width: 12,),
                    const Expanded(
                        child: Text("Đánh giá app",style: TextStyle(fontSize: 14,color: Color(0xFF595959),fontWeight: FontWeight.w400),)
                    ),
                    const SizedBox(width: 12,),
                  ],
                ),
              ),



              Container(
                alignment: Alignment.center,
                width: Get.width,
                margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
                padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 12),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: const Text("Đăng xuất",style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w400),)
              ),

            ],
          ),
        ),
      ),
    );
  }

}