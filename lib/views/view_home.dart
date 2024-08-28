/*  lib  views  HOME  */

import 'package:flutter/material.dart';
import 'package:planted_ii/data/repo_bonsai.dart';
import 'package:provider/provider.dart';
import '../view_models/homeviewmodel.dart';
import '../widgets/appbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String missionStatement = 'my mission is...';
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchMissionStatement();
  }

  Future<void> _fetchMissionStatement() async {
    try {
      String fetchedMissionStatement = await RepoBonsai.fetchMissionStatement();
      setState(() {
        missionStatement = fetchedMissionStatement;
      });
    } catch (e) {
      setState(() {
        hasError = true;
        missionStatement = 'Failed to load mission statement';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar_Garden(
        title: '-Home-',
        missionStatement: missionStatement,
        backgroundColorKey: 'UserBlueLight',
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: homeViewModel.widgets.length,
              itemBuilder: (context, index) {
                final widget = homeViewModel.widgets[index];
                return ListTile(
                  title: Text(widget['title']!),
                  onTap: () {
                    Navigator.pushNamed(context, widget['route']!);
                  },
                );
              },
            ),
          ),
          // new widgets
        ],
      ),
    );
  }
}
