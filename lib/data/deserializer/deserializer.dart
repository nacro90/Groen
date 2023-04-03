import 'package:groen/data/model/model.dart';

export 'petit/petit.dart';

abstract class Deserializer<T> {
  Node deserialize(T input);
}

