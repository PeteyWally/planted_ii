import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:planted_ii/data/repo_bonsai.dart';
import 'package:planted_ii/data/repo_in_mem/mem_category.dart';
import 'package:planted_ii/data/repo_in_mem/mem_task.dart';
import 'package:planted_ii/views/loading.dart';

import 'view_models/categoryviewmodel.dart';
import 'view_models/calendarviewmodel.dart';
import 'view_models/homeviewmodel.dart';
import 'view_models/taskviewmodel.dart';

import 'views/view_category.dart';
import 'views/view_home.dart';
import 'views/view_calendar.dart';
import 'views/view_task.dart';
import 'views/view_grid.dart';

import 'data/interfaces/repo_category.dart';
import 'data/interfaces/repo_tasks.dart';

void main() {
  runApp(const PlantedApp());
}

class PlantedApp extends StatefulWidget {
  const PlantedApp({super.key});

  @override
  _PlantedAppState createState() => _PlantedAppState();
}

class _PlantedAppState extends State<PlantedApp> {
  late Future<void> _initializationFuture;
  late TaskRepository _taskRepository;
  late CategoryRepository _categoryRepository;
  String missionStatement = 'my mission is...';

  @override
  void initState() {
    super.initState();
    _taskRepository = InMemoryTaskRepository();
    _categoryRepository = InMemoryCategoryRepository(_taskRepository);
    _initializationFuture = _initializeApp();
    _fetchMissionStatement();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(Duration(seconds: 5));
//pretend other loadings
  }

  Future<void> _fetchMissionStatement() async {
    try {
      String fetchedMissionStatement = await RepoBonsai.fetchMissionStatement();
      setState(() {
        missionStatement = fetchedMissionStatement;
      });
    } catch (e) {
      setState(() {
        missionStatement = 'Failed to fetch mission statement';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: _initializationFuture,
        builder: (context, snapshot) {
//loading route
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: LoadingScreen(
                missionStatement: missionStatement,
              ),
            );
          }

//error route
          if (snapshot.hasError) {
            return MaterialApp(
                home: Scaffold(
              body: Center(
                child: Text(
                    'Woah I did not expect to have a(n) ${snapshot.error}'),
              ),
            ));
          }

//normal routes
          return MultiProvider(
              providers: [
                Provider<TaskRepository>.value(value: _taskRepository),
                Provider<CategoryRepository>.value(value: _categoryRepository),
                ChangeNotifierProvider(
                  create: (_) => CategoryViewModel(
                    categoryRepository: _categoryRepository,
                    taskRepository: _taskRepository,
                  ),
                ),
                ChangeNotifierProvider(
                  create: (_) => TaskViewModel(
                    taskRepository: _taskRepository,
                    categoryRepository: _categoryRepository,
                  ),
                ),
                ChangeNotifierProvider(create: (_) => CalendarViewModel()),
                ChangeNotifierProvider(create: (_) => HomeViewModel()),
              ],
              child: MaterialApp(
                title: 'Custom Blocks App',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                initialRoute: '/',
                routes: {
                  '/': (context) => HomeView(),
                  '/calendar': (context) => CalendarView(),
                  '/task': (context) => TaskView(),
                  '/category': (context) => CategoryView(),
                  '/grid': (context) => GridScreen(),
//new routes
                },
              ));
        });
  }
}
