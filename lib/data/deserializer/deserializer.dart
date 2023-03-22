import 'package:groen/data/model/model.dart';

abstract class Deserializer<T> {
  Document deserialize(T input);
}

