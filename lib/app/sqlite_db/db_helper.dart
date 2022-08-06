import 'package:face_id_plus/app/sqlite_db/table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../data/utils/constants.dart';

class DbHelper {
  static const _dbName = "midevDB";
  static const _dbVersion = 3;
  Future<Database> setDatabase() async {
    var dir = await getApplicationDocumentsDirectory();
    var path = join(dir.path, _dbName);
    var db = await openDatabase(path,
        version: _dbVersion,
        onCreate: _createDB,
        onUpgrade: _onUpDown,
        onDowngrade: _onUpDown);
    return db;
  }

  Future<void> _createDB(Database db, int ver) async {
    await _tbExecute(db);
  }

  Future<void> _onUpDown(Database db, int ver, int upgrade) async {
    await _tbExecute(db);
  }

  Future<void> _tbExecute(Database _db) async {
    var db = _db.batch();
    _dropTable(db);
    Table().kemungkinan(db);
    Table().keparahan(db);
    Table().resiko(db);
    Table().perusahaan(db);
    Table().lokasi(db);
    Table().detKeparahan(db);
    Table().pengendalian(db);
    Table().detPengendalian(db);
    Table().users(db);
    Table().deviceUpdate(db);

    await db.commit();
  }

  _dropTable(Batch db) {
    List<String> tb = [
      Constants.kemungkinanTb,
      Constants.metrikTb,
      Constants.perusahaanTb,
      Constants.keparahanTb,
      Constants.lokasiTb,
      Constants.detKeparahanTb,
      Constants.pengendalianTb,
      Constants.detPengendalianTb,
      Constants.usersTb,
      Constants.deviceUpdatTb,
    ];
    for (var e in tb) {
      var sql = "DROP TABLE IF EXISTS $e";
      db.execute(sql);
    }
  }
}
