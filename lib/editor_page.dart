import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';
import 'package:groen/editor_view_model.dart';
import 'package:groen/settings_page.dart';
import 'package:groen/string_helpers.dart';
import 'package:provider/provider.dart';

class EditorPage extends StatelessWidget {
  final File file;

  const EditorPage({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditorViewModel>(
      create: (context) => EditorViewModel(file: file),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: const Text('groen'),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async => context.read<EditorViewModel>().save(),
                child: Icon(Icons.save, size: 26.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => Get.to(SettingsPage()),
                child: Icon(Icons.more_vert),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: createQuillEditor(context),
        ),
      ),
    );
  }

  Widget createQuillEditor(BuildContext context) {
    return Column(
      children: [
        // quill.QuillToolbar.basic(controller: controller),
        Expanded(
          child: quill.QuillEditor.basic(
            controller: context.read<EditorViewModel>().quillController,
            readOnly: false,
          ),
        )
      ],
    );
  }
}
