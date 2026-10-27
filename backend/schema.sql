CREATE TABLE IF NOT EXISTS customers(id SERIAL PRIMARY KEY,name TEXT NOT NULL,email TEXT UNIQUE NOT NULL,phone TEXT,password_hash TEXT NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT now());
CREATE TABLE IF NOT EXISTS barbers(id SERIAL PRIMARY KEY,name TEXT NOT NULL,shop_name TEXT NOT NULL,area TEXT,email TEXT UNIQUE NOT NULL,phone TEXT,password_hash TEXT NOT NULL,lat DOUBLE PRECISION,lng DOUBLE PRECISION,active BOOLEAN NOT NULL DEFAULT true,created_at TIMESTAMPTZ NOT NULL DEFAULT now());
CREATE TABLE IF NOT EXISTS admins(id SERIAL PRIMARY KEY,email TEXT UNIQUE NOT NULL,password_hash TEXT NOT NULL);
CREATE TABLE IF NOT EXISTS services(id SERIAL PRIMARY KEY,barber_id INT NOT NULL REFERENCES barbers(id) ON DELETE CASCADE,name TEXT NOT NULL,price INT NOT NULL CHECK(price>0),minutes INT NOT NULL DEFAULT 30 CHECK(minutes>0));
CREATE TABLE IF NOT EXISTS orders(id SERIAL PRIMARY KEY,customer_id INT NOT NULL REFERENCES customers(id),barber_id INT NOT NULL REFERENCES barbers(id),slot_start TIMESTAMPTZ NOT NULL,status TEXT NOT NULL DEFAULT 'booked' CHECK(status IN('booked','done','cancelled')),total INT NOT NULL,items JSONB NOT NULL,code CHAR(4) NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT now());
-- Race-condition guard: the database itself refuses a second active order for the same barber and slot.
CREATE UNIQUE INDEX IF NOT EXISTS one_active_order_per_slot ON orders(barber_id,slot_start) WHERE status<>'cancelled';
CREATE INDEX IF NOT EXISTS orders_customer_idx ON orders(customer_id);
CREATE INDEX IF NOT EXISTS orders_barber_idx ON orders(barber_id,slot_start);
