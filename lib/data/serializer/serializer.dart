import 'package:groen/data/model/document.dart';

abstract class Serializer {
  String serialize(Document document);
}
