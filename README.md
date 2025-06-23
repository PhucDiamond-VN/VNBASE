# 🇻🇳 Dự Án Gamemode SAMP/OMP Việt Nam  
### *Vietnamese SAMP/OMP Gamemode Project*
![VNBASE-PROJECT](https://github.com/PhucDiamond-VN/VNBASE/blob/main/VNBASE.png)
---

## 🌟 Giới thiệu | Introduction

Đây là một **dự án mã nguồn mở phi lợi nhuận** nhằm xây dựng một **gamemode nền tảng** dành riêng cho cộng đồng **GTA San Andreas Multiplayer (SAMP/OPEN.MP)** tại Việt Nam.  
Phần lớn server hiện tại ở Việt Nam đang sử dụng các gamemode lỗi thời hoặc nhiều lỗi từ nước ngoài, gây khó khăn trong việc phát triển và học hỏi.

Dự án ra đời để tạo một môi trường **sạch, dễ mở rộng, dễ học hỏi** và **khuyến khích sự đóng góp lâu dài** từ các lập trình viên Việt Nam.

> This is a **non-profit open-source project** designed to build a **base gamemode** for the **Vietnamese SAMP/OPEN.MP community**.  
> Most servers in Vietnam use outdated or buggy foreign gamemodes, making development and learning difficult.  
> This project aims to create a **clean, extensible, and community-driven** environment for Vietnamese developers to learn, grow, and contribute.

---

## 🎯 Mục Tiêu Chính | Main Objectives

- ✅ **Tạo gamemode cơ bản, dễ tùy biến**  
   *Build a clean and customizable base gamemode*
- ✅ **Chia sẻ mã nguồn mở, minh bạch**  
   *Open-source and transparent development*
- ✅ **Xây dựng cộng đồng lập trình SAMP/OMP Việt**  
   *Foster a Vietnamese SAMP/OMP dev community*
- ✅ **Khuyến khích học hỏi và hợp tác phát triển**  
   *Encourage learning and collaboration*

---

## 🔧 Công Nghệ Sử Dụng | Technologies Used

- **Ngôn ngữ / Language:** `PAWN (Qawno)`
- **Server:** `SAMP Dedicated Server` / `OPEN.MP`
- **Plugins:**  
  `streamer`, `sscanf`, `pawncmd`, `mysql`, `crashdetect`, `requests`,  
  `PawnPlus`, `ColAndreas`, `discord-connector`, `json`, `pawnregex`,  
  `pawn-memory`, `Whirlpool`
- **Hệ điều hành hỗ trợ / Supported OS:** `Windows`

---

## 🚀 Bắt Đầu Sử Dụng | Getting Started

### 🔽 Bước 1: Tải mã nguồn  
📦 Clone repository:
```bash
git clone https://github.com/PhucDiamond-VN/VNBASE.git
```
---

### 🛠️ Bước 2: Cài đặt XAMPP & MySQL

1. Truy cập: https://www.apachefriends.org/index.html  
2. Tải và cài đặt phiên bản XAMPP phù hợp với hệ điều hành.
3. Mở **XAMPP Control Panel** và khởi động:
   - `Apache`
   - `MySQL`

⚠️ *Nếu MySQL không khởi động, hãy kiểm tra cổng `3306` có bị ứng dụng khác chiếm (Skype, Workbench...).*

---

### 🧱 Bước 3: Tạo Cơ Sở Dữ Liệu `VNBASE`

1. Truy cập: http://localhost/phpmyadmin  
2. Chọn tab **Cơ sở dữ liệu / Databases**
3. Nhập tên: `VNBASE`  
4. Nhấn **Tạo / Create**

---

### 🧵 Bước 4: Compile & Chạy Server

1. Mở file `.pwn` bằng **PAWN Compiler**, **VSCode**, hoặc **Sublime Text**  
2. Compile để tạo file `.amx`
3. Chạy server bằng: `omp-server` *(OPEN.MP)*

---

## 💬 Đóng Góp & Liên Hệ | Contribute & Contact

- Mọi đóng góp đều được hoan nghênh! Hãy tạo Pull Request hoặc Issue nếu bạn có ý tưởng, cải tiến hoặc tìm thấy bug.
- Tham gia cộng đồng tại:  
  📌 *[Discord]* *(https://discord.gg/uxuuh8bX4Y)*
- Liên hệ qua GitHub: [@PhucDiamond-VN](https://github.com/PhucDiamond-VN)

---

## 📄 Giấy Phép | License

Dự án sử dụng **Apache License**  
Bạn có thể tự do sử dụng, sửa đổi, và phân phối lại – miễn là ghi rõ nguồn và giữ bản quyền gốc.

---

## 📸 Ảnh Màn Hình | Screenshots

- **Door system**
![VNBASE-PROJECT](https://github.com/PhucDiamond-VN/VNBASE/blob/main/System-Image/doorcommand.png)
![VNBASE-PROJECT](https://github.com/PhucDiamond-VN/VNBASE/blob/main/System-Image/door.png)
- **Splash Screen & Teleport system**
![VNBASE-PROJECT](https://github.com/PhucDiamond-VN/VNBASE/blob/main/System-Image/SplashScreen.gif)

---

## 🗓️ Lịch Sử Cập Nhật | Changelog

- **v1.0** – Phát hành bản đầu tiên  
- **v2.0** – Door, Teleport, SplashScreen - Update

---

## 🙌 Ghi Công | Credits

- Cộng đồng SAMP Việt Nam
- Các tác giả plugin PAWN
- OPEN.MP Team
