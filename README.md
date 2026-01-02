# Nhất Tâm (Ekaggacitta)

**Nhất Tâm** là một công cụ tăng năng suất theo phong cách "không khoan nhượng" dành cho Windows, được xây dựng bằng AutoHotkey v2. Ứng dụng này dành cho những người thường xuyên tự phá vỡ quy tắc của chính mình khi sử dụng các ứng dụng hẹn giờ thông thường. Không giống như các app khác, **Nhất Tâm** ngăn chặn triệt để việc bạn tìm cách đóng ứng dụng hoặc truy cập vào các nội dung gây xao nhãng cho đến khi công việc hoàn thành.

## 🚀 Tính Năng Chính

* **Vệ Sĩ Trình Duyệt:** Tự động đóng các tab trên Chrome, Edge, Firefox và Brave nếu tiêu đề không khớp với "Từ khóa được phép" của bạn.
* **Cơ Chế Chống Gian Lận:**
* Tự động đóng **Task Manager** và **Resource Monitor** để ngăn chặn việc người dùng cố ý tắt tiến trình của ứng dụng.
* Ngăn chặn chạy nhiều bản sao (bạn không thể "reset" lại thời gian bằng cách mở lại ứng dụng lần nữa).


* **Giao Diện Luôn Hiển Thị:** Một đồng hồ đếm ngược thiết kế tinh gọn, luôn nằm trên cùng (Always on Top) để bạn dễ dàng theo dõi mà không làm gián đoạn việc gõ phím.
* **Chế Độ "Khóa Cứng" Cuối Cùng:** Khi đồng hồ về số 0, ứng dụng sẽ cưỡng chế một giai đoạn "hạ nhiệt" trong 3 phút. Trong thời gian này, mọi thao tác chuột và bàn phím sẽ bị khóa trước khi máy tính ngủ (Sleep) — đảm bảo bạn thực sự dành thời gian để nghỉ ngơi.

## Cài Đặt

1. Tải xuống `IronFocus.exe` từ trang [Releases](https://www.google.com/search?q=%23).
2. Chạy tệp thực thi.
3. **Lưu ý:** Vì script này can thiệp vào Task Manager và giám sát tiêu đề cửa sổ, các phần mềm diệt virus hoặc Windows Defender có thể nhận diện nhầm là mối đe dọa (False Positive). Bạn có thể cần thêm ứng dụng vào danh sách ngoại lệ (Exclusion) để ứng dụng hoạt động bình thường.

## 📖 Hướng Dẫn Sử Dụng

1. **Thiết Lập Thời Gian:** Nhập số phút bạn muốn tập trung làm việc sâu (deep-work).
2. **Xác Định Trang Web Cho Phép:** Nhập các từ khóa (phân tách bằng dấu phẩy) của những trang web bạn *cần* cho công việc (ví dụ: `StackOverflow, GitHub, Gmail, Google`).
3. **Làm Việc:** Đồng hồ sẽ xuất hiện ở góc dưới bên phải màn hình. Nếu bạn truy cập vào một trang web không nằm trong danh sách cho phép, tab đó sẽ bị đóng ngay lập tức.
4. **Khóa Máy Tự Động:** Sau 3 phút đếm ngược cuối cùng, máy tính sẽ tự động đi vào chế độ ngủ (Sleep/Hibernate).

## ⚠️ Cảnh Báo

Ứng dụng này được thiết kế với tính chất **xâm nhập cao** để giúp bạn giữ kỷ luật bản thân.

* Nó **SẼ** đóng Task Manager.
* Nó **SẼ** chặn mọi thao tác nhập liệu (chuột/phím) trong 3 phút đếm ngược cuối cùng.
* Hãy thận trọng nếu bạn có các công việc chưa lưu ở các ứng dụng chạy nền khác. Tuy nhiên, bạn không cần quá lo lắng vì máy tính chỉ đi vào chế độ Sleep, dữ liệu của bạn sẽ không bị mất.

## Cách Thoát Khẩn Cấp

Nếu có một nút thoát dễ dàng, bạn sẽ bấm nó ngay khi thấy chán. **Nhất Tâm** loại bỏ lựa chọn đó để buộc bạn phải hoàn thành mục tiêu.

## Yêu Cầu Hệ Thống

* Máy tính chạy Windows.
* Không cần cài đặt (Chạy trực tiếp tệp EXE).

## 📄 Bản Quyền

Phân phối dưới Giấy phép MIT. Xem tệp `LICENSE` để biết thêm thông tin.
