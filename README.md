# Advanced Mobile Calculator 🧮

## Project Description
Đây là ứng dụng máy tính nâng cao được xây dựng bằng Flutter, hỗ trợ 3 chế độ: Basic, Scientific và Programmer. Ứng dụng tích hợp quản lý trạng thái phức tạp, phân tích biểu thức toán học và lưu trữ dữ liệu cục bộ.

## Features
- 3 Chế độ: Basic, Scientific, Programmer.
- Xử lý toán học phức tạp (PEMDAS, Lượng giác, Logarit, Bộ nhớ).
- Lưu trữ lịch sử tính toán (Tối đa 50 phép tính).
- Hỗ trợ Light / Dark Mode.

## Screenshots
basic mode
<img width="1920" height="1080" alt="Screenshot 2026-04-19 152444" src="https://github.com/user-attachments/assets/02d0e377-7cb6-412e-b5e6-06d689041c88" />
scientific mode
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/68276e06-8188-4027-bb9c-3c8a6c74e5d6" />
programmer mode
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/5fb5706b-095f-40b3-a46d-2631fb8e139d" />

## Architecture Diagram
Dự án sử dụng Clean Architecture kết hợp với Provider State Management.

## Setup Instructions
1. Clone repository này về máy.
2. Chạy lệnh `flutter pub get` để tải các thư viện.
3. Chạy `flutter run` để khởi chạy ứng dụng.

## Testing Instructions
Chạy lệnh `flutter test` để chạy các Unit Test kiểm tra logic toán học.

## Known Limitations & Future Improvements
- **Hạn chế:** Chế độ Programmer chưa hỗ trợ tính toán số Hex quá lớn.
- **Tương lai:** Bổ sung vẽ đồ thị hàm số và hỗ trợ xoay màn hình ngang (Landscape mode).
