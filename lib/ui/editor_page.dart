import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'editor_view_model.dart';
import 'settings_page.dart';

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
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async => context.read<EditorViewModel>().save(),
                child: const Icon(Icons.save, size: 26.0),
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
        body: SafeArea(
          child: createQuillEditor(context),
        ),
      ),
    );
  }

  Widget createQuillEditor(BuildContext context) {
    return Column(
      children: [
        quill.QuillToolbar.basic(
          controller: context.read<EditorViewModel>().quillController,
          showDividers: true,
          showFontFamily: false,
          showSmallButton: true,
          showAlignmentButtons: false,
          embedButtons: FlutterQuillEmbeds.buttons(
            showFormulaButton: true,
            // mediaPickSettingSelector: (context) async =>
            //     MediaPickSetting.Gallery,
            onImagePickCallback: (file) async => 'imagee',
            onVideoPickCallback: (file) async => 'videoo',
            filePickImpl: (context) => FilePicker.platform
                .pickFiles()
                .then((value) => value?.paths[0]),
          ),
        ),
        Expanded(
          child: quill.QuillEditor.basic(
            controller: context.read<EditorViewModel>().quillController,
            embedBuilders: FlutterQuillEmbeds.builders(),
            readOnly: false,
          ),
        )
      ],
    );
  }
}
