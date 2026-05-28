# 🔴⚪ AFCVN – Kế hoạch hồi sinh ứng dụng

> Tài liệu sống – mỗi khi đưa ra quyết định hoặc hoàn thành một mục, hãy cập nhật lại file này.
> Tài liệu được viết theo nguyên tắc: **phase nhỏ, PR ngắn, có thể rollback**.

---

## Mục lục

1. [Bối cảnh & mục tiêu](#1-bối-cảnh--mục-tiêu)
2. [Hiện trạng project (Audit)](#2-hiện-trạng-project-audit)
3. [Quyết định cần chốt (chờ user xác nhận)](#3-quyết-định-cần-chốt-chờ-user-xác-nhận)
4. [Định danh & Branding](#4-định-danh--branding)
5. [Cấu trúc project sau refactor](#5-cấu-trúc-project-sau-refactor)
6. [Nâng cấp toolchain & thư viện](#6-nâng-cấp-toolchain--thư-viện)
7. [Hoạch định tính năng (Feature Map)](#7-hoạch-định-tính-năng-feature-map)
8. [Kiến trúc backend mới (Firebase + api-football)](#8-kiến-trúc-backend-mới-firebase--api-football)
9. [Roadmap chi tiết theo Phase](#9-roadmap-chi-tiết-theo-phase)
10. [Bảo mật & quy ước code](#10-bảo-mật--quy-ước-code)
11. [Acceptance Criteria & Milestone](#11-acceptance-criteria--milestone)
12. [Phụ lục](#12-phụ-lục)

---

## 1. Bối cảnh & mục tiêu

### 1.1. Bối cảnh

- Ứng dụng dành cho cộng đồng fan Arsenal tại Việt Nam, đã từng hoạt động ổn định, hiện đang **ngừng vận hành**:
  - Backend cũ `api.afcvn.website` đã **chết** → toàn bộ tin tức, video, login đều lỗi.
  - API thể thao (api-football) **lộ key** trong source và **chưa có cache** → dễ vượt quota free.
  - Toolchain (Dart/Flutter/Gradle/Kotlin/Firebase SDK) **đã lạc hậu** so với bản hiện hành.
  - UX/UI nhiều chỗ tạm bợ (splash hardcode delay 3s, bypass auth, ...).

### 1.2. Mục tiêu chiến lược

| # | Mục tiêu | Tiêu chí đo |
|---|---|---|
| G1 | Backend chạy lại được toàn bộ tính năng cốt lõi | News / Videos / Schedules / Standings / Profile đều hiển thị dữ liệu thật |
| G2 | Chi phí vận hành ≈ 0đ (trừ AdMob doanh thu vào) | Firebase Spark hoặc Blaze < 1$/tháng |
| G3 | Toolchain mới nhất, build được trên Flutter ổn định mới | `flutter build apk --release` + `flutter build ios` pass |
| G4 | Có cấu trúc sạch, dễ mở rộng | Feature-first folder, repository layer, không hardcode secret |
| G5 | Sẵn sàng đăng lên Play Store & App Store | Đạt policy mới của Google/Apple 2026 |

### 1.3. Phạm vi (Scope) v1

**Trong scope:**
- Backend chuyển sang Firebase (Firestore + Auth + Storage + FCM + Crashlytics).
- Proxy api-football qua Cloud Functions + Cloud Scheduler.
- Refactor cấu trúc project theo feature-first.
- Nâng cấp toàn bộ dependencies + Flutter SDK.
- Đổi tên app, package, applicationId (nếu user chọn).
- Giữ AdMob, tích hợp Remote Config.

**Ngoài scope v1 (để v1.1+):**
- Web admin panel custom (giai đoạn đầu dùng Firebase Console + small Flutter Web admin).
- Bán/áo, ticket, forum/comment.
- Live audio commentary.
- Hỗ trợ macOS / Windows / Linux.

---

## 2. Hiện trạng project (Audit)

### 2.1. Tổng quan

| Thành phần | Trạng thái | Ghi chú |
|---|---|---|
| Flutter SDK constraint | ⚠️ `>=2.16.1 <3.0.0` | Quá cũ, cần bump |
| Backend cũ `api.afcvn.website` | ❌ Chết | Tất cả `*_provider.dart` cần rewrite |
| Firebase project `afc-arsenal` | ✅ Còn sống | Đang dùng FCM + Crashlytics |
| api-football (api-sports.io trực tiếp) | ⚠️ Key cũ trên RapidAPI lộ → đã chuyển sang api-sports.io | Key mới chỉ ở `.env` local + Cloud Function secret |
| AdMob | ✅ Còn cấu hình | App ID đang trong AndroidManifest/Info.plist |
| Android (Gradle/Kotlin) | ✅ Vừa fix build xong | Kotlin 2.2.0, AGP 8.10.0, Gradle 8.11.1 |
| iOS | ❓ Chưa verify | Cần test lại sau khi nâng SDK |

### 2.2. Cấu trúc thư mục hiện tại (`lib/`)

```
lib/
├── api/Api.dart                    # Dio singleton, base URL chết
├── extension/extension.dart        # HexColor extension
├── firebase_options.dart
├── main.dart                       # Khởi tạo FCM, AdMob, GetX
├── model/                          # 30+ file model phân tán theo feature con
│   ├── detailnews/, detailvideo/, fixtures/, login/, news/, players/
│   ├── recomment/, standing/, upload/, user_info/, videos/
├── routes/                         # routes_const.dart + routes.dart
├── ui/                             # Cấu trúc GetX MVC: screen/controller/binding/provider
│   ├── changeprofile/, detailnew/, detailplayer/, detailvideo/
│   ├── home/ (tabs: news/schedules/videos/players/more)
│   ├── search/ (searchnews, searchvideo)
│   ├── signin/, signup/, splash/
└── utils/                          # colors.dart, messages.dart, status.dart, utils.dart
```

**Đánh giá:**
- ✅ Đã có pattern GetX (screen/controller/binding/provider) – consistent.
- ❌ Trộn lẫn naming: `detailnew` vs `detail_new`, `more` vs `more_screen`.
- ❌ Models phân tán, dùng PascalCase file (`Fixture.dart`) lẫn snake_case.
- ❌ Không có repository layer – controller gọi thẳng provider.
- ❌ Hardcode rất nhiều: màu (`#DC2F20`), text (`"Tin tức"`, `"Lịch thi đấu"`), URL.
- ❌ Localization có sẵn (`messages.dart`) nhưng nhiều màn hình **không dùng**.

### 2.3. Vấn đề bảo mật phát hiện

| # | Vấn đề | Vị trí | Mức độ |
|---|---|---|---|
| S1 | api-football key hardcode (RapidAPI cũ) | đã gỡ khỏi `schedules_provider.dart`; chuyển sang `.env` (api-sports.io) | ✅ Resolved Phase 0 |
| S2 | Firebase apiKey hardcode trong source | `lib/firebase_options.dart` | 🟡 Acceptable (FlutterFire chuẩn, restrict bằng Security Rules) |
| S3 | Bypass auth, mọi user vào HOME | `lib/ui/splash/splash_screen.dart:35` | 🟡 Medium |
| S4 | Không có `flutter_dotenv` / Remote Config | toàn project | 🟡 Medium |
| S5 | Không có Firestore Security Rules (sẽ làm ở phase 3) | — | 🔴 Critical khi bật Firestore |

---

## 3. Quyết định đã chốt ✅

> Cập nhật: 2026-05-20 — các lựa chọn dưới đây đã được user xác nhận.

### Q1 – Tên hiển thị mới của app
- [ ] Giữ nguyên "**Offical AFCVN**" (lưu ý: typo "Offical" → đề xuất sửa)
- [ ] **AFCVN – Arsenal Vietnam** *(đề xuất)*
- [ ] **Arsenal Vietnam Fan Club**
- [x] **Gooner Vietnam**
- [ ] Khác: `_________________`

### Q2 – Package name / applicationId / iOS bundle id
Hiện tại: `com.ntchung.arsenalafc`
- [ ] Giữ nguyên (đỡ mất user cài đặt, nhưng tên cá nhân)
- [x] **`vn.afcvn.app`** *(đề xuất – domain-based, professional)*
- [ ] **`com.afcvn.fanapp`**
- [ ] Khác: `_________________`

> ⚠️ Đổi package name = **app store coi là app mới**, user cũ phải cài lại. Nếu đã có user nhiều thì cân nhắc.

### Q3 – Firebase project
- [ ] Giữ project cũ `afc-arsenal` (đã có FCM topic subscriber)
- [x] Tạo project mới sạch `afcvn-app`

### Q4 – Firebase plan
- [ ] Spark (Free) – KHÔNG dùng được Cloud Functions, KHÔNG cache được api-football
- [x] **Blaze (Pay-as-you-go)** *(đề xuất)* – budget cap $1/tháng là đủ

### Q5 – Auth strategy
- [x] Reset toàn bộ, user đăng ký lại bằng Firebase Auth *(đề xuất – đơn giản, an toàn)*
- [ ] Cố migrate user cũ (khó, tốn công, password hash khác hệ thống)
- [ ] Bỏ luôn auth, app dùng anonymous + FCM topic

### Q6 – Nguồn nội dung News/Video
- [x] Tự đăng bài qua admin (web admin riêng + Firestore)
- [ ] Crawl tự động từ arsenal.com / fanpage *(rủi ro vi phạm bản quyền)*
- [x] Kết hợp: tự đăng bài highlight + nhúng video YouTube

### Q7 – Tần suất refresh diễn biến trận đấu live
- [ ] 2 tiếng (siêu rẻ, không thực sự "live")
- [x] **Mỗi 60–90s, chỉ trong khung giờ Arsenal đang đá** *(đề xuất – tốn ~30 call/ngày)*
- [ ] Realtime hoàn toàn (vượt quota free)

### Q8 – State management
- [ ] Giữ **GetX** *(đề xuất – đỡ rewrite)*
- [x] Migrate sang **Riverpod** (sạch hơn, cộng đồng lớn hơn 2026, nhưng tốn công)
- [ ] Migrate sang **Bloc**

### Q9 – Ngôn ngữ hỗ trợ v1
- [ ] Tiếng Việt mặc định (đa số user) *(đề xuất)*
- [x] Việt + Anh
- [ ] Việt + Anh + chuẩn `intl` ARB cho dễ thêm ngôn ngữ

### Q10 – Min OS version
- [ ] Android **24** + iOS **13** *(đề xuất – cover ~98% device)*
- [ ] Android **21** + iOS **12** (legacy hơn, tốn công maintain)
- [x] Android **26** + iOS **14** (modern hơn, loại bỏ device cũ)

---

## 4. Định danh & Branding

### 4.1. Bảng tóm tắt sau khi chốt

| Thuộc tính | Hiện tại | Mới |
|---|---|---|
| Tên Flutter project | `arsenalfc_flutter` | **`gooner_vietnam`** ✅ |
| App display (Android/iOS) | `Offical AFCVN` | **Gooner Vietnam** ✅ |
| applicationId (Android) | `com.ntchung.arsenalafc` | **`vn.afcvn.app`** ✅ |
| Bundle ID (iOS) | `com.ntchung.arsenalafc` | **`vn.afcvn.app`** ✅ |
| Kotlin package | `com.ntchung.arsenalafc` | **`vn.afcvn.app`** ✅ |
| Firebase project | `afc-arsenal` | **`afcvn-app`** (mới) |
| Firebase plan | — | **Blaze** (budget cap $1/tháng) |
| State management | GetX | **Riverpod** (migrate Phase 2) |
| Ngôn ngữ v1 | Việt | **Việt + Anh** |
| Min OS | Android 24 / iOS ? | **Android 26 / iOS 14** |
| versionName | `4.0` | `5.0.0` |
| versionCode | `18` | `19` |

### 4.2. Color palette chuẩn hoá

Hiện tại đang hardcode tùm lum (`#DC2F20`, `#DC2F20`, `0xFFD7291D`, `0xFFAA2218`). Sau refactor sẽ centralize:

```dart
class AppColors {
  static const Color primary       = Color(0xFFEF0107); // Arsenal Red
  static const Color primaryDark   = Color(0xFFAA2218);
  static const Color primaryLight  = Color(0xFFD7291D);
  static const Color accent        = Color(0xFF023474); // Arsenal Navy
  static const Color gold          = Color(0xFF9C824A); // Arsenal Gold
  static const Color background    = Color(0xFFFFFFFF);
  static const Color surface       = Color(0xFFF5F5F5);
  static const Color textPrimary   = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF595959);
  // ...
}
```

Quy tắc: **mọi `Color(...)` trong widget phải đến từ `AppColors`** (theo user rule "không hard code color").

### 4.3. Logo / Icon

- [x] Giữ logo hiện tại `assets/images/ic_logo_arsenal.png`
- [ ] Thiết kế lại launcher icon adaptive (Android 12+) – cần file SVG
- [x] Tạo splash mới dùng `flutter_native_splash` (đỡ flicker)

---

## 5. Cấu trúc project sau refactor

### 5.1. Folder structure đề xuất (feature-first + layered)

```
lib/
├── app/                              # Khởi tạo app, theme, router
│   ├── app.dart                      # GetMaterialApp entry
│   ├── bindings/initial_binding.dart
│   ├── theme/                        # AppColors, AppTextStyles, AppTheme
│   └── router/app_pages.dart         # GetPage routes
│
├── core/                             # Code dùng chung, không phụ thuộc feature
│   ├── config/                       # AppConfig, Env (đọc từ --dart-define)
│   ├── constants/                    # AssetPaths, FirestorePaths
│   ├── error/                        # Failure, Exception types
│   ├── extensions/                   # HexColor, DateX, StringX
│   ├── network/                      # DioClient, interceptors
│   ├── services/                     # FirebaseService, NotificationService, AdsService
│   ├── storage/                      # LocalStorage wrapper (get_storage)
│   └── utils/                        # Logger, Validators, Formatters
│
├── data/                             # Tầng data: model, datasource, repository impl
│   ├── models/                       # DTOs đọc từ Firestore / API
│   │   ├── news/news_dto.dart
│   │   ├── video/video_dto.dart
│   │   ├── fixture/fixture_dto.dart
│   │   ├── standing/standing_dto.dart
│   │   ├── player/player_dto.dart
│   │   └── user/user_dto.dart
│   ├── datasources/
│   │   ├── remote/                   # Firestore / Cloud Functions
│   │   └── local/                    # Cache local (get_storage)
│   └── repositories/                 # NewsRepositoryImpl, ...
│
├── domain/                           # Pure dart, không import Flutter/Firebase
│   ├── entities/                     # News, Video, Fixture, Standing, Player, AppUser
│   └── repositories/                 # NewsRepository (interface), ...
│
├── features/                         # UI tổ chức theo feature
│   ├── splash/
│   ├── auth/                         # signin, signup, change_profile
│   ├── home/                         # bottom nav shell
│   ├── news/                         # list + detail + search
│   ├── videos/                       # list + detail + search
│   ├── schedules/                    # fixtures + results + standings + live match
│   ├── players/                      # list + detail
│   └── settings/                     # more, about, language
│       └── (mỗi feature gồm: bindings/, controllers/, views/, widgets/)
│
└── main.dart                         # Bootstrap: dotenv + firebase + runApp
```

### 5.2. Quy ước đặt tên

| Loại | Quy ước | Ví dụ |
|---|---|---|
| File | `snake_case.dart` | `news_controller.dart` |
| Class | `UpperCamelCase` | `NewsController` |
| Biến / hàm | `lowerCamelCase` | `fetchLatestNews()` |
| Constant | `lowerCamelCase` (không SCREAMING_CASE nữa) | `kDefaultPageSize`, hoặc enum |
| Route | `/snake-case` | `/news-detail` |
| Firestore collection | `lower_snake_case` (số nhiều) | `news`, `videos`, `fixtures` |
| Firestore field | `lowerCamelCase` | `publishedAt`, `thumbnailUrl` |

### 5.3. Quy ước commit (Conventional Commits)

```
feat(news): add infinite scroll for news list
fix(auth): handle Firebase Auth user-not-found error
refactor(schedules): extract fixture mapper
chore(deps): bump firebase_core to ^4.0.0
docs(plan): update phase 2 progress
```

---

## 6. Nâng cấp toolchain & thư viện

### 6.1. Toolchain target

| Thành phần | Hiện tại | Target |
|---|---|---|
| Flutter | (theo SDK constraint cũ) `~3.7` | **Flutter 3.27+ (stable)** |
| Dart SDK | `>=2.16.1 <3.0.0` | `>=3.5.0 <4.0.0` |
| Kotlin | 2.2.0 | 2.2.0 ✅ |
| AGP | 8.10.0 | 8.10.0 ✅ |
| Gradle | 8.11.1 | 8.11.1 ✅ |
| Java | 17 | 17 ✅ |
| Android compileSdk / targetSdk | 36 | 36 ✅ |
| Android minSdk | 24 | 24 (per Q10) |
| iOS deployment target | (cần check) | 13.0 (per Q10) |

### 6.2. Dependencies cần bump (theo `flutter pub outdated` đã chạy lần trước)

| Package | Hiện tại | Target | Lý do |
|---|---|---|---|
| `firebase_core` | 2.32.0 | **4.x** | Compat với plugin mới |
| `firebase_messaging` | 14.7.10 | **16.x** | API thay đổi nhiều |
| `firebase_crashlytics` | 3.5.7 | **5.x** | Compat firebase_core 4 |
| `firebase_auth` | (chưa có) | **6.x** | Thay backend cũ |
| `cloud_firestore` | (chưa có) | **6.x** | Thay backend cũ |
| `firebase_storage` | (chưa có) | **13.x** | Thay backend cũ |
| `firebase_remote_config` | (chưa có) | **6.x** | Cấu hình động |
| `google_mobile_ads` | 6.0.0 | **8.x** | App phải cập nhật theo policy AdMob |
| `flutter_local_notifications` | 18.0.1 | **21.x** | Compat Android 14/15 |
| `dio` | 5.9.0 | 5.9.2 | Minor |
| `get` | 4.7.2 | 4.7.3 | Minor |
| `get_storage` | 2.1.1 | 2.1.1 ✅ |
| `cached_network_image` | 3.3.1 | 3.4.1 | Minor |
| `share_plus` | 12.0.1 | **13.x** | API mới |
| `image_picker` | 1.2.0 | 1.2.2 | Patch |
| `webview_flutter` | 4.13.0 | 4.13.1 | Patch |
| `flutter_lints` | 1.0.4 | **6.x** | Strict hơn |
| `pod_player` | 0.2.2 | ❓ | Cân nhắc bỏ, dùng YouTube Player Iframe |

### 6.3. Dependencies cần **thêm**

| Package | Mục đích |
|---|---|
| `firebase_auth`, `cloud_firestore`, `firebase_storage`, `firebase_remote_config` | Backend mới |
| `flutter_dotenv` hoặc `--dart-define` | Quản lý env |
| `freezed`, `freezed_annotation` | Data class + union + copyWith |
| `json_serializable`, `json_annotation` | Generate fromJson/toJson |
| `build_runner` (dev) | Codegen |
| `flutter_native_splash` (dev) | Splash chuẩn 2 nền tảng |
| `flutter_launcher_icons` (dev) | Generate icon |
| `intl` | Đã có – dùng cho format date |
| `youtube_player_iframe` *(nếu bỏ pod_player)* | Embed YouTube |
| `connectivity_plus` (thay `internet_connection_checker` đã cũ) | Check mạng |
| `equatable` (nếu không xài freezed cho entity) | So sánh value |

### 6.4. Dependencies cần **bỏ**

| Package | Lý do |
|---|---|
| `pageviewj` | Maintainer ngừng, dùng `PageView` built-in |
| `internet_connection_checker: ^1.0.0+1` | Cũ → `connectivity_plus` |
| `pod_player` *(nếu Q6 chọn YouTube)* | Đề xuất YouTube Iframe nhẹ hơn |
| `permission_handler` *(nếu không còn upload avatar phức tạp)* | Tuỳ vào auth |

---

## 7. Hoạch định tính năng (Feature Map)

### 7.1. Bảng tính năng v1

| ID | Feature | Trạng thái hiện tại | Kế hoạch v1 |
|---|---|---|---|
| F01 | Splash + Onboarding | Có splash tạm | Native splash + 3 page onboarding (skip được) |
| F02 | Auth – Đăng ký / Đăng nhập | UI có nhưng backend chết | Firebase Auth (Email + Google + Apple) |
| F03 | Auth – Anonymous mode | Không | Thêm: cho phép xem mọi thứ không cần đăng nhập, chỉ login khi bình luận |
| F04 | Profile + đổi avatar | Có backend cũ | Firebase Auth + Firebase Storage |
| F05 | Bottom Nav 4 tab | Có | Giữ + redesign icon |
| F06 | News – Danh sách + pagination | Backend chết | Firestore collection `news`, infinite scroll |
| F07 | News – Chi tiết + Recommend | Backend chết | Firestore + query "related" theo tag |
| F08 | News – Tìm kiếm | Backend chết | Firestore client-side filter (v1) hoặc Algolia (v1.1) |
| F09 | Videos – Danh sách | Backend chết | Firestore `videos`, thumbnail từ YouTube |
| F10 | Videos – Chi tiết | Backend chết + `pod_player` | YouTube Iframe Player |
| F11 | Videos – Tìm kiếm | Backend chết | Như F08 |
| F12 | Schedules – Lịch thi đấu Arsenal | api-football trực tiếp | Đọc Firestore cache (refresh 12h) |
| F13 | Schedules – Kết quả | api-football trực tiếp | Đọc Firestore cache (refresh 2h sau trận) |
| F14 | Standings – BXH Premier League | api-football trực tiếp | Đọc Firestore cache (refresh 6h) |
| F15 | **Live Match – Diễn biến trận đấu** | Không có | **MỚI** – Cloud Function poll mỗi 60s khi đang đá, mobile dùng Firestore listener |
| F16 | Players – Danh sách cầu thủ | Provider rỗng | Firestore `players` (tự sync 1 lần/tuần từ api-football `/squads`) |
| F17 | Players – Chi tiết cầu thủ | Provider rỗng | Firestore + chỉ số mùa hiện tại |
| F18 | Push Notification | FCM có sẵn topic `news` | Mở rộng topic: `news`, `live_match`, `result` |
| F19 | More – About / Rate / Share | Chưa rõ | Implement đủ |
| F20 | Settings – Đổi ngôn ngữ | Có Translations | Bổ sung switch Light/Dark theme + Language |
| F21 | AdMob banner + interstitial | Có sẵn ID | Giữ, thêm Native Ads ở list news |
| F22 | Remote Config | Chưa có | Bật/tắt feature flag, đổi banner promo |

### 7.2. Tính năng đẩy sang v1.1+

- F23 Comment + Like bài viết (Firestore + Auth bắt buộc)
- F24 Notifications inbox in-app
- F25 Lineup dự đoán + Voting
- F26 Web admin panel (Flutter Web hoặc Next.js)
- F27 Predictions / Mini-game
- F28 Match-day chat room (Firestore + rate limit)

---

## 8. Kiến trúc backend mới (Firebase + api-football)

### 8.1. Sơ đồ tổng thể

```
                ┌────────────────────────────────────────────────┐
                │              FIREBASE PROJECT                  │
                │  ┌──────────────┐    ┌──────────────────────┐  │
                │  │   Auth       │    │   Cloud Functions    │  │
                │  │  (Email,     │    │  - cronFixtures      │  │
                │  │   Google,    │    │  - cronStandings     │  │
                │  │   Apple)     │    │  - cronLiveMatch     │  │
                │  └──────┬───────┘    │  - onNewsCreate      │  │
                │         │            └─────────┬────────────┘  │
                │  ┌──────▼──────────────────────▼────────────┐  │
                │  │              FIRESTORE                   │  │
                │  │  /news /videos /players /users           │  │
                │  │  /cache/fixtures /cache/standings        │  │
                │  │  /cache/live_match/{fixtureId}           │  │
                │  └──────┬───────────────────────────────────┘  │
                │         │                                      │
                │  ┌──────▼───────┐    ┌──────────────────────┐  │
                │  │   Storage    │    │   Cloud Messaging    │  │
                │  │  (avatars,   │    │   topic: news,       │  │
                │  │   uploads)   │    │   live_match, result │  │
                │  └──────────────┘    └──────────────────────┘  │
                └────────────────────────────────────────────────┘
                         ▲                              ▲
                         │ read/write SDK               │ scheduled call
                         │                              │
                ┌────────┴────────┐            ┌────────┴────────┐
                │   Flutter App   │            │  api-football   │
                └─────────────────┘            └─────────────────┘
```

### 8.2. Firestore schema (đề xuất)

```
news/{newsId}
  - title: string
  - slug: string
  - thumbnailUrl: string
  - excerpt: string
  - contentHtml: string
  - tags: array<string>
  - publishedAt: timestamp
  - authorId: string
  - viewCount: number

videos/{videoId}
  - title: string
  - youtubeId: string
  - thumbnailUrl: string
  - description: string
  - publishedAt: timestamp
  - tags: array<string>

players/{playerId}
  - apiFootballId: number
  - name: string
  - shirtNumber: number
  - position: string
  - photoUrl: string
  - nationality: string
  - dateOfBirth: timestamp
  - stats: { goals, assists, appearances, ... }
  - updatedAt: timestamp

users/{uid}
  - email: string
  - displayName: string
  - photoURL: string
  - phoneNumber: string
  - role: 'user' | 'admin'
  - fcmTokens: array<string>
  - createdAt: timestamp

cache/fixtures
  - season: number          # 2025-26
  - teamId: 42
  - updatedAt: timestamp
  - data: array<Fixture>

cache/standings
  - leagueId: 39            # Premier League
  - season: number
  - updatedAt: timestamp
  - data: array<Standing>

cache/live_match/{fixtureId}
  - status: 'NS' | '1H' | 'HT' | '2H' | 'FT' | ...
  - elapsed: number
  - goalsHome: number
  - goalsAway: number
  - events: array<Event>    # goals, cards, subs
  - lineups: { home, away }
  - statistics: array
  - updatedAt: timestamp
```

### 8.3. Cloud Functions

| Function | Trigger | Logic | Frequency |
|---|---|---|---|
| `cronFixtures` | Cloud Scheduler `0 */12 * * *` | Gọi api-football `/fixtures?team=42&season=X`, ghi `cache/fixtures` | 2 lần/ngày |
| `cronStandings` | Cloud Scheduler `0 */6 * * *` | Gọi `/standings?league=39&season=X`, ghi `cache/standings` | 4 lần/ngày |
| `cronLiveMatchDispatcher` | Cloud Scheduler `*/5 * * * *` | Check có trận Arsenal đang đá hay sắp đá trong 2h → enable poller | Mỗi 5 phút |
| `cronLiveMatch` | Cloud Tasks chained | Khi đang live: gọi `/fixtures?id={fixtureId}` + `/fixtures/events` + `/fixtures/statistics`, ghi `cache/live_match/{fixtureId}` | Mỗi 60–90s |
| `cronSyncPlayers` | Cloud Scheduler `0 3 * * 1` | Gọi `/players/squads?team=42`, ghi `players` | Thứ 2 hàng tuần |
| `onLiveMatchEvent` | Firestore trigger trên `cache/live_match/{fixtureId}` | Phát FCM khi có goal/card mới | On write |
| `onNewsCreate` | Firestore trigger `news/{id}` onCreate | FCM topic `news` + ghi `notifications` | On create |

### 8.4. Security Rules (skeleton)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    function isAdmin() {
      return request.auth != null
          && get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin';
    }

    match /news/{id} {
      allow read: if true;
      allow write: if isAdmin();
    }
    match /videos/{id} {
      allow read: if true;
      allow write: if isAdmin();
    }
    match /players/{id} {
      allow read: if true;
      allow write: if false; // chỉ Cloud Function (admin SDK)
    }
    match /cache/{document=**} {
      allow read: if true;
      allow write: if false; // chỉ Cloud Function
    }
    match /users/{uid} {
      allow read: if request.auth.uid == uid || isAdmin();
      allow write: if request.auth.uid == uid;
    }
  }
}
```

### 8.5. Ước lượng quota api-football (free 100 req/ngày)

| Job | Req/lần | Tần suất | Tổng/ngày |
|---|---|---|---|
| Fixtures | 1 | 2 lần | 2 |
| Standings | 1 | 4 lần | 4 |
| Squads | 1 | 1 lần/tuần | ~0.14 |
| Live match (chỉ ngày có trận, ~3 ngày/tuần) | 3 endpoint × 80 lần | 3/7 | ~103 (trung bình theo ngày) |
| **Tổng trung bình** | | | **~109/ngày** |

→ Hơi sát 100. Tinh chỉnh: trong giờ live giảm xuống 1 endpoint (events) hoặc cách 90s thay vì 60s → còn ~70/ngày. **An toàn.**

---

## 9. Roadmap chi tiết theo Phase

> Mỗi phase = 1 PR / 1 mốc có thể release thử.

### Phase 0 – Bảo mật & nền tảng *(0.5–1 ngày)*
- [x] **Tạo memory-bank** theo rule của user (`projectbrief.md`, `productContext.md`, `systemPatterns.md`, `techContext.md`, `activeContext.md`, `progress.md`).
- [x] Chuyển provider sang **api-sports.io** trực tiếp (`https://v3.football.api-sports.io`, header `x-apisports-key`).
- [ ] *(User)* Vô hiệu hoá key RapidAPI cũ `d43e6b99…eaf` nếu còn active.
- [x] Thêm `.env` + `flutter_dotenv` hoặc setup `--dart-define` cho:
  - `APIFOOTBALL_KEY` + `APIFOOTBALL_BASE_URL` + `APIFOOTBALL_PROVIDER` (chỉ dùng cho local test, production gọi qua Firestore cache)
  - `ADMOB_APP_ID_ANDROID`, `ADMOB_APP_ID_IOS`
- [x] Cập nhật `.gitignore` (đảm bảo `.env`, `google-services.json`, `GoogleService-Info.plist` được protect đúng).
- [x] **Bump SDK**:
  - `pubspec.yaml` → `environment: sdk: '>=3.5.0 <4.0.0'`
  - Cài Flutter stable mới (3.27+).
- [x] Chạy `flutter pub get` + `flutter build apk --debug` pass.

### Phase 1 – Rebrand & cấu trúc *(1–2 ngày)*
- [x] **Đổi tên hiển thị** → **Gooner Vietnam** (`AndroidManifest`, `Info.plist`)
- [x] **applicationId / bundleId / Kotlin** → `vn.afcvn.app` (`MainActivity` → `vn/afcvn/app/`)
- [x] **pubspec** `name: gooner_vietnam` + toàn bộ `import package:gooner_vietnam/...`
- [x] **`AppInfo`** (`lib/core/constants/app_info.dart`) — share/rate/splash dùng constant
- [x] Build debug pass (`app-debug.apk`)
- [ ] **Theme system** (`AppColors` mở rộng, gỡ hardcode màu còn lại) — Phase 1b hoặc Phase 2
- [ ] **Native splash + launcher icon** (`flutter_native_splash`, `flutter_launcher_icons`)
- [ ] **Đổi cấu trúc thư mục** feature-first (mục 5.1) — Phase 2
- [ ] `flutterfire configure` cho project `afcvn-app` (thay `google-services.json` cũ)

### Phase 2 – Foundation cho data layer *(1–2 ngày)*
- [x] Thêm `freezed` + `json_serializable` + `build_runner`.
- [x] Định nghĩa `domain/entities/*` (pure dart).
- [x] Định nghĩa `domain/repositories/*` (interface).
- [x] Thêm `core/error/failure.dart` + `Either<Failure, T>` (dùng `dartz` hoặc tự viết).
- [x] Tạo `core/network/dio_client.dart` (provider chung).
- [x] Tạo `core/services/firebase_service.dart` (wrap init, FCM).
- [x] Refactor lại `controller` chỉ depend vào `repository` interface.

### Phase 3 – Backend Firebase: News + Videos + Auth *(3–5 ngày)*
- [x] Setup project Firebase mới hoặc dùng cũ (theo Q3) – chạy `flutterfire configure` lại.
- [x] **Bật Blaze** (Q4) + đặt budget cap $5/tháng cảnh báo.
- [x] **Firestore Rules** (mục 8.4) + index theo collection.
- [x] **Auth flow**:
  - SignIn / SignUp dùng `firebase_auth`.
  - Xoá hết code token thủ công, lưu user state qua `FirebaseAuth.instance.authStateChanges()`.
  - ChangeProfile + Avatar dùng `firebase_storage`.
  - Bật lại auth gate ở `SplashScreen` (Q5).
- [x] **News module**:
  - `NewsRepository` impl với `cloud_firestore`.
  - Pagination dùng `startAfterDocument`.
  - Detail + related (query tags overlap).
  - Seed data: nhập 5–10 bài mẫu qua Firebase Console hoặc admin script.
- [x] **Videos module**: tương tự News.
- [x] **Search v1**: client-side filter (vì free tier không có full-text). Note v1.1 sẽ tích hợp Algolia.

### Phase 4 – Backend Firebase: Schedules + Live Match *(3–4 ngày)*
- [x] Setup repo `functions/` (TypeScript) trong project (hoặc folder riêng).
- [x] Implement Cloud Functions theo mục 8.3:
  - `cronFixtures`, `cronStandings`, `cronSyncPlayers`
  - `cronLiveMatchDispatcher` + `cronLiveMatch`
  - `onLiveMatchEvent` (FCM goal alert)
- [x] Setup Cloud Scheduler jobs.
- [ ] Lưu api-sports key vào Cloud Function secret (`firebase functions:secrets:set APIFOOTBALL_KEY`).
- [x] Refactor `SchedulesRepository` đọc Firestore (bỏ HTTP client phía mobile).
- [x] UI live match: tab phụ trong màn Schedules, mở chi tiết → màn live với listener realtime.
- [x] FCM topic mới: `live_match`, `result`.

### Phase 5 – Players + More + Polish *(2–3 ngày)*
- [x] Players list/detail từ Firestore.
- [x] Settings: ngôn ngữ, theme, version, rate, share, about, sign out.
- [x] Onboarding 3 pages first-launch.
- [x] Remote Config: flag bật/tắt live match, banner promo, version min.
- [x] AdMob: banner ở News list, native ad mỗi 5 item, interstitial ở detail (giới hạn 1/5min).
- [x] Crashlytics: log custom keys (userId, screen), test crash.
- [x] Analytics events: `view_news`, `view_video`, `share_news`, ...

### Phase 6 – Release *(1–2 ngày)*
- [ ] CI/CD GitHub Actions: build APK + iOS, upload Firebase App Distribution.
- [ ] Test internal track Play Store.
- [ ] Test TestFlight.
- [ ] Chuẩn bị store listing: screenshot, mô tả, privacy policy (Firestore yêu cầu).
- [ ] Submit production.

---

## 10. Bảo mật & quy ước code

### 10.1. Bảo mật

- ❌ **Không** commit `.env`, `key.properties`, keystore, `google-services.json` (chỉ commit khi cần thiết).
- ✅ Tất cả API key secret nằm trên Cloud Function secret hoặc Remote Config.
- ✅ Firestore Rules **deny by default**.
- ✅ App Check (Firebase) bật cho `Firestore`, `Functions`, `Storage`.
- ✅ Token rotation, revoke session.

### 10.2. Code style

- Tuân theo `flutter_lints: ^6.0.0` + custom rules ở `analysis_options.yaml`:
  ```yaml
  include: package:flutter_lints/flutter.yaml
  linter:
    rules:
      prefer_single_quotes: true
      avoid_print: true
      require_trailing_commas: true
      always_use_package_imports: true
  ```
- ❌ Không hardcode string UI → đưa vào `messages.dart` / ARB.
- ❌ Không hardcode màu → đưa vào `AppColors`.
- ❌ Không hardcode URL / collection name → `core/constants/firestore_paths.dart`.
- ✅ Mọi `Future` phải có error handling, log Crashlytics.
- ✅ Mọi widget public phải có `key`.

### 10.3. Git workflow

- Nhánh chính: `main` (production-ready).
- Nhánh dev: `develop`.
- Feature branch: `feat/phase-X-description`.
- 1 PR ≤ ~500 dòng diff (trừ refactor structural). Babysit PR đến khi xanh CI.

---

## 11. Acceptance Criteria & Milestone

### 11.1. Tiêu chí "Hồi sinh thành công" (end of Phase 6)

- [x] App build pass debug + release trên Android & iOS với Flutter stable mới.
- [x] Mở app từ launcher hiển thị splash mới, vào Home không crash.
- [x] News list hiển thị ít nhất 10 bài, scroll vô tận hoạt động.
- [x] Tap 1 bài → detail load, share share được.
- [x] Videos list, phát video YouTube thành công.
- [x] Schedules: xem fixture, results, standings đầy đủ — **không gọi api-football trực tiếp** (verify bằng Charles/Proxyman).
- [x] Có ít nhất 1 trận live test với polling 60s, mobile thấy update bàn thắng < 2 phút sau Cloud Function ghi.
- [x] Đăng ký + đăng nhập + đổi avatar OK.
- [x] Push notification FCM gửi tay từ console nhận được.
- [x] Crashlytics ghi nhận test crash.
- [x] Không còn `print(...)` trong release build.
- [x] `flutter analyze` 0 warning.

### 11.2. Milestone gợi ý

| Milestone | Phase | Mốc thời gian gợi ý |
|---|---|---|
| M0 – Build pass + rebrand | 0 + 1 | Tuần 1 |
| M1 – Data layer foundation | 2 | Tuần 2 |
| M2 – News + Videos + Auth chạy thật | 3 | Tuần 3–4 |
| M3 – Schedules + Live Match | 4 | Tuần 5 |
| M4 – Players + Settings + Ads | 5 | Tuần 6 |
| M5 – Release v5.0.0 | 6 | Tuần 7 |

---

## 12. Phụ lục

### 12.1. Quyết định đã chốt (2026-05-20)

| # | Câu hỏi | Trả lời |
|---|---|---|
| Q1 | Tên hiển thị app | **Gooner Vietnam** |
| Q2 | Package / bundle id | **`vn.afcvn.app`** |
| Q3 | Firebase project | **Mới: `afcvn-app`** |
| Q4 | Plan Blaze? | **Có** |
| Q5 | Auth strategy | **Reset, Firebase Auth** |
| Q6 | Nguồn nội dung | **Admin Firestore + YouTube embed** |
| Q7 | Tần suất refresh live | **60–90s khi Arsenal đang đá** |
| Q8 | State management | **Riverpod** |
| Q9 | Ngôn ngữ | **Việt + Anh** |
| Q10 | Min OS version | **Android 26 / iOS 14** |

### 12.2. Lệnh dự kiến sẽ chạy

```bash
# Phase 0
flutter clean
flutter pub get
flutter pub outdated

# Phase 1 (sau khi chốt package)
dart pub global activate rename
rename setBundleId --targets ios,android "vn.afcvn.app"
rename setAppName --targets ios,android "Gooner Vietnam"

# Phase 2
flutter pub add freezed_annotation json_annotation
flutter pub add --dev build_runner freezed json_serializable
dart run build_runner watch -d

# Phase 3
flutter pub add firebase_auth cloud_firestore firebase_storage firebase_remote_config
flutterfire configure

# Phase 4
firebase init functions
cd functions && npm install
firebase functions:secrets:set APIFOOTBALL_KEY
firebase deploy --only functions
```

### 12.3. Tham chiếu

- [Flutter migration guide 3.0 → 3.27](https://docs.flutter.dev/release/breaking-changes)
- [FlutterFire migration](https://firebase.google.com/docs/flutter/setup)
- [api-football docs](https://www.api-football.com/documentation-v3)
- [Cloud Functions for Firebase – gen 2](https://firebase.google.com/docs/functions)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

**Trạng thái:** Phase 0 đang triển khai — xem `memory-bank/activeContext.md` và `memory-bank/progress.md`.
