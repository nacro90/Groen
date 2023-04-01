import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:groen/data/model/model.dart';
import 'package:groen/data/serializer/serializer.dart';

class DeltaSerializer implements Serializer<quill.Delta> {
  @override
  quill.Delta serialize(Document document) {
    return quill.Delta()
      ..insert('quill test');
  }
}
