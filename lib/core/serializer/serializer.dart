import 'package:groen/core/model/document.dart';

abstract class Serializer {
  String serialize(Document document);
}
