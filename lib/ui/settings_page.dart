import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const rootDirKey = 'root_directory';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, prefsSnapshot) {
            if (!prefsSnapshot.hasData || prefsSnapshot.data == null) {
              return const CircularProgressIndicator();
            }
            final prefs = prefsSnapshot.data!;
            return Column(
              children: [
                Text(prefs.getString(rootDirKey) ?? 'no root dir'),
                ElevatedButton(
                  onPressed: () async {
                    final path = await FilePicker.platform.getDirectoryPath();
                    if (path == null) {
                      return;
                    }
                    await prefs.setString(rootDirKey, path);
                    setState(() {});
                  },
                  child: const Text('select dir'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
