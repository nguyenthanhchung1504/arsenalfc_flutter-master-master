# Project Brief — Gooner Vietnam

## Tổng quan

Ứng dụng mobile Flutter phục vụ cộng đồng fan Arsenal tại Việt Nam (AFCVN). Tên thương mại mới: **Gooner Vietnam**.

## Mục tiêu

1. Hồi sinh app sau khi backend cũ (`api.afcvn.website`) ngừng hoạt động.
2. Backend mới trên Firebase (`afcvn-app`, Blaze).
3. Dữ liệu bóng đá qua api-football, cache bằng Cloud Functions (mobile không gọi trực tiếp).
4. Release v5.0.0 lên Play Store / App Store.

## Phạm vi v1

- Tin tức + Video (Firestore + YouTube)
- Lịch thi đấu, kết quả, BXH, live match (Firestore cache)
- Auth Firebase (reset user cũ)
- Việt + Anh, Riverpod, min Android 26 / iOS 14

## Package & định danh

| Thuộc tính | Giá trị |
|---|---|
| Display name | Gooner Vietnam |
| applicationId / bundleId | `vn.afcvn.app` |
| Firebase project | `afcvn-app` |

## Tài liệu tham chiếu

- Kế hoạch chi tiết: [`PLAN.md`](../PLAN.md)
