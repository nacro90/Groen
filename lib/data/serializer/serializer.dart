import 'package:groen/data/model/model.dart';

export 'quill/quill.dart';

abstract class Serializer<T> {
  T serialize(Node node);
}
