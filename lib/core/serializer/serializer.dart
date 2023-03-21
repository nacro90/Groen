import 'package:groen/core/model/document.dart';

abstract class Serializer<T> {
  T serialize(Document document);
}
