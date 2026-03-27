-- ============================================================
-- XƯỞNG IN TỶ PHÚ - Supabase Schema
-- Chạy file này trong Supabase SQL Editor
-- ============================================================

-- Bảng users
CREATE TABLE IF NOT EXISTS users (
  id                 BIGSERIAL PRIMARY KEY,
  telegram_id        BIGINT UNIQUE NOT NULL,
  username           TEXT,
  tele_username      TEXT DEFAULT '',
  giay_bac           NUMERIC DEFAULT 0,
  level              INT DEFAULT 1,
  session_end        BIGINT DEFAULT 0,        -- timestamp ms: khi nào phiên kết thúc
  last_mine_time     BIGINT DEFAULT 0,        -- timestamp ms: lần sync cuối
  last_video_time    BIGINT DEFAULT 0,        -- timestamp ms: lần xem video cuối
  referred_by        BIGINT DEFAULT NULL,     -- telegram_id của người giới thiệu
  joined_channels    INT[] DEFAULT '{}',      -- mảng index kênh đã join
  claimed_milestones INT[] DEFAULT '{}',      -- mảng index milestone đã nhận
  created_at         TIMESTAMPTZ DEFAULT NOW()
);

-- Index tìm kiếm nhanh
CREATE INDEX IF NOT EXISTS idx_users_telegram_id ON users(telegram_id);
CREATE INDEX IF NOT EXISTS idx_users_referred_by ON users(referred_by);

-- Bảng withdrawals (yêu cầu quy đổi)
CREATE TABLE IF NOT EXISTS withdrawals (
  id               BIGSERIAL PRIMARY KEY,
  telegram_id      BIGINT NOT NULL,
  username         TEXT,
  tele_username    TEXT,
  giay_bac_amount  NUMERIC NOT NULL,
  vnd_amount       NUMERIC NOT NULL,
  bank_name        TEXT NOT NULL,
  bank_account     TEXT NOT NULL,
  account_name     TEXT NOT NULL,
  status           TEXT DEFAULT 'pending',   -- pending | approved | rejected
  note             TEXT DEFAULT '',           -- ghi chú của admin
  created_at       TIMESTAMPTZ DEFAULT NOW(),
  processed_at     TIMESTAMPTZ DEFAULT NULL
);

CREATE INDEX IF NOT EXISTS idx_withdrawals_telegram_id ON withdrawals(telegram_id);
CREATE INDEX IF NOT EXISTS idx_withdrawals_status ON withdrawals(status);

-- Row Level Security (tuỳ chọn - nếu dùng anon key từ frontend trực tiếp)
-- Tắt RLS vì dùng service key ở backend
ALTER TABLE users DISABLE ROW LEVEL SECURITY;
ALTER TABLE withdrawals DISABLE ROW LEVEL SECURITY;
