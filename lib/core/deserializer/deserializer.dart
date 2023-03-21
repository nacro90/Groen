import 'package:groen/core/model/model.dart';

abstract class Deserializer<T> {
  Document deserialize(T input);
}

