import 'package:groen/data/deserializer/deserializer.dart';
import 'package:groen/data/model/exception.dart';
import 'package:groen/data/model/model.dart';
import 'package:petitparser/petitparser.dart';

class PetitDeserializer implements Deserializer<String> {
  final Parser _parser;

  const PetitDeserializer(this._parser);

  @override
  Node deserialize(String input) {
    final result = _parser.parse(input);
    if (result.isFailure) {
      throw DeserializeException(result.message);
    }
    return result.value;
  }
}
