# Progress

## Đã hoạt động

- UI 4 tab; News + Videos tab Riverpod + Firestore
- Firebase project **`afcvn-app`** — config app đã trỏ đúng
- Firestore rules deployed; 3 bài news + 1 video seed
- Android build debug ✅

## Roadmap

| Phase | Mô tả | Trạng thái |
|---|---|---|
| 0–2 | Nền tảng, rebrand, data layer | ✅ Done |
| 3 | Firebase News/Video/Auth | ✅ ~95% — còn polish search news, change profile |
| 4 | Cloud Functions + schedules | ⏳ Pending |
| 5–6 | Polish, release | ⏳ Pending |

## Known issues

- Auth Email/Password chưa bật qua API (CONFIGURATION_NOT_FOUND) — bật tay Console
- iOS `flutterfire configure` lỗi thiếu gem `xcodeproj` — đã cập nhật plist/options thủ công
- Blaze chưa bật (user)

## Milestone

- **M1**: News từ Firestore trên thiết bị — sẵn sàng test sau khi bật Auth (tuỳ chọn)
