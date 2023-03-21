import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:groen/core/model/model.dart';
import 'package:groen/core/serializer/serializer.dart';

class DeltaSerializer implements Serializer<quill.Delta> {
  @override
  quill.Delta serialize(Document document) {
    return quill.Delta()
      ..insert('quill test')
      ..insert(document.raw);
  }
}
