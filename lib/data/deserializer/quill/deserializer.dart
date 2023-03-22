import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:groen/data/deserializer/deserializer.dart';
import 'package:groen/data/model/document.dart';

class DeltaDeserializer implements Deserializer<quill.Delta> {
  @override
  Document deserialize(quill.Delta input) => throw UnimplementedError();
}
