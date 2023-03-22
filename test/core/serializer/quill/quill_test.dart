import 'package:flutter_test/flutter_test.dart';
import 'package:groen/data/model/model.dart';
import 'package:groen/data/serializer/quill/quill.dart';

void main() {
  group('DeltaSerializer', () {
    late DeltaSerializer serializer;
    setUp(() {
      serializer = DeltaSerializer();
    });
    test('serialize document', () {
      const doc = Document(raw: "test document", range: Range(0, 5), elements: []);
      final d = serializer.serialize(doc);
      print(d.toJson());
    });
  });
}
