import 'package:sqflite/sqlite_api.dart';
import '../data/utils/constants.dart';

class Table {
  kemungkinan(Batch db) {
    var sql =
        "CREATE TABLE ${Constants.kemungkinanTb} (idKemungkinan INTEGER, kemungkinan TEXT,keterangan TEXT,nilai INTEGER,flag INTEGER,kemungkinan_update TEXT)";
    db.execute(sql);
  }

  keparahan(Batch db) {
    var sql =
        "CREATE TABLE ${Constants.keparahanTb} (idKeparahan INTEGER, keparahan TEXT,nilai INTEGER,flag INTEGER,keparahan_update TEXT)";
    db.execute(sql);
  }

  resiko(Batch db) {
    var sql =
        "CREATE TABLE ${Constants.metrikTb} (idResiko INTEGER, kodeBahaya	 TEXT,min INTEGER,max INTEGER,flag INTEGER,kategori TEXT,tindakan TEXT,bgColor TEXT,txtColor TEXT,batas TEXT,resiko_update TEXT)";
    db.execute(sql);
  }

  perusahaan(Batch db) {
    var sql =
        "CREATE TABLE ${Constants.perusahaanTb} (id_perusahaan INTEGER, nama_perusahaan	 TEXT,flag INTEGER,time_in TEXT)";
    db.execute(sql);
  }

  lokasi(Batch db) {
    var sql =
        "CREATE TABLE ${Constants.lokasiTb} (idLok INTEGER, lokasi TEXT, des_lokasi TEXT, userInput TEXT, tgl_input TEXT)";
    db.execute(sql);
  }

  detKeparahan(Batch db) {
    var sql =
        "CREATE TABLE ${Constants.detKeparahanTb} (id_det INTEGER, idKeparahan INTEGER, keterangan TEXT, ket_input TEXT, time_input  TEXT)";
    db.execute(sql);
  }

  pengendalian(Batch db) {
    var sql =
        "CREATE TABLE ${Constants.pengendalianTb} (idHirarki INTEGER, id_ket INTEGER, namaPengendalian TEXT, userInput TEXT,  tgl_input TEXT, flag INTEGER)";
    db.execute(sql);
  }

  detPengendalian(Batch db) {
    var sql = """
              CREATE TABLE ${Constants.detPengendalianTb} 
              (id_hirarki INTEGER, 
              id_ket INTEGER, 
              keterangan TEXT, 
              ket_input  TEXT, 
              time_input TEXT)
              """;
    db.execute(sql);
  }

  users(Batch db) {
    var sql = """
              CREATE TABLE ${Constants.usersTb} 
              (id_user INTEGER, 
              username TEXT, 
              nama_lengkap  TEXT, 
              email  TEXT, 
              department  TEXT, 
              password  TEXT, 
              section  TEXT, 
              id_session  TEXT, 
              status  INTEGER, 
              ttd  TEXT, 
              rule  TEXT, 
              level  TEXT, 
              tglentry  TEXT, 
              nik  TEXT, 
              perusahaan  INTEGER,
              photo_profile  TEXT,
              user_update  TEXT,
              token_password  TEXT,
              dept  TEXT,
              sect  TEXT,
              nama_perusahaan TEXT)
              """;
    db.execute(sql);
  }

  deviceUpdate(Batch db) {
    var sql = """
              CREATE TABLE ${Constants.deviceUpdatTb} 
              (idUpdate INTEGER, 
              idDevice TEXT, 
              tipe  TEXT,
              timeUpdate  TEXT)
              """;
    db.execute(sql);
  }
}
