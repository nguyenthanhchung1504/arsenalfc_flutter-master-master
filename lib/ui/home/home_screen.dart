import 'dart:io';

import 'package:arsenalfc_flutter/extension/extension.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/news/news_screen.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/players/players_screen.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/schedules/schedules_screen.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/videos/videos_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String sourceImage = "assets/images/";
  int _selectedIndex = 0;
  String? token = "";
  List subscribed = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            notification.title?.contains("bài viết") == true ? "Tin mới" : "Video mới",
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
    const SchedulesScreen(),
    const VideosScreen(),
    const PlayerScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
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

            BottomNavigationBarItem(
                icon: SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset("${sourceImage}ic_players.png")),
                activeIcon: SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset("${sourceImage}ic_player_select.png")),
                label: "Cầu thủ"),
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
    });
  }
}
