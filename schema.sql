PRAGMA foreign_keys = ON;
CREATE TABLE IF NOT EXISTS users (
  id TEXT PRIMARY KEY, name TEXT NOT NULL, username TEXT NOT NULL UNIQUE, email TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL, role TEXT NOT NULL DEFAULT 'owner', active INTEGER NOT NULL DEFAULT 1,
  must_change_password INTEGER NOT NULL DEFAULT 1, created_at TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS businesses (
  id TEXT PRIMARY KEY, owner_user_id TEXT NOT NULL, name TEXT NOT NULL, slug TEXT NOT NULL UNIQUE,
  niche TEXT DEFAULT 'Serviços', phone TEXT DEFAULT '', color TEXT DEFAULT '#6D5DFB', logo TEXT DEFAULT '',
  plan TEXT DEFAULT 'Básico', timezone TEXT DEFAULT 'America/Sao_Paulo', reminder_hours INTEGER DEFAULT 24,
  cancel_hours INTEGER DEFAULT 4, interval_minutes INTEGER DEFAULT 0, require_confirmation INTEGER DEFAULT 0,
  created_at TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS memberships (user_id TEXT NOT NULL,business_id TEXT NOT NULL,role TEXT NOT NULL DEFAULT 'owner',PRIMARY KEY(user_id,business_id));
CREATE TABLE IF NOT EXISTS sessions (token_hash TEXT PRIMARY KEY,user_id TEXT NOT NULL,expires_at TEXT NOT NULL,created_at TEXT NOT NULL);
CREATE TABLE IF NOT EXISTS services (id TEXT PRIMARY KEY,business_id TEXT NOT NULL,name TEXT NOT NULL,duration INTEGER NOT NULL DEFAULT 60,price REAL NOT NULL DEFAULT 0,active INTEGER NOT NULL DEFAULT 1,created_at TEXT NOT NULL);
CREATE TABLE IF NOT EXISTS professionals (id TEXT PRIMARY KEY,business_id TEXT NOT NULL,name TEXT NOT NULL,email TEXT DEFAULT '',phone TEXT DEFAULT '',commission REAL NOT NULL DEFAULT 0,active INTEGER NOT NULL DEFAULT 1,created_at TEXT NOT NULL);
CREATE TABLE IF NOT EXISTS clients (id TEXT PRIMARY KEY,business_id TEXT NOT NULL,name TEXT NOT NULL,phone TEXT DEFAULT '',email TEXT DEFAULT '',notes TEXT DEFAULT '',created_at TEXT NOT NULL);
CREATE TABLE IF NOT EXISTS appointments (id TEXT PRIMARY KEY,business_id TEXT NOT NULL,client_id TEXT,client_name TEXT NOT NULL,client_phone TEXT DEFAULT '',service_id TEXT,service_name TEXT NOT NULL,professional_id TEXT,professional_name TEXT DEFAULT '',date TEXT NOT NULL,time TEXT NOT NULL,price REAL NOT NULL DEFAULT 0,status TEXT NOT NULL DEFAULT 'pendente',notes TEXT DEFAULT '',source TEXT DEFAULT 'painel',google_event_id TEXT DEFAULT '',created_at TEXT NOT NULL);
CREATE TABLE IF NOT EXISTS products (id TEXT PRIMARY KEY,business_id TEXT NOT NULL,name TEXT NOT NULL,price REAL NOT NULL DEFAULT 0,stock INTEGER NOT NULL DEFAULT 0,active INTEGER NOT NULL DEFAULT 1,created_at TEXT NOT NULL);
CREATE TABLE IF NOT EXISTS expenses (id TEXT PRIMARY KEY,business_id TEXT NOT NULL,description TEXT NOT NULL,amount REAL NOT NULL DEFAULT 0,date TEXT NOT NULL,created_at TEXT NOT NULL);
CREATE TABLE IF NOT EXISTS google_tokens (business_id TEXT PRIMARY KEY,access_token TEXT NOT NULL,refresh_token TEXT DEFAULT '',expires_at INTEGER NOT NULL DEFAULT 0,scope TEXT DEFAULT '',updated_at TEXT NOT NULL);
CREATE TABLE IF NOT EXISTS orders (
  id TEXT PRIMARY KEY, lookup_token TEXT NOT NULL, name TEXT NOT NULL, business_name TEXT NOT NULL,
  niche TEXT DEFAULT 'Serviços', email TEXT NOT NULL, phone TEXT NOT NULL, plan TEXT NOT NULL,
  amount REAL NOT NULL, status TEXT NOT NULL DEFAULT 'pendente', paid_at TEXT, user_id TEXT,
  credentials_cipher TEXT DEFAULT '', created_at TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS system_settings (key TEXT PRIMARY KEY,value TEXT NOT NULL,updated_at TEXT NOT NULL);
CREATE INDEX IF NOT EXISTS idx_appointments_business_date ON appointments(business_id,date,time);
CREATE INDEX IF NOT EXISTS idx_clients_business_phone ON clients(business_id,phone);
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(status,created_at);
CREATE INDEX IF NOT EXISTS idx_sessions_user ON sessions(user_id);
CREATE UNIQUE INDEX IF NOT EXISTS idx_one_booking_slot ON appointments(business_id,date,time) WHERE status<>'cancelado';
INSERT OR IGNORE INTO system_settings(key,value,updated_at) VALUES
('brand','AgendaX',CURRENT_TIMESTAMP),
('price_basic','19.90',CURRENT_TIMESTAMP),
('price_pro','39.90',CURRENT_TIMESTAMP),
('price_business','69.90',CURRENT_TIMESTAMP),
('pix_key','',CURRENT_TIMESTAMP),
('pix_holder','',CURRENT_TIMESTAMP),
('support_whatsapp','',CURRENT_TIMESTAMP);
CREATE TABLE IF NOT EXISTS oauth_states (state TEXT PRIMARY KEY,user_id TEXT NOT NULL,business_id TEXT NOT NULL,expires_at TEXT NOT NULL);
