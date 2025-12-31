-- DROP SCHEMA IF EXISTS public CASCADE;
-- CREATE SCHEMA public;

-- ==========================================
-- 1. Users Table
-- ==========================================
CREATE TABLE IF NOT EXISTS public.users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    fullname VARCHAR(255),
    role VARCHAR(50) NOT NULL DEFAULT 'CLIENT', -- Storing Enum as String
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 2. Categories Table
-- ==========================================
CREATE TABLE IF NOT EXISTS public.categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 3. Products Table
-- ==========================================
CREATE TABLE IF NOT EXISTS public.products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT,
    image_path VARCHAR(255),
    category_id INTEGER REFERENCES categories(id) ON DELETE SET NULL, -- Foreign Key
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 4. Promotions Table
-- ==========================================
CREATE TABLE IF NOT EXISTS public.promotions (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL, -- 'percentage' or 'fixed'
    value DECIMAL(10, 2) NOT NULL,
    description TEXT,
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    product_id INTEGER REFERENCES products(id) ON DELETE CASCADE, -- Promotion linked to a product (optional)
    category_id INTEGER REFERENCES categories(id) ON DELETE CASCADE, -- Promotion linked to a category (optional)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- Seed Data
-- ==========================================

-- Users
INSERT INTO public.users (email, password, fullname, role) VALUES 
('admin@techstore.com', 'admin123', 'Admin Sys', 'ADMIN'),
('client@techstore.com', 'client123', 'John Doe', 'CLIENT')
ON CONFLICT (email) DO NOTHING;

-- Categories
INSERT INTO public.categories (name, description) VALUES 
('Smartphones', 'Mobile phones and accessories'),
('Laptops', 'High performance computers'),
('Audio', 'Headphones and speakers')
ON CONFLICT (name) DO NOTHING;

-- Products (Assuming serial IDs 1, 2, 3...)
INSERT INTO public.products (name, price, description, image_path, category_id) VALUES 
('iPhone 15', 999.99, 'Latest Apple Smartphone', 'assets/img/iphone15.jpg', 1),
('Samsung Galaxy S24', 899.99, 'Android Flagship', 'assets/img/s24.jpg', 1),
('MacBook Pro', 1999.99, 'M3 Chip Laptop', 'assets/img/macbook.jpg', 2)
ON CONFLICT DO NOTHING;
