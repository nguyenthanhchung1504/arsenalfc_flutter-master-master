import 'dart:io';

import 'package:arsenalfc_flutter/extension/extension.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/more/more_screen.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/news/news_screen.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/players/players_screen.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/schedules/schedules_screen.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/videos/videos_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';
import '../../utils/messages.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin<HomeScreen>{
  final String sourceImage = "assets/images/";
  int _selectedIndex = 0;
  String? token = "";
  List subscribed = [];

  // PageController? _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _pageController = PageController(initialPage: _selectedIndex);
    FirebaseMessaging.instance.subscribeToTopic(KeyString.KEY_NEWS);
    if(Platform.isAndroid) {
      var initialzationSettingsAndroid = const AndroidInitializationSettings(
          '@mipmap/ic_launcher');
      var initializationSettings = InitializationSettings(
          android: initialzationSettingsAndroid);
      flutterLocalNotificationsPlugin.initialize(initializationSettings);
    }


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android.smallIcon,
              ),
            ));
      }
    });
    getToken();
  }

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = token;
    });
    print("token day" + (token ?? ""));
  }




  static final List<Widget> _widgetOptions = <Widget>[
    NewsScreen(),
    SchedulesScreen(),
    VideosScreen(),
    MoreScreen()
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    "${sourceImage}ic_news.png",
                  ),
                ),
                activeIcon: SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset("${sourceImage}ic_news_select.png")),
                label: "Tin tức"),
            BottomNavigationBarItem(
                icon: SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset("${sourceImage}ic_schedules.png")),
                activeIcon: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("${sourceImage}ic_schedules_select.png"),
                ),
                label: "Lịch thi đấu"),
            BottomNavigationBarItem(
                icon: SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset("${sourceImage}ic_videos.png")),
                activeIcon: SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset("${sourceImage}ic_videos_select.png")),
                label: "Video"),

            const BottomNavigationBarItem(
                icon: SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(Icons.settings,size: 24,color: Color(0xFF595959),)),
                activeIcon: SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(Icons.settings,size: 24,color:  Color(0xFFDC2F20),)),
                label: "Thiết lập"),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: HexColor.fromHex("#DC2F20"),
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
      // _pageController!.jumpToPage(_selectedIndex);
    });
  }

  @override
  bool get wantKeepAlive => true;
}
