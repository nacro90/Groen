import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groen/ui/editor_page.dart';
import 'package:groen/ui/settings_page.dart';
import 'package:groen/ui/two_state_future_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('groen'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.search,
                size: 26.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => Get.to(const SettingsPage()),
              child: const Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, prefsSnapshot) {
          if (!prefsSnapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final rootDir = prefsSnapshot.data?.getString("root_directory");
          if (rootDir == null) {
            return const Text("no root dir");
          }
          return TwoStateFutureBuilder<List<FileSystemEntity>>(
            future: Directory(rootDir).list().toList(),
            builder: (context, files) {
              return ListView.builder(
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final file = files[index];
                  return TextButton(
                    onPressed: () async {
                      Get.to(EditorPage(file: File(file.path)));
                    },
                    child: Text(path.split(file.path).last),
                  );
                },
              );
            },
            fallback: (_) => const Text('Loading...'),
          );
        },
      ),
    );
  }
}
