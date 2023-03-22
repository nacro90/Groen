import 'package:groen/data/model/document.dart';

abstract class Serializer<T> {
  T serialize(Document document);
}
