INSERT INTO nasabah (nama_nasabah, alamat, no_telepon) VALUES
('Loki Friggason', 'Madiun', '083117678815'),
('Thor Odinson', 'Magelang', '085235685077'),
('Hela Odindottir', 'Malang', '081234567803');

INSERT INTO harga_sampah (id_harga, nama_sampah, harga_per_kg) VALUES
(1, 'Plastik PET (Botol Minum)', 3500.00),
(2, 'Kardus', 2000.00),
(3, 'Kertas HVS', 2500.00);

INSERT INTO setoran (id_setoran, id_nasabah, id_harga, berat, total, tanggal_setoran) VALUES
(1, 1, 1, 2.50,  8750.00, '2026-10-01'),
(2, 1, 2, 5.00, 10000.00, '2026-10-03'),
(3, 2, 3, 3.20,  8000.00, '2026-10-05');

SELECT * FROM nasabah;

UPDATE setoran
SET berat = 6.00,
    total = 12000.00
WHERE id_setoran = 2;

DELETE FROM setoran
WHERE id_setoran = 8;

