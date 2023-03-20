import 'dart:io';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class EditorViewModel with ChangeNotifier {
  final QuillController quillController;
  File? file;

  EditorViewModel({this.file}) : quillController = QuillController.basic() {
    Future.microtask(() => _populateController());
  }

  Future<void> save() async {
    if (file == null) {
      return;
    }
    Get.snackbar("Saved", "Saved ${file?.path}");
    final content = quillController.document.toPlainText();
    await file?.writeAsString(content);
  }

  Future<void> _populateController() async {
    final document = Document();
    if (file != null) {
      final content = await file!.readAsString();
      document.insert(0, content);
    }
    quillController.document = document;
  }
}
