# Product Context

## Vì sao app tồn tại

Fan Arsenal Việt Nam cần một hub tập trung: tin AFCVN, video highlight, lịch & kết quả Arsenal, BXH Ngoại hạng Anh, thông báo trận đấu — thay vì rải rác Facebook / web lẻ.

## Trải nghiệm mong muốn

- Mở app → tin mới nhất, lịch trận sắp tới.
- Ngày có trận → tab lịch thi đấu cập nhật diễn biến gần realtime (60–90s qua Firestore listener).
- Video embed YouTube, không host video nặng.
- Đăng nhập tùy chọn cho tương lai (comment v1.1); v1 có thể xem nội dung không cần login.

## Đối tượng

- Fan Arsenal tại VN, ưu tiên tiếng Việt, hỗ trợ tiếng Anh.

## Nội dung

- **News:** admin đăng qua Firestore (sau này web admin).
- **Video:** bài admin + link YouTube.
- **Football data:** api-football free, proxy qua Cloud Functions.

## Không làm trong v1

Forum, bán hàng, crawl arsenal.com, macOS/desktop.
