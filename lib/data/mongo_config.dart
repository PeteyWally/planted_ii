/*  lib / data / MONGO CONFIGURATION  */

import 'package:mongo_dart/mongo_dart.dart';

class MongoConfig {
  static late Db db;
  static Future<void> connect() async {
    db = Db('mongodb://localhost:27017/planted_ii');
    await db.open();
  }

  static void close() {
    db.close();
  }
}
