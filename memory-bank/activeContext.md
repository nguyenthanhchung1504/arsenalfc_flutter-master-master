# Active Context

## Trạng thái (Phase 4 — đã có data mùa 2025-26)

**Phase 4** chuyển nguồn từ api-football (gói free chỉ tới 2024) sang **TheSportsDB**. Cache mùa **2025-2026** đã seed vào Firestore.

## Việc vừa hoàn thành

- [x] Refactor `functions/` dùng TheSportsDB (xoá `apiFootball.ts`, thêm `thesportsdb.ts`)
- [x] `cache.ts`: lặp `eventsround.php` 1–38 + `lookuptable.php` + fallback live qua `eventsnext.php`
- [x] `FootballConstants`: id Arsenal `133604`, league `4328`, season `"2025-2026"`
- [x] `scripts/seed_football_cache.py`: retry 429, delay 1s/round, đăng nhập firebase token
- [x] Seed Firestore: **37 fixtures + 5 standings** mùa hiện tại
- [x] `PHASE4_SETUP.md` rewrite

## Việc tiếp theo

1. (Tuỳ chọn) Nâng Patreon TheSportsDB $3/tháng để có **full 20 đội BXH** và live score
2. Deploy Cloud Functions sau khi cài Node 20+ trên máy
3. Phase 5: Players, polish UI, AdMob

## Lưu ý

- Free key `3` rate-limit ~30 req/phút; script seed retry backoff 5/10/15s
- App Flutter giữ schema `cache/*` snake_case → không phải sửa repository khi đổi nguồn
- Token Firebase CLI: `firebase login:list` → `nguyenthanhchung1504@gmail.com`
