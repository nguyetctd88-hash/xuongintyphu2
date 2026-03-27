# 🏭 Xưởng In Tỷ Phú

Telegram Mini App Bot - Mô phỏng xưởng in tiền, kiếm Giấy Bạc và quy đổi phần thưởng.

## Cấu trúc

```
xuong-in-typhu/
├── server.js              # Backend (Express + Telegram Bot)
├── package.json
├── .env.example           # Mẫu biến môi trường
├── supabase_schema.sql    # Schema database Supabase
└── webapp/
    └── index.html         # Frontend Telegram Mini App
```

## Đầu tiên
1. Vào botfather tạo bot và lấy token. 

## Cách deploy

### 1. Chuẩn bị Supabase
1. Tạo project tại https://supabase.com
2. Vào SQL Editor, chạy nội dung file `supabase_schema.sql`
3. Lấy Project URL và anon key từ Settings → API

### 2. Deploy Webapp (Vercel)
1. Upload thư mục `webapp/` lên GitHub
2. Import vào Vercel, deploy
3. Ghi lại URL webapp (vd: `https://xuong-in-typhu.vercel.app`)

### 3. Deploy Server (Railway)
1. Upload toàn bộ project lên GitHub
2. Tạo project mới trên Railway, kết nối repo
3. Thêm các biến môi trường (xem `.env.example`):
   - `TOKEN` = Telegram Bot Token
   - `BOT_USERNAME` = `xuongintyphu_bot`
   - `SUPABASE_URL` = URL Supabase
   - `SUPABASE_KEY` = anon key Supabase
   - `WEBAPP_URL` = URL webapp vừa deploy
   - `ADMIN_CHAT_ID` = Telegram ID của bạn (nhận thông báo rút tiền)

### 4. Cấu hình Bot Telegram
1. Nhắn @BotFather: `/setdomain` → chọn bot → nhập domain webapp
2. Bật inline mode nếu cần

## Tích hợp Monetag (Video Ads)
Khi có zone ID từ Monetag:
1. Mở `webapp/index.html`
2. Tìm comment `// TODO: Tích hợp Monetag SDK`
3. Thay phần giả lập bằng SDK thực:
```js
// Thêm vào <head>:
<script src='//libtl.com/sdk.js' data-zone='YOUR_ZONE_ID' data-sdk='show_YOUR_ZONE_ID'></script>

// Thay trong hàm watchVideo():
window['show_YOUR_ZONE_ID']?.();
```

## Kênh Telegram
Cập nhật ID kênh thực trong `server.js`:
```js
const CHANNELS = [
  { id: '@TenKenh1', name: 'Tên Kênh 1', reward: 10000 },
  { id: '@TenKenh2', name: 'Tên Kênh 2', reward: 10000 }
];
```

## Tỷ lệ quy đổi
- 20,000,000 Giấy Bạc = 2,000 VND
- Tối thiểu rút: 20,000,000 Giấy Bạc
- Admin xử lý thủ công, nhận thông báo qua Telegram
## Sửa tỉ lệ đào, giá,... trong index.html

## Database Tables
- `users`: thông tin user, số dư, level, session
- `withdrawals`: yêu cầu quy đổi (admin duyệt thủ công)


