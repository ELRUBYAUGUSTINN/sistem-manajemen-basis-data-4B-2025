CREATE DATABASE praktikum2;
USE praktikum2;

CREATE TABLE tb_mahasiswa (
id_mahasiswa INT(5),
nim VARCHAR(25),
nama_mahasiswa VARCHAR(100),
tempat_lahir VARCHAR(25),
tanggal_lahir DATE,
alamat TEXT,
email VARCHAR(100),
jk ENUM('Laki', 'Perempuan'),
angkatan VARCHAR(4),
status_mahasiswa ENUM('Aktif', 'Non Aktif', 'Cuti'),
);

CREATE TABLE dosen (
  nidn CHAR(12) PRIMARY KEY,
  nama VARCHAR(30) NOT NULL,
  email VARCHAR(30) UNIQUE,
  departemen VARCHAR(20),
  jenis_kelamin ENUM('L', 'P'),
  STATUS ENUM('Aktif', 'Tidak Aktif', 'Pensiun') DEFAULT 'Aktif'
);

CREATE TABLE mata_kuliah (
  kode_mk CHAR(10) PRIMARY KEY,
  nama_mk VARCHAR(30) NOT NULL,
  sks TINYINT UNSIGNED NOT NULL, 
  nidn CHAR(12),
  ruangan VARCHAR(10),
  jam_kuliah TIME,
  CONSTRAINT fk_dosen FOREIGN KEY (nidn) REFERENCES dosen(nidn)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

CREATE TABLE krs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nim CHAR(12) NOT NULL,
  kode_mk CHAR(10) NOT NULL,
  semester TINYINT UNSIGNED NOT NULL,
  tahun_ajaran VARCHAR(9) NOT NULL,
  tgl_pengisian DATE,
  STATUS ENUM('Disetujui', 'Ditolak', 'Diproses', 'Diterima') DEFAULT 'Diproses',
  
  FOREIGN KEY (nim) REFERENCES mahasiswa(nim)
    ON DELETE CASCADE ON UPDATE CASCADE,

  FOREIGN KEY (kode_mk) REFERENCES mata_kuliah(kode_mk)
    ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO dosen (nidn, nama, email, departemen, jenis_kelamin, STATUS) VALUES
('198710100001', 'Dr. Firmansyah Adi Saputra', 'andi.saputra@univ.ac.id', 'Sistem Informasi', 'L', 'Aktif'),
('198710100002', 'Dr. Budi Santoso', 'budi.santoso@univ.ac.id', 'Sistem Informasi', 'L', 'Aktif'),
('198710100003', 'Dr. Citra Maharani', 'citra.maharani@univ.ac.id', 'Teknik Komputer', 'P', 'Aktif'),
('198710100004', 'Drs. Dedi Gunawan', 'dedi.gunawan@univ.ac.id', 'Teknik Elektro', 'L', 'Pensiun'),
('198710100005', 'Dr. Evi Lestari', 'evi.lestari@univ.ac.id', 'Teknik Informatika', 'P', 'Aktif'),
('198710100006', 'Ir. Farid Hidayat', 'farid.hidayat@univ.ac.id', 'Sistem Informasi', 'L', 'Tidak Aktif'),
('198710100007', 'Dr. Gina Salsabila', 'gina.salsabila@univ.ac.id', 'Teknik Komputer', 'P', 'Aktif'),
('198710100008', 'Dr. Hendra Pratama', 'hendra.pratama@univ.ac.id', 'Teknik Elektro', 'L', 'Aktif'),
('198710100009', 'Dra. Indah Wulandari', 'indah.wulandari@univ.ac.id', 'Teknik Informatika', 'P', 'Aktif'),
('198710100010', 'Drs. Joko Suseno', 'joko.suseno@univ.ac.id', 'Sistem Informasi', 'L', 'Pensiun');

INSERT INTO mahasiswa (nim, nama, tanggal_lahir, alamat, email) VALUES
('220101000011', 'Sadewa buana', '2001-06-10', 'Jl. Garuda Raya No.88, Bogor', 'sadewaBuana@email.com'),
('220101000012', 'Ariq Suky wijaya', '2001-08-15', 'Jl. Melati No.5, Bandung', 'SukyJanay@email.com'),
('220101000013', 'Lestari Mnawu', '2003-01-22', 'Jl. Kenanga No.12, Surabaya', 'citra.lestari@email.com'),
('220101000014', 'Ayu Tiara', '2002-11-30', 'Jl. Dahlia No.3, Semarang', 'dewi.ayu@email.com'),
('220101000015', 'Eko', '2000-07-19', 'Jl. Anggrek No.9, Yogyakarta', 'eko.nugroho@email.com'),
('220101000016', 'Fitri Darmayanti', '2001-02-28', 'Jl. Cemara No.4, Medan', 'fitri.handayani@email.com'),
('220101000017', 'Gilang Ramadhan', '2003-04-17', 'Jl. Merpati No.7, Bekasi', 'gilang.ramadhan@email.com'),
('220101000018', 'Hana Nuraini', '2002-09-25', 'Jl. Elang No.10, Depok', 'hana.nuraini@email.com'),
('220101000019', 'Irfan Maulana', '2000-12-05', 'Jl. Rajawali No.2, Malang', 'irfan.maulana@email.com'),
('220101000020', 'Wahyu Alif', '2001-06-09', 'Jl. Garuda No.6, Bogor', 'WahyuAlif@email.com');

INSERT INTO mata_kuliah (kode_mk, nama_mk, sks, nidn, ruangan, jam_kuliah) VALUES
('IF111', 'Jaringan Komputer', 3, '198710100003', 'R111', '08:00:00'),
('IF112', 'Keamanan Informasi', 3, '198710100004', 'R112', '09:30:00'),
('IF113', 'Kecerdasan Buatan', 3, '198710100005', 'R113', '11:00:00'),
('IF114', 'Pemrograman Mobile', 3, '198710100006', 'R114', '13:00:00'),
('IF115', 'Big Data', 3, '198710100007', 'R115', '14:30:00'),
('IF116', 'Data Mining', 3, '198710100008', 'R116', '10:30:00'),
('IF117', 'Etika Profesi TI', 2, '198710100009', 'R117', '12:00:00'),
('IF118', 'Manajemen Sistem Informasi', 3, '198710100010', 'R118', '15:00:00'),
('IF119', 'Pemrograman Game', 3, '198710100001', 'R119', '09:00:00'),
('IF120', 'Teknologi Cloud', 2, '198710100002', 'R120', '07:30:00');

INSERT INTO krs (nim, kode_mk, semester, tahun_ajaran, tgl_pengisian, STATUS) VALUES
('220101000011', 'IF111', 2, '2024/2025', '2025-04-06', 'Diproses'),
('220101000012', 'IF112', 2, '2024/2025', '2025-04-06', 'Disetujui'),
('220101000013', 'IF113', 4, '2024/2025', '2025-04-06', 'Disetujui'),
('220101000014', 'IF114', 6, '2024/2025', '2025-04-06', 'Ditolak'),
('220101000015', 'IF116', 1, '2024/2025', '2025-04-06', 'Diproses');

SELECT * FROM mahasiswa;

RENAME TABLE mahasiswa TO mahasiwa;

UPDATE mahasiswa
SET nama = 'Rudi Hartono', email = 'rudi@email.com'
WHERE nim = '123456789012';

DROP TABLE mahasiswa;

ALTER TABLE krs DROP COLUMN ;

ALTER TABLE mahasiswa ADD nama VARCHAR(30) NOT NULL;

DELETE FROM mahasiswa WHERE nim = '220101000011';



INSERT INTO tb_mahasiswa (nim, nama_mahasiswa, tempat_lahir, tanggal_lahir, alamat, email, jk, angkatan, status_mahasiswa) VALUES
('210441100001', 'Andi Setiawan', 'Kota Malang', '2002-01-15', 'Kab. Malang, Jawa Timur', 'andi.setiawan@example.com', 'Laki', '2021', 'Aktif'),
('210441100002', 'Budi Santoso', 'Kota Batu', '2002-02-20', 'Kab. Malang, Jawa Timur', 'budi.santoso@example.com', 'Laki', '2021', 'Aktif'),
('210441100003', 'Cindy Kurnia', 'Kota Surabaya', '2002-03-10', 'Kota Surabaya, Jawa Timur', 'cindy.kurnia@example.com', 'Perempuan', '2021', 'Aktif'),
('210441100004', 'Dewi Rahmawati', 'Kab. Pasuruan', '2002-04-12', 'Kab. Pasuruan, Jawa Timur', 'dewi.rahmawati@example.com', 'Perempuan', '2021', 'Aktif'),
('210441100005', 'Eko Prasetyo', 'Kota Probolinggo', '2002-05-05', 'Kota Probolinggo, Jawa Timur', 'eko.prasetyo@example.com', 'Laki', '2021', 'Aktif'),
('210441100006', 'Fina Anggriana', 'Kab. Sidoarjo', '2002-06-18', 'Kab. Sidoarjo, Jawa Timur', 'fina.anggriana@example.com', 'Perempuan', '2021', 'Aktif'),
('210441100007', 'Guntur Wijaya', 'Kota Malang', '2002-07-22', 'Kab. Malang, Jawa Timur', 'guntur.wijaya@example.com', 'Laki', '2021', 'Aktif'),
('210441100008', 'Hani Yulianti', 'Kota Surabaya', '2002-08-30', 'Kota Surabaya, Jawa Timur', 'hani.yulianti@example.com', 'Perempuan', '2021', 'Aktif'),
('210441100009', 'Iwan Setiawan', 'Kab. Jombang', '2002-09-14', 'Kab. Jombang, Jawa Timur', 'iwan.setiawan@example.com', 'Laki', '2021', 'Aktif'),
('210441100010', 'Joko Susilo', 'Kab. Mojokerto', '2002-10-25', 'Kab. Mojokerto, Jawa Timur', 'joko.susilo@example.com', 'Laki', '2021', 'Aktif'),
('210441100011', 'Kirana Putri', 'Kota Pasuruan', '2002-11-11', 'Kota Pasuruan, Jawa Timur', 'kirana.putri@example.com', 'Perempuan', '2021', 'Aktif'),
('210441100012', 'Lina Marlina', 'Kab. Gresik', '2002-12-05', 'Kab. Gresik, Jawa Timur', 'lina.marlina@example.com', 'Perempuan', '2021', 'Aktif'),
('210441100013', 'Miko Saputra', 'Kota Mojokerto', '2003-01-20', 'Kota Mojokerto, Jawa Timur', 'miko.saputra@example.com', 'Laki', '2021', 'Aktif'),
('210441100014', 'Nina Amalia', 'Kab. Lamongan', '2003-02-18', 'Kab. Lamongan, Jawa Timur', 'nina.amalia@example.com', 'Perempuan', '2021', 'Aktif'),
('210441100015', 'Oki Prabowo', 'Kota Surabaya', '2003-03-22', 'Kota Surabaya, Jawa Timur', 'oki.prabowo@example.com', 'Laki', '2021', 'Aktif'),
('210441100016', 'Putri Melati', 'Kab. Sidoarjo', '2003-04-14', 'Kab. Sidoarjo, Jawa Timur', 'putri.melati@example.com', 'Perempuan', '2021', 'Aktif'),
('210441100017', 'Rudi Hartono', 'Kota Malang', '2003-05-30', 'Kab. Malang, Jawa Timur', 'rudi.hartono@example.com', 'Laki', '2021', 'Aktif'),
('210441100018', 'Sari Indah', 'Kab. Pasuruan', '2003-06-12', 'Kab. Pasuruan, Jawa Timur', 'sari.indah@example.com', 'Perempuan', '2021', 'Aktif'),
('210441100019', 'Toni Setyawan', 'Kota Probolinggo', '2003-07-25', 'Kota Probolinggo, Jawa Timur', 'toni.setyawan@example.com', 'Laki', '2021', 'Aktif'),
('210441100020', 'Umi Farida', 'Kab. Jombang', '2003-08-10', 'Kab. Jombang, Jawa Timur', 'umi.farida@example.com', 'Perempuan', '2021', 'Aktif'),
('210441100061', 'Vina Anjani', 'Kab. Mojokerto', '2004-01-15', 'Kab. Mojokerto, Jawa Timur', 'vina.anjani@example.com', 'Perempuan', '2021', 'Cuti'),
('210441100062', 'Wawan Kurniawan', 'Kota Malang', '2004-02-20', 'Kab. Malang, Jawa Timur', 'wawan.kurniawan@example.com', 'Laki', '2021', 'Aktif'),
-- Tambahkan data non aktif dan cuti
('210441100063', 'Yusuf Alif', 'Kota Surabaya', '2004-03-10', 'Kota Surabaya, Jawa Timur', 'yusuf.alif@example.com', 'Laki', '2021', 'Non Aktif'),
('210441100064', 'Zara Amani', 'Kab. Pasuruan', '2004-04-12', 'Kab. Pasuruan, Jawa Timur', 'zara.amani@example.com', 'Perempuan', '2021', 'Cuti');

INSERT INTO tb_dosen (nidn, nip, nama_dosen, email_dosen, jk, status_dosen) VALUES
('123456789012', NULL, 'Andi Susanto', 'andi.susanto@university.ac.id', 'Laki-laki', 'Honorer'),
('123456789013', '123456', 'Budi Santoso', 'budi.santoso@university.ac.id', 'Laki-laki', 'ASN'),
('123456789014', '123457', 'Cindy Kurnia', 'cindy.kurnia@university.ac.id', 'Perempuan', 'P3K'),
('123456789015', NULL, 'Dewi Rahmawati', 'dewi.rahmawati@university.ac.id', 'Perempuan', 'Honorer'),
('123456789016', '123458', 'Eko Prasetyo', 'eko.prasetyo@university.ac.id', 'Laki-laki', 'ASN'),
('123456789017', NULL, 'Fina Anggriana', 'fina.anggriana@university.ac.id', 'Perempuan', 'Honorer'),
('123456789018', '123459', 'Guntur Wijaya', 'guntur.wijaya@university.ac.id', 'Laki-laki', 'ASN'),
('123456789019', '123460', 'Hani Yulianti', 'hani.yulianti@university.ac.id', 'Perempuan', 'P3K'),
('123456789020', '123461', 'Iwan Setiawan', 'iwan.setiawan@university.ac.id', 'Laki-laki', 'ASN'),
('123456789021', '123462', 'Joko Susilo', 'joko.susilo@university.ac.id', 'Laki-laki', 'ASN'),
('123456789022', NULL, 'Kirana Putri', 'kirana.putri@university.ac.id', 'Perempuan', 'Honorer'),
('123456789023', '123463', 'Lina Marlina', 'lina.marlina@university.ac.id', 'Perempuan', 'P3K'),
('123456789024', '123464', 'Miko Saputra', 'miko.saputra@university.ac.id', 'Laki-laki', 'ASN'),
('123456789025', '123465', 'Nina Amalia', 'nina.amalia@university.ac.id', 'Perempuan', 'P3K'),
('123456789026', '123466', 'Oki Prabowo', 'oki.prabowo@university.ac.id', 'Laki-laki', 'ASN'),
('123456789027', NULL, 'Putri Melati', 'putri.melati@university.ac.id', 'Perempuan', 'Honorer'),
('123456789028', '123467', 'Rudi Hartono', 'rudi.hartono@university.ac.id', 'Laki-laki', 'ASN'),
('123456789029', '123468', 'Sari Indah', 'sari.indah@university.ac.id', 'Perempuan', 'P3K'),
('123456789030', '123469', 'Toni Setyawan', 'toni.setyawan@university.ac.id', 'Laki-laki', 'ASN'),
('123456789031', '123470', 'Umi Farida', 'umi.farida@university.ac.id', 'Perempuan', 'P3K'),
('123456789032', NULL, 'Vina Anjani', 'vina.anjani@university.ac.id', 'Perempuan', 'Honorer'),
('123456789033', '123471', 'Wawan Kurniawan', 'wawan.kurniawan@university.ac.id', 'Laki-laki', 'ASN'),
('123456789034', '123472', 'Yusuf Alif', 'yusuf.alif@university.ac.id', 'Laki-laki', 'ASN'),
('123456789035', '123473', 'Zara Amani', 'zara.amani@university.ac.id', 'Perempuan', 'P3K');

INSERT INTO tb_mata_kuliah (kode_matkul, nama_matkul, sks, ruangan, jam, id_dosen) VALUES
('PM101', 'Pemrograman Dasar', 3, 'LAB BIS', '08:00:00', 1),
('PM102', 'Pemrograman Lanjut', 3, 'LAB TI', '10:00:00', 2),
('PM103', 'Algoritma dan Pemrograman', 3, 'LAB Programming', '14:00:00', 1),
('PM104', 'Basis Data', 3, 'LAB BIS', '09:00:00', 3),
('PM105', 'Rekayasa Perangkat Lunak', 3, 'LAB TI', '11:00:00', 2),
('PM106', 'Pemrograman Web', 3, 'LAB Programming', '13:00:00', 1),
('PM107', 'Pengembangan Aplikasi Mobile', 3, 'LAB BIS', '15:00:00', 3),
('PM108', 'Keamanan Sistem', 3, 'LAB TI', '16:00:00', 2),
('PM109', 'Pemrograman Game', 3, 'LAB Programming', ' 17:00:00', 1),
('PM110', 'Kecerdasan Buatan', 3, 'LAB BIS', '18:00:00', 3);

INSERT INTO tb_krs (id_mahasiswa, id_matkul, semester, tahun_akademik) VALUES
(1, 1, 'Ganjil', '2023/2024'),
(1, 2, 'Ganjil', '2023/2024'),
(1, 3, 'Ganjil', '2023/2024'),
(1, 4, 'Ganjil', '2023/2024'),
(1, 5, 'Ganjil', '2023/2024'),
(1, 6, 'Ganjil', '2023/2024'),
(1, 7, 'Ganjil', '2023/2024'),
(1, 8, 'Ganjil', '2023/2024'),
(1, 9, 'Ganjil', '2023/2024'),
(1, 10, 'Ganjil', '2023/2024'),

(2, 1, 'Ganjil', '2023/2024'),
(2, 2, 'Ganjil', '2023/2024'),
(2, 3, 'Ganjil', '2023/2024'),
(2, 4, 'Ganjil', '2023/2024'),
(2, 5, 'Ganjil', '2023/2024'),
(2, 6, 'Ganjil', '2023/2024'),
(2, 7, 'Ganjil', '2023/2024'),
(2, 8, 'Ganjil', '2023/2024'),
(2, 9, 'Ganjil', '2023/2024'),
(2, 10, 'Ganjil', '2023/2024'),

(3, 1, 'Ganjil', '2023/2024'),
(3, 2, 'Ganjil', '2023/2024'),
(3, 3, 'Ganjil', '2023/2024'),
(3, 4, 'Ganjil', '2023/2024'),
(3, 5, 'Ganjil', '2023/2024'),
(3, 6, 'Ganjil', '2023/2024'),
(3, 7, 'Ganjil', '2023/2024'),
(3, 8, 'Ganjil', '2023/2024'),
(3, 9, 'Ganjil', '2023/2024'),
(3, 10, 'Ganjil', '2023/2024'),

(4, 1, 'Ganjil', '2023/2024'),
(4, 2, 'Ganjil', '2023/2024'),
(4, 3, 'Ganjil', '2023/2024'),
(4, 4, 'Ganjil', '2023/2024'),
(4, 5, 'Ganjil', '2023/2024'),
(4, 6, 'Ganjil', '2023/2024'),
(4, 7, 'Ganjil', '2023/2024'),
(4, 8, 'Ganjil', '2023/2024'),
(4, 9, 'Ganjil', '2023/2024'),
(4, 10, 'Ganjil', '2023/2024'),

(5, 1, 'Ganjil', '2023/2024'),
(5, 2, 'Ganjil', '2023/2024'),
(5, 3, 'Ganjil', '2023/2024'),
(5, 4, 'Ganjil', '2023/2024'),
(5, 5, 'Ganjil', '2023/2024'),
(5, 6, 'Ganjil', '2023/2024'),
(5, 7, 'Ganjil', '2023/2024'),
(5, 8, 'Ganjil', '2023/2024'),
(5, 9, 'Ganjil', '2023/2024'),
(5, 10, 'Ganjil', '2023/2024'),

(6, 1, 'Ganjil', '2023/2024'),
(6, 2, 'Ganjil', '2023/2024'),
(6, 3, 'Ganjil', '2023/2024'),
(6, 4, 'Ganjil', '2023/2024'),
(6, 5, 'Ganjil', '2023/2024'),
(6, 6, 'Ganjil', '2023/2024'),
(6, 7, 'Ganjil', '2023/2024'),
(6, 8, 'Ganjil', '2023/2024'),
(6, 9, 'Ganjil', '2023/2024'),
(6, 10, 'Ganjil', '2023/2024'),

(7, 1, 'Ganjil', '2023/2024'),
(7, 2, 'Ganjil', '2023/2024'),
(7, 3, 'Ganjil', '2023/2024'),
(7, 4, 'Ganjil', '2023/2024'),
(7, 5, 'Ganjil', '2023/2024'),
(7, 6, 'Ganjil', '2023/2024'),
(7, 7, 'Ganjil', '2023/2024'),
(7, 8, 'Ganjil', '2023/2024'),
(7, 9, 'Ganjil', '2023/2024'),
(7, 10, 'Ganjil', '2023/2024'),

(8, 1, 'Ganjil', '2023/2024'),
(8, 2, 'Ganjil', '2023/2024'),
(8, 3, 'Ganjil', '2023/2024'),
(8, 4, 'Ganjil', '2023/2024'),
(8, 5, 'Ganjil', '2023/2024'),
(8, 6, 'Ganjil', '2023/2024'),
(8, 7, 'Ganjil', '2023/2024'),
(8, 8, 'Ganjil', '2023/2024'),
(8, 9, 'Ganjil', '2023/2024'),
(8, 10, 'Ganjil', '2023/2024'),

(9, 1, 'Ganjil', '2023/2024'),
(9, 2, 'Ganjil', '2023/2024'),
(9, 3, 'Ganjil', '2023/2024'),
(9, 4, 'Ganjil', '2023/2024'),
(9, 5, 'Ganjil', '2023/2024'),
(9, 6, 'Ganjil', '2023/2024'),
(9, 7, 'Ganjil', '2023/2024'),
(9, 8, 'Ganjil', '2023/2024'),
(9, 9, 'Ganjil', '2023/2024'),
(9, 10, 'Ganjil', '2023/2024'),

(10, 1, 'Ganjil', '2023/2024'),
(10, 2, 'Ganjil', '2023/2024'),
(10, 3, 'Ganjil', '2023/2024'),
(10, 4, 'Ganjil', '2023/2024'),
(10, 5, 'Ganjil', '2023/2024'),
(10, 6, 'Ganjil', '2023/2024'),
(10, 7, 'Ganjil', '2023/2024'),
(10, 8, 'Ganjil', '2023/2024'),
(10, 9, 'Ganjil', '2023/2024'),
(10, 10, 'Ganjil', '2023/2024');

 SELECT * FROM tb_mata_kuliah GROUP BY ruangan = 'LAB BIS';
 
 DESC tb_mata_kuliah;
 
 CREATE view_mata_kuliah AS SELECT * FROM tb_mata_kuliah WHERE id_dosen = 1;
 
 SELECT * FROM view_mata_kuliah;
 
 SELECT VIEW view_mata_kuliah AS SELECT * FROM tb_mata_kuliah WHERE id_dosen = 4;
 
 CREATE OR REPLACE VIEW vMatkul AS SELECT kode_matkul, nama_matkul, ruangan, jam FROM tb_mata_kuliah;
 SELECT * FROM vMatkul;w