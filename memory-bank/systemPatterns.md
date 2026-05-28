# System Patterns

## Kiến trúc mục tiêu

```
features/ (UI + Riverpod providers)
    ↓
domain/ (entities, repository interfaces)
    ↓
data/ (repository impl, DTOs, Firestore/API)
    ↓
Firebase / Cloud Functions
```

## State management

- **Riverpod** (quyết định Q8) — `ProviderScope` ở `main.dart` (Phase 2 ✅).
- **GetX** — UI/controllers hiện tại; migrate từng feature ở Phase 3.
- Repositories inject qua `data/providers.dart` (`newsRepositoryProvider`, ...).

## Data flow bóng đá

```
Cloud Scheduler → Cloud Function → api-football → Firestore /cache/*
Mobile → Firestore snapshots() (không gọi RapidAPI)
```

## Quy ước code

- Không hardcode string UI → `l10n` / ARB (vi + en).
- Không hardcode color → `AppColors`.
- Không hardcode secret → `.env` (dev) / Cloud Function secrets (prod).
- Conventional Commits.

## Cấu trúc thư mục

Xem `PLAN.md` mục 5.1 — `lib/app`, `lib/core`, `lib/data`, `lib/domain`, `lib/features`.

## Firebase collections (chính)

- `news`, `videos`, `players`, `users`
- `cache/fixtures`, `cache/standings`, `cache/live_match/{fixtureId}`
