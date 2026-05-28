# Tech Context

## Stack

| Layer | Công nghệ |
|---|---|
| Mobile | Flutter 3.27+ stable, Dart 3.5+ |
| State | Riverpod 2.x |
| Backend | Firebase Auth, Firestore, Storage, FCM, Crashlytics, Remote Config |
| Serverless | Cloud Functions (TypeScript gen 2), Cloud Scheduler |
| Football API | **TheSportsDB** (`https://www.thesportsdb.com/api/v1/json/3`) — key `3` public free; gói free BXH top 5, Patreon ~$3 mở full 20 đội |
| Ads | google_mobile_ads |
| HTTP (legacy tạm) | dio |

## Native

| Platform | Min | Build |
|---|---|---|
| Android | API 26 | AGP 8.10, Kotlin 2.2, Gradle 8.11 |
| iOS | 14.0 | Xcode (cần verify) |

## Package id

- `vn.afcvn.app`

## Firebase

- Project mới: **`afcvn-app`**
- Plan: **Blaze** (budget alert $1/tháng)

## Dev setup

```bash
flutter pub get
cp .env.example .env   # điền key local nếu test (không commit .env)
flutter run
```

## Lưu ý

- SDK cũ `>=2.16.1` đã bump Phase 0 → `>=3.5.0`.
- api-sports key đã chuyển khỏi source, chỉ còn ở `.env` local (gitignored).
- Tab lịch thi đấu: production sẽ đọc Firestore cache (Phase 4); debug có thể gọi trực tiếp khi `.env` có key.
