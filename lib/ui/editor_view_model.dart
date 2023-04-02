import 'dart:io';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:groen/data/deserializer/petit/parser.dart';
import 'package:groen/data/deserializer/petit/petit.dart';
import 'package:groen/data/model/model.dart' as norg;
import 'package:groen/data/serializer/quill/serializer.dart';
import 'package:petitparser/debug.dart';

class EditorViewModel with ChangeNotifier {
  final QuillController quillController;
  File? file;
  String coco = '';

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
    var document = Document();
    if (file != null) {
      var content = await file!.readAsString();
      norg.Node node = const norg.Document.empty();
      try {
        final deserializer = PetitDeserializer(const NorgParser().build());
        node = deserializer.deserialize(content);
        print(node);
      } catch (e) {
        print('can not deserialize: $e');
      }
      try {
        final delta = QuillDeltaSerializer().serialize(node);
        print(delta.toJson());
        document = Document.fromDelta(delta);
        coco = document.toPlainText();
      } catch (e) {
        print('can not serialize: $e');

        document.insert(0, content);
      }
    }
    quillController.document = document;
    quillController.addListener(() {
      final content = quillController.document.toPlainText();
      if (content == coco) {
        return;
      }
      coco = content;
      norg.Node node = const norg.Document.empty();
      try {
        final deserializer = PetitDeserializer(const NorgParser().build());
        node = deserializer.deserialize(content);
      } catch (e) {
        print('can not deserialize: $e');
      }
      try {
        final delta = QuillDeltaSerializer().serialize(node);
        debugPrint(delta.toJson().toString());
        quillController.document = Document.fromDelta(delta);
      } catch (e) {
        print('can not serialize: $e');

        quillController.document = Document()..insert(0, content);
      }
    });
  }
}
