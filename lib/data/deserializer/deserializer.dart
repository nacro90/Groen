import 'package:groen/data/model/model.dart';

abstract class Deserializer<T> {
  Node deserialize(T input);
}

