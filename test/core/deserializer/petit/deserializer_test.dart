import 'package:flutter_test/flutter_test.dart';
import 'package:groen/data/deserializer/petit/petit.dart';
import 'package:groen/data/model/exception.dart';
import 'package:groen/data/model/model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:petitparser/petitparser.dart';

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks([
  MockSpec<Parser>(unsupportedMembers: {#captureResultGeneric}),
])
import 'deserializer_test.mocks.dart';

void main() {
  group('PetitDeserializer', () {

    test('successful parse', () {
      final parser = MockParser();
      const success = Success('', 0, Document.empty());
      when(parser.parse('')).thenReturn(success);
      final deserializer = PetitDeserializer(parser);

      final actual = deserializer.deserialize('');

      expect(actual, const Document.empty());
    });

    test('parse failure', () {
      final parser = MockParser();
      const failure = Failure('', 0, 'parse error msg');
      when(parser.parse('')).thenReturn(failure);
      final deserializer = PetitDeserializer(parser);

      expect(() => deserializer.deserialize(''),
          throwsA(isA<DeserializeException>()));
    });
  });
}
