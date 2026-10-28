
CREATE DATABASE IF NOT EXISTS bank_sampah_digital;
USE bank_sampah_digital;

-- 1. Tabel Pengguna (Supertype)
CREATE TABLE pengguna (
    id_pengguna INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    no_hp VARCHAR(15) NOT NULL,
    password VARCHAR(255) NOT NULL,
    alamat VARCHAR(255) NOT NULL
);

-- 2. Tabel Nasabah (Subtype dari Pengguna)
CREATE TABLE nasabah (
    id_pengguna INT PRIMARY KEY,
    saldo DECIMAL(12,2) DEFAULT 0.00,
    FOREIGN KEY (id_pengguna) REFERENCES pengguna(id_pengguna) ON DELETE CASCADE
);

-- 3. Tabel Petugas (Subtype dari Pengguna)
CREATE TABLE petugas (
    id_pengguna INT PRIMARY KEY,
    status_petugas VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_pengguna) REFERENCES pengguna(id_pengguna) ON DELETE CASCADE
);

-- 4. Tabel Pengurus Admin (Subtype dari Pengguna)
CREATE TABLE pengurus_admin (
    id_pengguna INT PRIMARY KEY,
    hak_akses VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_pengguna) REFERENCES pengguna(id_pengguna) ON DELETE CASCADE
);

-- 5. Tabel Laporan (Rekapitulasi Periodik)
CREATE TABLE laporan (
    id_laporan INT AUTO_INCREMENT PRIMARY KEY,
    periode VARCHAR(20) NOT NULL,
    total_volume DECIMAL(12,2) DEFAULT 0.00,
    rekap_kas DECIMAL(14,2) DEFAULT 0.00
);

-- 6. Tabel Jenis Sampah
CREATE TABLE jenis_sampah (
    id_sampah INT AUTO_INCREMENT PRIMARY KEY,
    nama_jenis VARCHAR(50) NOT NULL,
    satuan VARCHAR(10) NOT NULL
);

-- 7. Tabel Harga Sampah
CREATE TABLE harga_sampah (
    id_harga INT AUTO_INCREMENT PRIMARY KEY,
    id_sampah INT NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    tanggal_berlaku DATE NOT NULL,
    FOREIGN KEY (id_sampah) REFERENCES jenis_sampah(id_sampah) ON DELETE CASCADE
);

-- 8. Tabel Setoran Transaksi Sampah
CREATE TABLE setoran (
    id_setoran INT AUTO_INCREMENT PRIMARY KEY,
    id_harga INT NOT NULL,
    id_petugas INT NOT NULL,
    id_nasabah INT NOT NULL,
    id_laporan INT,
    berat DECIMAL(8,2) NOT NULL,
    harga_setoran DECIMAL(10,2) NOT NULL,
    total DECIMAL(12,2) NOT NULL,
    tanggal_setoran DATE NOT NULL,
    FOREIGN KEY (id_harga) REFERENCES harga_sampah(id_harga),
    FOREIGN KEY (id_petugas) REFERENCES petugas(id_pengguna),
    FOREIGN KEY (id_nasabah) REFERENCES nasabah(id_pengguna),
    FOREIGN KEY (id_laporan) REFERENCES laporan(id_laporan) ON DELETE SET NULL
);

-- 9. Tabel Request Penjemputan Sampah
CREATE TABLE request_penjemputan (
    id_request INT AUTO_INCREMENT PRIMARY KEY,
    id_nasabah INT NOT NULL,
    tanggal_request DATE NOT NULL,
    status_request VARCHAR(20) NOT NULL,
    latitude DECIMAL(10,7),
    longitude DECIMAL(10,7),
    FOREIGN KEY (id_nasabah) REFERENCES nasabah(id_pengguna) ON DELETE CASCADE
);

-- 10. Tabel Penarikan Saldo Nasabah
CREATE TABLE penarikan (
    id_penarikan INT AUTO_INCREMENT PRIMARY KEY,
    id_nasabah INT NOT NULL,
    id_laporan INT,
    jumlah DECIMAL(12,2) NOT NULL,
    saldo_sisa DECIMAL(12,2) NOT NULL,
    tanggal_penarikan DATE NOT NULL,
    FOREIGN KEY (id_nasabah) REFERENCES nasabah(id_pengguna),
    FOREIGN KEY (id_laporan) REFERENCES laporan(id_laporan) ON DELETE SET NULL
);

-- Pembuatan Index untuk Optimasi Performa Kueri Tabel Setoran
CREATE INDEX idx_petugas ON setoran(id_petugas);
CREATE INDEX idx_tanggal_setoran ON setoran(tanggal_setoran);
