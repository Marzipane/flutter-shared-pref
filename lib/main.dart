import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences _prefs;
  int _number = 0;
  bool _bool = false;
  static const String _kNumberPrefKey = '_number_pref';
  static const String _kBoolPrefKey = '_number_pref';

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => _prefs = prefs);
      _loadNumberPref();
      _loadBoolPref();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Shared Prefer')),
        body: Column(
          children: [
            Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(60),
                1: FlexColumnWidth(60),
                2: FlexColumnWidth(60),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  const Text(
                    'Number Pref',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    _number.toString(),
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _setNumberPref(_number + 1);
                      },
                      child: const Text('Increment'))
                ]),
                TableRow(children: [
                  const Text(
                    'Bool pref',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    _bool.toString(),
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _setBoolPref(!_bool);
                      },
                      child: const Text('Toggle'))
                ]),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  _resetDataPref();
                },
                child: Text('clear data'))
          ],
        ));
  }

  // Saving data with key and value on the disk and get the variable from there
  Future _setNumberPref(int value) async {
    //  Sets the int value on the disk
    await _prefs.setInt(_kNumberPrefKey, value);
    _loadNumberPref();
  }

// Saving data with key and value on the disk and get the  variable from there
  Future _setBoolPref(bool value) async {
    //  Sets the bool value on the disk
    await _prefs.setBool(_kBoolPrefKey, value);
    _loadBoolPref();
    // Uses key and value to perform such operation
  }

  // Loading integer from the storage
  void _loadNumberPref() {
    setState(() {
      _number = _prefs.getInt(_kNumberPrefKey) ?? 0;
    });
  }

  // Loading bool from the storage
  void _loadBoolPref() {
    setState(() {
      _bool = _prefs.getBool(_kBoolPrefKey) ?? false;
    });
  }
// Clears the preference keys with it's values
  Future _resetDataPref() async {
    await _prefs.remove(_kNumberPrefKey);
    await _prefs.remove(_kBoolPrefKey);
    _loadNumberPref();
    _loadBoolPref();
  }
}
