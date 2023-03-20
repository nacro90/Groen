import 'package:groen/core/model/model.dart';

abstract class Deserializer {
  Document deserialize(String input);
}

