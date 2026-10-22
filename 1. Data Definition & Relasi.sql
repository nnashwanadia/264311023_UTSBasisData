CREATE TABLE nasabah (
    id_nasabah INT AUTO_INCREMENT PRIMARY KEY,
    nama_nasabah VARCHAR(100) NOT NULL,
    alamat TEXT,
    no_telepon VARCHAR(15)
) ENGINE=InnoDB;

CREATE TABLE harga_sampah (
    id_harga INT AUTO_INCREMENT PRIMARY KEY,
    nama_sampah VARCHAR(100) NOT NULL,
    harga_per_kg DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE setoran (
    id_setoran INT AUTO_INCREMENT PRIMARY KEY,
    id_nasabah INT NOT NULL,
    id_harga INT NOT NULL,
    berat DECIMAL(8,2) NOT NULL,
    total DECIMAL(12,2) NOT NULL,
    tanggal_setoran DATE NOT NULL,

    FOREIGN KEY (id_nasabah)
        REFERENCES nasabah(id_nasabah),

    FOREIGN KEY (id_harga)
        REFERENCES harga_sampah(id_harga)
) ENGINE=InnoDB;
