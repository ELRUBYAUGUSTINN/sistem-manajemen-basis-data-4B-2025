-- 1. Membuat Database dan Menggunakannya
CREATE DATABASE modul2soal2;
USE modul2soal2;

-- 2. Membuat Tabel Master
-- a. Tabel menu (Tabel Master)
CREATE TABLE menu (
    id_menu INT AUTO_INCREMENT PRIMARY KEY,
    nama_menu VARCHAR(100) NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    deskripsi TEXT,
    STATUS ENUM('tersedia', 'tidak tersedia') DEFAULT 'tersedia'
);

-- 3. Membuat Tabel Transaksi
-- a. Tabel pelanggan
CREATE TABLE pelanggan (
    id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    nama_pelanggan VARCHAR(100) NOT NULL,
    no_hp VARCHAR(15),
    alamat TEXT
);

-- b. Tabel pegawai
CREATE TABLE pegawai (
    id_pegawai INT AUTO_INCREMENT PRIMARY KEY,
    nama_pegawai VARCHAR(100) NOT NULL,
    jabatan VARCHAR(50) NOT NULL,
    no_hp VARCHAR(15)
);

-- c. Tabel pesanan
CREATE TABLE pesanan (
    id_pesanan INT AUTO_INCREMENT PRIMARY KEY,
    id_pelanggan INT,
    id_pegawai INT,
    tanggal DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status_pesanan ENUM('baru', 'diproses', 'selesai') DEFAULT 'baru',
    total_bayar DECIMAL(10,2) DEFAULT 0,
    metode_bayar VARCHAR(50),
    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan),
    FOREIGN KEY (id_pegawai) REFERENCES pegawai(id_pegawai)
);

-- d. Tabel transaksi (pengganti detail_pesanan)
CREATE TABLE transaksi (
    id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    id_pesanan INT NOT NULL,
    id_menu INT NOT NULL,
    jumlah INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pesanan) REFERENCES pesanan(id_pesanan) ON DELETE CASCADE,
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
);

-- 4. Menambahkan beberapa indeks untuk meningkatkan performa
CREATE INDEX idx_pelanggan_nama ON pelanggan(nama_pelanggan);
CREATE INDEX idx_pesanan_tanggal ON pesanan(tanggal);
CREATE INDEX idx_transaksi_menu ON transaksi(id_menu);


-- Input Data ke Tabel menu
INSERT INTO menu (nama_menu, harga, deskripsi, STATUS) VALUES
('Nasi Goreng Spesial', 25000.00, 'Nasi goreng dengan ayam dan telur', 'tersedia'),
('Mie Ayam', 18000.00, 'Mie ayam dengan pangsit dan sayur', 'tersedia'),
('Es Teh Manis', 5000.00, 'Minuman teh manis dingin', 'tersedia'),
('Jus Alpukat', 12000.00, 'Jus alpukat segar dengan susu coklat', 'tidak tersedia');

-- Input Data ke Tabel pelanggan
INSERT INTO pelanggan (nama_pelanggan, no_hp, alamat) VALUES
('Ahmad Fauzi', '081234567890', 'Jl. Merpati No. 12'),
('Siti Nurhaliza', '082233445566', 'Jl. Kenanga No. 7'),
('Rudi Hartono', '083344556677', 'Jl. Melati No. 20');

-- Input Data ke Tabel pegawai
INSERT INTO pegawai (nama_pegawai, jabatan, no_hp) VALUES
('Budi Santoso', 'Kasir', '081298765432'),
('Linda Wijaya', 'Pelayan', '082167849302');

-- Input Data ke Tabel pesanan
INSERT INTO pesanan (id_pelanggan, id_pegawai, status_pesanan, total_bayar, metode_bayar) VALUES
(1, 1, 'baru', 55000.00, 'Tunai'),
(2, 2, 'diproses', 30000.00, 'QRIS'),
(3, 1, 'selesai', 18000.00, 'Debit');

-- Input Data ke Tabel transaksi
INSERT INTO transaksi (id_pesanan, id_menu, jumlah, subtotal) VALUES
(1, 1, 2, 50000.00),
(1, 3, 1, 5000.00),
(2, 2, 1, 18000.00),
(2, 3, 1, 5000.00),
(3, 2, 1, 18000.00);

-- SOAL A – Menampilkan menu dan data pegawai yang mencatat pesanan
CREATE VIEW view_menu_dan_pegawai AS
SELECT 
    m.nama_menu,
    m.harga,
    p.nama_pegawai,
    p.jabatan
FROM menu m
JOIN transaksi t ON m.id_menu = t.id_menu
JOIN pesanan ps ON t.id_pesanan = ps.id_pesanan
JOIN pegawai p ON ps.id_pegawai = p.id_pegawai;

SELECT * FROM view_menu_dan_pegawai;

-- SOAL B – Menampilkan menu berdasarkan status (tersedia/tidak tersedia) dan harga
CREATE VIEW view_menu_status_harga AS
SELECT 
    nama_menu,
    harga,
    STATUS
FROM menu
WHERE harga >= 10000;

SELECT * FROM view_menu_status_harga;


-- SOAL C – Menampilkan pesanan yang terdiri dari lebih dari 1 menu dan subtotal per menu lebih dari 10000
CREATE OR REPLACE VIEW view_pesanan_aktif AS
SELECT 
    ps.id_pesanan,
    pel.nama_pelanggan,
    m.nama_menu,
    t.jumlah,
    t.subtotal
FROM pesanan ps
JOIN pelanggan pel ON ps.id_pelanggan = pel.id_pelanggan
JOIN transaksi t ON ps.id_pesanan = t.id_pesanan
JOIN menu m ON t.id_menu = m.id_menu
WHERE t.jumlah > 1 AND t.subtotal > 10000;

SELECT * FROM view_pesanan_aktif;


-- SOAL D – Menghitung rata-rata subtotal transaksi dari masing-masing menu
CREATE VIEW view_rata2_subtotal_per_menu AS
SELECT 
    m.nama_menu,
    AVG(t.subtotal) AS rata_rata_subtotal
FROM menu m
JOIN transaksi t ON m.id_menu = t.id_menu
GROUP BY m.id_menu;

SELECT * FROM view_rata2_subtotal_per_menu;


-- SOAL E – Mengelompokkan dan menghitung jumlah pesanan berdasarkan status pesanan dan metode bayar
CREATE VIEW view_total_pesanan_status_metode AS
SELECT 
    status_pesanan,
    metode_bayar,
    COUNT(id_pesanan) AS total_pesanan
FROM pesanan
GROUP BY status_pesanan, metode_bayar;

SELECT * FROM view_total_pesanan_status_metode;

-- Total subtotal per pesanan
CREATE VIEW view_total_subtotal_per_pesanan AS
SELECT 
    ps.id_pesanan,
    pel.nama_pelanggan,
    SUM(t.subtotal) AS total_bayar
FROM pesanan ps
JOIN pelanggan pel ON ps.id_pelanggan = pel.id_pelanggan
JOIN transaksi t ON ps.id_pesanan = t.id_pesanan
GROUP BY ps.id_pesanan;

SELECT * FROM view_total_subtotal_per_pesanan;

-- Menu dengan harga tertinggi dan terendah
CREATE VIEW view_menu_termahal_termurah AS
SELECT 
    MIN(harga) AS harga_menu_termurah,
    MAX(harga) AS harga_menu_termahal
FROM menu;

SELECT * FROM view_menu_termahal_termurah;
