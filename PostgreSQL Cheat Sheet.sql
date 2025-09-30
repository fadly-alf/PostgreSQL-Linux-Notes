CREATE QUERY:

1. ACCESS METHOD: untuk cara penyimpanan index
CREATE ACCESS METHOD my_method TYPE INDEX HANDLER my_handler_function;

2. AGGREGATE: menghitung nilai tunggal dari sekumpulan nilai data, seperti jumlah, rata-rata, nilai minimum, atau maksimum
CREATE AGGREGATE sum_int8(bigint) (SFUNC = int8pl, STYPE = bigint, INITCOND = '0');

3. CAST: membuat konversi antar tipe data
CREATE CAST (varchar AS int) WITH FUNCTION varchar_to_int(varchar) AS ASSIGNMENT;

4. COLLATION: aturan pengurutan string
CREATE COLLATION german (LOCALE = 'de_DE.utf8');

5. CONVERSION konversi karakter encoding
CREATE CONVERSION myconv FOR 'UTF8' TO 'LATIN1' FROM myfunc;

6. DATABASE: sebuah DATABASE
CREATE DATABASE nama_db;

7. DOMAIN: tipe data dengan aturan sendiri
CREATE DOMAIN positive_int AS int CHECK (VALUE > 0);

8. EVENT TRIGGER: Trigger untuk event DDL
CREATE EVENT TRIGGER ddl_trigger ON ddl_command_start EXECUTE FUNCTION log_ddl();

9. EXTENSION: membuat sebuah EXTENSION
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

10. FOREIGN DATA WRAPPER: mengakses data eksternal
CREATE FOREIGN DATA WRAPPER my_fdw;

11. FOREIGN TABLE: membuat table yang merupakan table eksternal di server lain, jadi perlu dibuat dulu DDL table eksternal nya, nanti hanya perlu query saja seperti biasa
CREATE FOREIGN TABLE ft_users (id int, name text) SERVER my_server OPTIONS (table_name 'remote_users');

12. FUNCTION:  objek database yang berisi satu set perintah SQL atau perintah yang ditulis dalam bahasa prosedural (seperti PL/pgSQL) yang dapat dieksekusi dan mengembalikan nilai tunggal (skalar) atau satu set baris (tabel).
CREATE [OR REPLACE] FUNCTION nama_fungsi(parameter1 tipe_data, parameter2 tipe_data, ...)
RETURNS tipe_data_kembalian -- atau RETURNS TABLE(...) atau RETURNS SETOF tipe_data
AS $$
-- Badan fungsi (logika, deklarasi variabel, perintah SQL)
BEGIN
    -- Logika ...
    RETURN nilai;
END;
$$ LANGUAGE plpgsql;

SELECT nama_fungsi(nilai_parameter1, nilai_parameter2);
SELECT * FROM nama_fungsi(nilai_parameter1); -- Jika function mengembalikan set of rows (RETURNS TABLE atau SETOF)

13. GROUP: alias lama untuk role GROUP
CREATE GROUP devs;

14. INDEX: membuat index untuk mempercepat pencarian
CREATE INDEX nama_index ON nama_table(nama_kolom);

15. LANGUAGE: membuat 
CREATE LANGUAGE plpgsql;

16. MATERIALIZED VIEW: view yang disimpan secara fisik di harddisk
CREATE MATERIALIZED VIEW active_users AS SELECT * FROM users WHERE active = true;

17. OPERATOR
CREATE OPERATOR === (LEFTARG = int, RIGHTARG = int, PROCEDURE = int4eq);

18. OR REPLACE: untuk mengganti objek
CREATE OR REPLACE FUNCTION hello() RETURNS text AS $$ SELECT 'Hello World'; $$ LANGUAGE sql;

19. POLICY (Row Level Security)
CREATE POLICY user_policy ON users FOR SELECT USING (current_user = username);

20. PROCEDURE
CREATE PROCEDURE log_message(msg text)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO logs(message) VALUES (msg);
END;
$$;


21. PUBLICATION (Log Reps)
CREATE PUBLICATION my_pub FOR TABLE users;

22. ROLE 
CREATE ROLE nama_role LOGIN PASSWORD 'password';

23. RULE: mendefinisikan suatu tindakan yang harus dilakukan oleh sistem sebelum suatu query dieksekusi.
CREATE [ OR REPLACE ] RULE nama_rule AS ON event_type TO nama_tabel [ WHERE condition ] DO [ INSTEAD ] action;
CREATE RULE no_delete AS ON DELETE TO users DO INSTEAD NOTHING;

24. SCHEMA: 
CREATE SCHEMA nama_schema;

25. SEQUENCE:  objek database yang digunakan untuk menghasilkan nilai numerik unik secara otomatis (biasanya integer).
CREATE SEQUENCE order_seq START 1 INCREMENT 1;
CREATE SEQUENCE nama_sequence
    INCREMENT BY 1        -- Berapa banyak nilai bertambah (default 1)
    MINVALUE 1            -- Nilai minimum (default 1)
    START WITH 1          -- Nilai awal
    CACHE 20;             -- Berapa banyak nilai yang disimpan di memori untuk akses cepat

- Mengambil Nilai Berikutnya
SELECT nextval('nama_sequence');

- Mengambil Nilai Saat ini 
SELECT currval('nama_sequence');

26. SERVER
CREATE SERVER my_server FOREIGN DATA WRAPPER my_fdw OPTIONS (host 'localhost', dbname 'otherdb');

27. STATISTIC
CREATE STATISTICS user_stats (dependencies) ON age, city FROM users;

28. SUBSCRIPTION (Log Reps)
CREATE SUBSCRIPTION nama_sub CONNECTION 'dbname=source host=127.0.0.1 user=rep password=pass' PUBLICATION nama_pub;

29. TABLE
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name text,
    price numeric
);

30. TABLESPACE: lokasi penyimpanan fisik pada sistem file yang digunakan untuk menyimpan file data, indeks, dan objek database lainnya.
CREATE TABLESPACE fastdisk LOCATION '/mnt/ssd1/pgdata';
CREATE TABLESPACE nama_tablespace OWNER nama_user LOCATION '/path/ke/direktori/fisik';

- Menggunakan TABLESPACE
CREATE TABLE nama_tabel (kolom1 INT, kolom2 VARCHAR(255)) TABLESPACE nama_tablespace;

- Membuat index di TABLESPACE
CREATE INDEX nama_indeks ON nama_tabel (kolom_indeks) TABLESPACE nama_tablespace;

- Membuat database di TABLESPACE tertentu
CREATE DATABASE nama_database TABLESPACE nama_tablespace;

31. TEMP/TEMPORARY: Tabel Sementara (Temporary Tables) atau Files Temporer (Temporary Files) yang digunakan oleh sistem saat memproses query yang kompleks.
CREATE TEMP TABLE temp_data (id int, value text);

32. TEXT SEARCH: melakukan pencarian dokumen atau teks berbasis natural language 
CREATE TEXT SEARCH CONFIGURATION my_english (COPY = pg_catalog.english);

33. TRANSFORM: mengubah, membersihkan, memvalidasi, dan menggabungkan data mentah yang telah diekstrak dari sumber data (Langkah E) menjadi format yang sesuai dan siap untuk dimuat ke dalam sistem tujuan, seperti Data Warehouse atau Data Mart (Langkah L).
CREATE TRANSFORM FOR jsonb LANGUAGE plpgsql (FROM SQL WITH FUNCTION jsonb_in(cstring), TO SQL WITH FUNCTION jsonb_out(jsonb));

34. TRIGGER: Trigger adalah objek basis data yang secara otomatis menjalankan fungsi atau prosedur tertentu sebagai respons terhadap peristiwa (event) tertentu pada suatu tabel.
CREATE TRIGGER update_timestamp BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_modified_column();

35. TYPE: 
CREATE TYPE mood AS ENUM ('happy', 'sad', 'ok');

36. UNIQUE:
 CREATE TABLE accounts (
    id serial,
    email text UNIQUE
);

37. UNLOGGED
CREATE UNLOGGED TABLE cache_data (
    key text,
    value text
);

38. USER 
CREATE USER appuser WITH PASSWORD 'securepass';

39. USER MAPPING FOR: memetakan kredensial (nama pengguna dan kata sandi) dari satu pengguna basis data lokal ke kredensial pengguna di basis data atau sistem eksternal. Fitur ini bekerja bersama dengan ekstensi Foreign Data Wrapper (FDW).
CREATE USER MAPPING FOR appuser SERVER my_server OPTIONS (user 'remoteuser', password 'remotepass');

40. VIEW: view Sementara
CREATE VIEW active_users AS SELECT * FROM users WHERE active = true;

41. BEGIN, COMMIT, ROLLBACK
- BEGIN
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE user_id = 1;
UPDATE accounts SET balance = balance + 100 WHERE user_id = 2;
COMMIT;

- ROLLBACK
BEGIN;
INSERT INTO logs (message) VALUES ('Mencoba operasi...');
-- Operasi gagal
ROLLBACK;

42. SAVEPOINT: Menentukan titik di dalam transaksi untuk bisa kembali (rollback) tanpa membatalkan seluruh transaksi.
BEGIN;
INSERT INTO users (name) VALUES ('Andi');
SAVEPOINT before_update;
UPDATE users SET name = 'Budi' WHERE name = 'Andi';
ROLLBACK TO SAVEPOINT before_update; -- Perubahan 'Budi' dibatalkan, 'Andi' tetap ada
COMMIT;

43. RELEASE: Menghapus savepoint dari transaksi. Perubahan yang dilakukan setelah savepoint akan tetap ada.
BEGIN;
INSERT INTO users (name) VALUES ('Cici');
SAVEPOINT s1;
INSERT INTO users (name) VALUES ('Deni');
RELEASE SAVEPOINT s1; -- s1 dihapus, kedua INSERT akan di-commit
COMMIT;

44. SELECT: Mengambil data dari satu atau lebih tabel. Ini adalah perintah DML yang paling sering digunakan.
SELECT first_name, last_name FROM employees WHERE department = 'Sales' ORDER BY last_name;

45. INSERT INTO: Menambahkan baris baru ke dalam tabel.
INSERT INTO products (name, price) VALUES ('Laptop', 1200);

46. UPDATE: Memodifikasi data di baris yang sudah ada.
UPDATE products SET price = 1300 WHERE name = 'Laptop';

47. DELETE FROM: Menghapus baris dari tabel.
DELETE FROM products WHERE price > 2000;

48. MERGE INTO: Menggabungkan operasi INSERT, UPDATE, dan DELETE menjadi satu perintah berdasarkan kondisi kecocokan antara tabel sumber dan tabel target.
MERGE INTO inventory AS t
USING new_products AS s
ON t.product_id = s.product_id
WHEN MATCHED THEN
  UPDATE SET stock = t.stock + s.stock
WHEN NOT MATCHED THEN
  INSERT (product_id, name, stock) VALUES (s.product_id, s.name, s.stock);

49. TRUNCATE: Menghapus semua baris dari tabel dengan sangat cepat. Perintah ini tidak memicu trigger level baris.
TRUNCATE TABLE staging_data;

50. COMMENT: Menambahkan komentar pada objek database untuk tujuan dokumentasi.
COMMENT ON COLUMN users.id IS 'Primary key untuk tabel users.';

51. RENAME: mengganti nama
ALTER TABLE table_name RENAME TO new_name;

52. ANALYZE: Mengumpulkan statistik tentang isi tabel untuk membantu query planner membuat rencana eksekusi yang lebih baik.
ANALYZE orders;

53. VACUUM: Mereklamasi ruang penyimpanan yang digunakan oleh baris yang telah dihapus atau diperbarui.
- VACUUM: Jenis vacuum dasar yang menandai ruang yang ditempati tupel mati sebagai tersedia untuk digunakan kembali. Proses ini tidak mengubah ukuran file data, tetapi memungkinkan data baru ditulis ke ruang kosong tersebut. Vacuum biasa umumnya tidak mengunci tabel dalam waktu lama.
VACUUM public.sales;

- VACUUM FULL: Proses ini menulis ulang seluruh isi tabel ke file baru di disk, mengembalikan ruang kosong ke sistem operasi dan bisa mengurangi ukuran file tabel. Namun, vacuum full membutuhkan penguncian eksklusif yang memblokir operasi baca/tulis selama proses berjalan dan membutuhkan ruang disk tambahan sementara.

- Autovacuum: Proses otomatis yang berjalan di latar belakang, memantau database dan menjalankan vacuum secara otomatis saat dibutuhkan untuk mencegah bloat (pemborosan ruang penyimpanan akibat tupel mati yang menumpuk). Autovacuum membantu menjaga performa tanpa perlu intervensi manual.

- Paralel Vacuum:  Pada beberapa versi dan konfigurasi, vacuum bisa dijalankan dengan pekerja paralel yang melakukan penyedotan pada indeks dan pembersihan secara bersamaan, meningkatkan kecepatan vacuum.

54. CLUSTER: Mengurutkan ulang baris dalam tabel berdasarkan indeks, yang dapat meningkatkan performa untuk query yang sering mengakses baris yang berdekatan.
CLUSTER users USING idx_users_id;

55. REINDEX: Membangun kembali satu atau semua indeks pada tabel atau database untuk mengoptimalkan performa.
REINDEX TABLE employees;

56. EXPLAIN: Menampilkan rencana eksekusi dari suatu query tanpa benar-benar menjalankannya. Sangat penting untuk mengoptimalkan performa.
EXPLAIN ANALYZE SELECT * FROM large_table WHERE column = 'value';

57. REFRESH MATERIALIZED VIEW: Memperbarui data dalam Materialized View dengan mengeksekusi ulang query definisinya.
REFRESH MATERIALIZED VIEW CONCURRENTLY nama_view;

58. COPY: Menyalin data antara tabel dan file. Sangat cepat untuk impor/ekspor data massal.
COPY products FROM 'products_data.csv' DELIMITER ',' CSV HEADER;

59. SHOW: Menampilkan nilai dari parameter konfigurasi PostgreSQL.
SHOW work_mem;
SHOW data_directory;

60. SET: Mengubah nilai parameter konfigurasi untuk sesi saat ini.
SET work_mem = '16MB';
SET search_pat TO nama_schema;

PostgreSQL BINARIES:

1. initdb
Penjelasan: Membuat klaster data PostgreSQL baru (Data Directory). Ini adalah langkah pertama untuk membuat instance server baru.
Cara pakai: initdb [OPTIONS] -D DATADADIR -D, --pgdata: Jalur ke direktori tempat data akan disimpan. -E, --encoding: Encoding karakter default (misalnya UTF8). --locale: Pengaturan lokal (locale) yang akan digunakan.

2. postgres
Penjelasan: Program server database utama. Tidak dijalankan langsung oleh pengguna, tetapi melalui pg_ctl atau layanan sistem.
Cara pakai: postgres [OPTIONS] -D DATADIR -D: Jalur Data Directory (wajib). -c name=value: Mengatur parameter konfigurasi.

3. pg_ctl
Penjelasan: Alat kontrol utilitas untuk memulai, menghentikan, memuat ulang konfigurasi, dan melihat status server PostgreSQL.
Cara pakai: pg_ctl command -D DATADIR [OPTIONS] start: Memulai server. stop: Menghentikan server. restart: Menghentikan dan memulai ulang. reload: Memuat ulang file konfigurasi (postgresql.conf). status: Menampilkan status server.

4. createdb
Penjelasan: Membuat database PostgreSQL baru.
Cara pakai: createdb [OPTIONS] dbname -O, --owner: Menentukan pemilik database. -E, --encoding: Encoding database. -T, --template: Database template yang akan digunakan.

5. dropdb
Penjelasan: Menghapus database PostgreSQL secara permanen.
Cara pakai: dropdb [OPTIONS] dbname -i, --interactive: Meminta konfirmasi sebelum menghapus.

6. createuser
Penjelasan: Membuat peran (role) PostgreSQL baru.	
Cara pakai: createuser [OPTIONS] rolename --superuser: Memberikan hak superuser. --createdb: Memberikan izin untuk membuat database. --password: Meminta kata sandi secara interaktif.

7. dropuser
Penjelasan: Menghapus peran (role) PostgreSQL.	
Cara pakai: dropuser [OPTIONS] rolename -i, --interactive: Meminta konfirmasi sebelum menghapus.

8. psql
Penjelasan: Klien terminal interaktif untuk PostgreSQL. Digunakan untuk menjalankan query SQL, administrasi, dan skrip.	
Cara pakai: psql [OPTIONS] [dbname [username]] -c, --command: Menjalankan satu perintah SQL dan keluar. -f, --file: Menjalankan perintah SQL dari file. -l, --list: Mencantumkan semua database.

9. pg_isready	
Penjelasan: Memeriksa status koneksi server PostgreSQL, sangat berguna untuk skrip atau pemantauan.	
Cara pakai: pg_isready [OPTIONS] -h, --host: Host server. -p, --port: Port server.

10. vacuumdb
Penjelasan: Meng-VACUUM satu atau semua database, mengklaim kembali storage yang terpakai dan memperbarui statistik planner.	
Cara pakai: vacuumdb [OPTIONS] [dbname] -z, --analyze: Menjalankan VACUUM dan ANALYZE. -F, --full: Melakukan VACUUM FULL (lebih lambat tapi menghemat lebih banyak space). -t, --table: Hanya memproses tabel tertentu.

11. reindexdb	
Penjelasan: Membangun ulang indeks pada satu atau semua database untuk meningkatkan performa atau mengatasi korupsi indeks.	
Cara pakai: reindexdb [OPTIONS] [dbname] -a, --all: Memproses semua database. -t, --table: Hanya membangun kembali indeks pada tabel tertentu.

12. clusterdb
Penjelasan: Meng-CLUSTER satu atau semua database berdasarkan indeks yang sudah ditentukan, mengurutkan data secara fisik.	
Cara pakai: clusterdb [OPTIONS] [dbname] -a, --all: Memproses semua database. -t, --table: Hanya memproses tabel tertentu.

13. pg_amcheck
Penjelasan: Memeriksa integritas struktur data pada indeks B-Tree dalam database. Digunakan untuk mendeteksi korupsi data tingkat rendah.	
Cara pakai: pg_amcheck [OPTIONS] [dbname] --all: Memeriksa semua database. --checksums: Memverifikasi checksum (jika diaktifkan).

14. pg_dump
Penjelasan: Membuat dump (backup) logis dari satu database. Output berupa script SQL atau format terkompresi.	
Cara pakai: pg_dump [OPTIONS] dbname -f, --file: File output backup. -F, --format: Format output (p plain, c custom, d directory, t tar). -C, --create: Sertakan perintah CREATE DATABASE. -a, --data-only: Hanya data, tanpa skema.

15. pg_dumpall
Penjelasan: Membuat dump logis dari SELURUH klaster, termasuk definisi role, tablespace, dan semua database.	
Cara pakai: pg_dumpall [OPTIONS] -f, --file: File output backup. -g, --globals-only: Hanya global object (role dan tablespace), tanpa data database.

16. pg_restore
Penjelasan: Memulihkan database dari file backup yang dibuat oleh pg_dump dalam format custom, tar, atau directory.	
Cara pakai: pg_restore [OPTIONS] filename -d, --dbname: Database target untuk dipulihkan. -c, --clean: Hapus objek sebelum membuat ulang. -j, --jobs: Menggunakan koneksi paralel untuk pemulihan cepat.

17. pg_basebackup
Penjelasan: Membuat backup level file sistem dari klaster database, digunakan untuk Point-In-Time Recovery (PITR) dan replikasi streaming.	
Cara pakai: pg_basebackup [OPTIONS] -D DATADIR -D: Direktori output untuk backup. -F, --format: Format output (p plain, t tar). -X, --wal-method: Metode untuk menyertakan WAL (misalnya stream).

18. pg_receivewal
Penjelasan: Digunakan pada Standby Server untuk menerima dan menyimpan Write-Ahead Log (WAL) dari Primary Server.	
Cara pakai: pg_receivewal [OPTIONS] -D: Direktori untuk menyimpan file WAL. -s, --status-interval: Interval pengiriman status ke Primary.

19. pg_recvlogical	
Penjelasan: Klien untuk Logical Decoding, digunakan untuk mengambil aliran data row-level dari Primary Server.	
Cara pakai: pg_recvlogical [OPTIONS] -d, --dbname: Database yang berisi slot replikasi logis. -S, --slot: Nama slot replikasi.

20. pg_rewind
Penjelasan: Alat untuk menyinkronkan klaster split-brain. Memungkinkan bekas Primary Server untuk bergabung kembali sebagai Standby setelah failover tanpa base backup penuh.	
Cara pakai: pg_rewind [OPTIONS] -D DATADIR --target-server='conn_string' -D: Data Directory lokal yang akan di-rewind.

21. pg_archivecleanup
Penjelasan: Alat yang digunakan untuk membersihkan file WAL lama dari arsip yang tidak lagi dibutuhkan oleh server Standby.	
Cara pakai: pg_archivecleanup [OPTIONS] archive_location oldest_wal_file

22. pg_verifybackup
Penjelasan: Memverifikasi integritas file backup yang dibuat dengan pg_basebackup.	
Cara pakai: pg_verifybackup [OPTIONS] directory

23. pg_config
Penjelasan: Menampilkan informasi tentang versi dan konfigurasi build PostgreSQL yang terinstal (jalur header, pustaka, dll.).	
Cara pakai: pg_config --bindir pg_config --version

24. pg_controldata
Penjelasan: Menampilkan informasi kontrol (control information) teknis yang disimpan di dalam klaster data. Berguna untuk pemecahan masalah.	
Cara pakai: pg_controldata -D DATADIR

25. pg_checksums
Penjelasan: Mengelola dan memverifikasi checksum halaman data. Dapat digunakan untuk mengaktifkan atau memverifikasi checksum pada klaster yang sudah ada.
Cara pakai: pg_checksums [OPTIONS] -D DATADIR --enable: Mengaktifkan checksum pada klaster yang dihentikan. --verify: Memeriksa checksum.

26. pg_resetwal
Penjelasan: Mengatur ulang informasi Write-Ahead Log (WAL). Ini adalah alat pemulihan darurat yang digunakan ketika server tidak dapat dimulai karena WAL yang rusak. Sangat berbahaya, gunakan sebagai upaya terakhir.	
Cara pakai: pg_resetwal -D DATADIR

27. pg_test_fsync
Penjelasan: Melakukan serangkaian tes untuk mengukur performa dan keandalan fsync() (sinkronisasi file sistem) pada disk Anda.	
Cara pakai: pg_test_fsync [OPTIONS]

28. pg_test_timing
Penjelasan: Mengukur overhead loop pengulangan dan panggilan sistem lainnya, penting untuk menentukan keakuratan waktu di server.	
Cara pakai: pg_test_timing

29. pg_upgrade
Penjelasan: Memfasilitasi pembaruan (upgrade) major version PostgreSQL dengan memindahkan atau menghubungkan file data tanpa dump dan restore penuh.	
Cara pakai: pg_upgrade [OPTIONS] -b, --old-bindir: Direktori binary PostgreSQL lama. -B, --new-bindir: Direktori binary PostgreSQL baru. -d, --old-datadir: Data Directory lama. -D, --new-datadir: Data Directory baru.

30. pg_waldump
Penjelasan: Utilitas untuk memeriksa dan menampilkan isi file WAL (Write-Ahead Log) dalam format yang dapat dibaca manusia. Berguna untuk debugging dan analisis.	
Cara pakai: pg_waldump [OPTIONS] -f, --file: File WAL yang akan ditampilkan. --start/--end: Batas waktu atau lokasi WAL yang akan ditampilkan.

31. ecpg
Penjelasan: Pre-prosesor SQL tertanam untuk C. Memungkinkan Anda menanamkan query SQL langsung ke dalam kode C.	
Cara pakai: ecpg [OPTIONS] filename.pgc




















