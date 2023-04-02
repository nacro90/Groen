import 'package:groen/data/model/model.dart';

abstract class Serializer<T> {
  T serialize(Node node);
}
