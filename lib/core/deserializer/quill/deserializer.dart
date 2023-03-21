import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:groen/core/deserializer/deserializer.dart';
import 'package:groen/core/model/document.dart';

class DeltaDeserializer implements Deserializer<quill.Delta> {
  @override
  Document deserialize(quill.Delta input) => throw UnimplementedError();
}
