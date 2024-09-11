import 'package:flutter/material.dart';
import 'app.dart';
// import 'data/mongo_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await MongoConfig.connect();
  runApp(const PlantedApp());
}
