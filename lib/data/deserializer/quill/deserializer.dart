import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:groen/data/deserializer/deserializer.dart';
import 'package:groen/data/model/model.dart';

class DeltaDeserializer implements Deserializer<quill.Delta> {
  @override
  Node deserialize(quill.Delta input) => throw UnimplementedError();
}
