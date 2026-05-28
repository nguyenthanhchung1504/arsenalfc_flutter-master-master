# Firebase Setup — Gooner Vietnam

Project: **`afcvn-app`** · Package: **`vn.afcvn.app`**

## 1. Tạo project & bật dịch vụ

> **Đã setup (2026-05-21):** Project `afcvn-app`, Firestore `(default)` tại `asia-southeast1`, rules deployed, 3 bài `news` + 1 `videos` seed.

1. [Firebase Console](https://console.firebase.google.com/project/afcvn-app/overview) — project **`afcvn-app`** ✅
2. Bật **Blaze** (cần cho Cloud Functions Phase 4) — *bạn bật tay trên Console*
3. Enable:
   - Authentication → **Email/Password** — *bật tay: Authentication → Sign-in method*
   - Firestore ✅
   - Storage (cho avatar Phase 3+) — *tuỳ chọn*

## 2. Thêm app Android / iOS

| Platform | Package / Bundle ID |
|---|---|
| Android | `vn.afcvn.app` |
| iOS | `vn.afcvn.app` |

## 3. FlutterFire configure

```bash
dart pub global activate flutterfire_cli
flutterfire configure --project=afcvn-app
```

Chọn Android + iOS. File được tạo/cập nhật:

- `lib/firebase_options.dart`
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

## 4. Deploy Firestore Rules

```bash
firebase login
firebase init firestore   # chọn project afcvn-app
firebase deploy --only firestore:rules
```

Rules mẫu: [`firestore.rules`](firestore.rules)

## 5. Firestore Indexes (nếu cần)

Collection `news` query:

- `published_at` DESC
- `tags` array-contains + `published_at` DESC (related news)

Firebase Console sẽ gợi ý link tạo index khi query lần đầu fail.

## 6. Seed dữ liệu mẫu (News)

Firebase Console → Firestore → collection **`news`** → Add document (Auto-ID):

| Field | Type | Ví dụ |
|---|---|---|
| `title` | string | Arsenal thắng đậm ở Emirates |
| `slug` | string | arsenal-thang-emirates |
| `thumbnail_url` | string | https://... |
| `excerpt` | string | Tóm tắt ngắn... |
| `content_html` | string | `<p>Nội dung HTML...</p>` |
| `tags` | array | `["arsenal", "premier-league"]` |
| `published_at` | timestamp | now |
| `view_count` | number | 0 |

Thêm **ít nhất 3 bài** để test list + featured + pagination.

## 7. Tạo user admin (tuỳ chọn)

1. Auth → Add user (email/password)
2. Firestore → `users/{uid}` → `{ "role": "admin", "email": "..." }`

## 8. Chạy app

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Tab **Tin tức** đọc từ Firestore qua `FirestoreNewsRepository`.
