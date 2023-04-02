import 'package:groen/data/model/model.dart';
import 'package:groen/data/serializer/serializer.dart';

class StringSerializer implements Serializer<String> {
  @override
  String serialize(Node node) => node.raw;
}
