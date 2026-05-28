import 'package:gooner_vietnam/routes/routes_const.dart';
import 'package:gooner_vietnam/ui/changeprofile/change_profile_bindings.dart';
import 'package:gooner_vietnam/ui/changeprofile/change_profile_screen.dart';
import 'package:gooner_vietnam/ui/home/tabs/more/more_binding.dart';
import 'package:gooner_vietnam/ui/home/tabs/more/more_screen.dart';
import 'package:gooner_vietnam/ui/search/searchnews/search_news_binding.dart';
import 'package:gooner_vietnam/ui/search/searchnews/search_news_screen.dart';
import 'package:gooner_vietnam/ui/search/searchvideo/search_video_binding.dart';
import 'package:gooner_vietnam/ui/search/searchvideo/search_video_screen.dart';
import 'package:gooner_vietnam/ui/signin/sign_in_binding.dart';
import 'package:gooner_vietnam/ui/signin/sign_in_screen.dart';
import 'package:gooner_vietnam/ui/signup/sign_up_screen.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../ui/detailnew/detail_new_binding.dart';
import '../ui/detailnew/detail_new_screen.dart';
import '../ui/detailplayer/detail_player_binding.dart';
import '../ui/detailplayer/detail_player_screen.dart';
import '../ui/home/home_screen.dart';

import '../features/news/presentation/news_detail_page.dart';
import '../features/news/presentation/news_tab.dart';
import '../features/videos/presentation/video_detail_page.dart';
import '../features/videos/presentation/videos_tab.dart';
import '../ui/home/tabs/players/players_binding.dart';
import '../ui/home/tabs/players/players_screen.dart';
import '../ui/home/tabs/schedules/schedules_binding.dart';
import '../ui/home/tabs/schedules/schedules_screen.dart';
import '../ui/signup/sign_up_binding.dart';

routes() => [
  GetPage(name: AppConst.SIGN_IN, page: () =>  SignInScreen(),binding: SignInBinding(),transition: Transition.rightToLeftWithFade,transitionDuration: const Duration(milliseconds: 500)),
  GetPage(name: AppConst.SIGN_UP, page: () => SignUpScreen(),binding: SignUpBinding(),transition: Transition.rightToLeftWithFade,transitionDuration: const Duration(milliseconds: 500)),
  GetPage(name: AppConst.MAIN, page: () => MainScreen(),bindings: [SignInBinding()]),
  GetPage(name: AppConst.HOME, page: () => HomeScreen(),bindings: [SchedulesBinding(),PlayerBindings(),MoreBindings()]),
  GetPage(name: AppConst.NEWS, page: () => const NewsTab()),
  GetPage(name: AppConst.VIDEOS, page: () => const VideosTab()),
  GetPage(name: AppConst.SCHEDULES, page: () => SchedulesScreen(),binding: SchedulesBinding()),
  GetPage(name: AppConst.PLAYERS, page: () => PlayerScreen(),binding: PlayerBindings()),
  GetPage(name: AppConst.MORE, page: () => MoreScreen(),binding: MoreBindings()),
  GetPage(
    name: AppConst.DETAIL_NEWS,
    page: () {
      final id = Get.arguments;
      if (id is String) return NewsDetailPage(newsId: id);
      return const NewsDetailPage(newsId: '');
    },
    transition: Transition.rightToLeftWithFade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: AppConst.DETAIL_VIDEOS,
    page: () {
      final id = Get.arguments;
      if (id is String) return VideoDetailPage(videoId: id);
      return const VideoDetailPage(videoId: '');
    },
    transition: Transition.rightToLeftWithFade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(name: AppConst.DETAIL_PLAYER, page: () =>  DetailPlayerScreen(),binding: DetailPlayerBindings(),transition: Transition.zoom,transitionDuration: const Duration(milliseconds: 500)),
  GetPage(name: AppConst.SEARCH_NEW, page: () => SearchNewsScreen(),binding: SearchNewsBinding(),transition: Transition.rightToLeftWithFade,transitionDuration: const Duration(milliseconds: 500)),
  GetPage(name: AppConst.SEARCH_VIDEO, page: () => SearchVideoScreen(),binding: SearchVideoBinding(),transition: Transition.rightToLeftWithFade,transitionDuration: const Duration(milliseconds: 500)),
  GetPage(name: AppConst.CHANGE_PROFILE, page: () => ChangeProfileScreen(),binding: ChangeProfileBindings(),transition: Transition.rightToLeftWithFade,transitionDuration: const Duration(milliseconds: 500)),
];