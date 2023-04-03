import 'package:groen/data/model/model.dart' hide Document;
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Node;
import 'package:groen/data/serializer/serializer.dart';

abstract class EditorViewModel {
  String toPlainText();
  Function(String content)? onContentChanged;
  void render(Node node, {bool skipOnChange = false});
}

class QuillEditorViewModel with ChangeNotifier implements EditorViewModel {
  final QuillController controller;
  final QuillDeltaSerializer serializer;
  @override
  Function(String content)? onContentChanged;
  Delta? _currentDelta;
  TextSelection? _currentTextSelection;
  bool _shouldSkipOnChange = false;

  QuillEditorViewModel({
    required this.controller,
    required this.serializer,
    this.onContentChanged,
  }) {
    controller.addListener(_onChange);
  }

  void _onChange() {
    if (_shouldSkipOnChange) {
      return;
    }
    if (controller.document.toDelta() != _currentDelta) {
      onContentChanged?.call(controller.document.toPlainText());
      _currentDelta = controller.document.toDelta();
    }
    if (controller.selection == _currentTextSelection) {
      // TODO: implement on text selection changed
    }
  }

  @override
  void render(Node node, {bool skipOnChange = false}) {
    _shouldSkipOnChange = skipOnChange;
    final delta = serializer.serialize(node);
    print('delta:$delta');
    print(controller);
    final prevSelection = controller.selection;
    controller.document = Document.fromDelta(delta);
    controller.updateSelection(prevSelection, ChangeSource.LOCAL);
    print('da');
    _shouldSkipOnChange = false;
  }

  @override
  String toPlainText() => controller.document.toPlainText();
}
