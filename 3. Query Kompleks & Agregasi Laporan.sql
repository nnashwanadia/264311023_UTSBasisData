SELECT n.nama_nasabah,
       COUNT(s.id_setoran) AS jumlah_setoran,
       SUM(s.berat)        AS total_berat_kg,
       SUM(s.total)        AS total_pendapatan
FROM setoran s
JOIN nasabah n ON s.id_nasabah = n.id_nasabah
WHERE s.tanggal_setoran >= '2026-10-03'
GROUP BY n.id_nasabah, n.nama_nasabah;
