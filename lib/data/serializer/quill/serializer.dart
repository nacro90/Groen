import 'package:flutter_quill/flutter_quill.dart' as quill;

import 'package:groen/data/model/model.dart';
import 'package:groen/data/serializer/serializer.dart';

import 'node.dart';

class QuillDeltaSerializer implements Serializer<quill.Delta> {
  const QuillDeltaSerializer();

  @override
  quill.Delta serialize(Node node) => serializeWithFallback(node);
}
