class RepoBonsai {
  static const String _missionStatement =
      'Mission Statement for remembering who you are inside: and more text to reiterate that';

  static Future<String> fetchMissionStatement() async {
// Simulate a delay for fetching data
    await Future.delayed(Duration(seconds: 1));
// Here you can add error handling or fetching logic from a remote server
    return _missionStatement;
  }
}
