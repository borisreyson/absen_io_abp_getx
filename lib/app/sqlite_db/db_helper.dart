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

  Future<void> _tbExecute(Database db) async {
    var _db = db.batch();
    _dropTable(_db);
    Table().kemungkinan(_db);
    Table().keparahan(_db);
    Table().resiko(_db);
    Table().perusahaan(_db);
    Table().lokasi(_db);
    Table().detKeparahan(_db);
    Table().pengendalian(_db);
    Table().detPengendalian(_db);
    Table().users(_db);
    Table().deviceUpdate(_db);

    await _db.commit();
  }

  _dropTable(Batch _db) {
    List<String> _tb = [
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
    for (var e in _tb) {
      var sql = "DROP TABLE IF EXISTS $e";
      _db.execute(sql);
    }
  }
}
