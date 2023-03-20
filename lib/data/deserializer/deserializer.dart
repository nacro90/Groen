
import 'package:groen/data/model/document.dart';

abstract class Deserializer {
  Document deserialize(String input);
}

