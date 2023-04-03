import 'package:flutter_quill/flutter_quill.dart' as quill;

import 'package:groen/data/model/exception.dart';
import 'package:groen/data/model/model.dart';
import 'package:groen/data/serializer/serializer.dart';

abstract class NodeDeltaSerializer<T extends Node>
    implements Serializer<quill.Delta> {
  const NodeDeltaSerializer();

  quill.Delta serializeNode(T node);

  @override
  quill.Delta serialize(Node node) {
    if (node is! T) {
      throw SerializeException('Node is not a ${T.runtimeType}: $node');
    }
    return serializeNode(node);
  }
}

const nodeSerializerByType = <Type, NodeDeltaSerializer>{
  Document: DocumentDeltaSerializer(),
  Paragraph: ParagraphDeltaSerializer(),
  ParagraphSegment: ParagraphSegmentDeltaSerializer(),
  Url: UrlDeltaSerializer(),
  AttachedModified: AttachedModDeltaSerializer(),
};

quill.Delta serializeChildren(Node node) => node.children!
    .map(serializeWithFallback)
    .reduce((delta1, delta2) => delta1.concat(delta2));

quill.Delta serializeWithFallback(Node node) {
  final serializer = nodeSerializerByType[node.runtimeType];
  if (serializer != null) {
    return serializer.serialize(node);
  }
  return quill.Delta()..insert(node.raw);
}

class DocumentDeltaSerializer extends NodeDeltaSerializer<Document> {
  const DocumentDeltaSerializer();

  @override
  quill.Delta serializeNode(Document node) => serializeChildren(node);
}

class ParagraphDeltaSerializer extends NodeDeltaSerializer<Paragraph> {
  const ParagraphDeltaSerializer();

  @override
  quill.Delta serializeNode(Paragraph node) => serializeChildren(node);
}

class ParagraphSegmentDeltaSerializer
    extends NodeDeltaSerializer<ParagraphSegment> {
  const ParagraphSegmentDeltaSerializer();

  @override
  quill.Delta serializeNode(ParagraphSegment node) => serializeChildren(node);
}

class UrlDeltaSerializer extends NodeDeltaSerializer<Url> {
  const UrlDeltaSerializer();

  @override
  quill.Delta serializeNode(Url node) =>
      quill.Delta()..insert(node.raw, {'link': node.location});
}

class AttachedModDeltaSerializer extends NodeDeltaSerializer<AttachedModified> {
  const AttachedModDeltaSerializer();

  @override
  quill.Delta serializeNode(AttachedModified node) {
    switch (node.type) {
      case AttachedModType.bold:
        return serializeBold(node);
      case AttachedModType.italic:
        return serializeItalic(node);
      case AttachedModType.underline:
        return serializeUnderline(node);
      case AttachedModType.strikethrough:
        return serializeStrikethrough(node);
      case AttachedModType.inlineCode:
        return serializeInlineCode(node);
      case AttachedModType.subscript:
        return serializeSubscript(node);
      case AttachedModType.superscript:
        return serializeSuperscript(node);

      default:
        return serializeUnknownType(node);
    }
  }

  quill.Delta serializeBold(AttachedModified node) =>
      quill.Delta()..insert(node.raw, {'bold': true});

  quill.Delta serializeItalic(AttachedModified node) =>
      quill.Delta()..insert(node.raw, {'italic': true});

  quill.Delta serializeUnderline(AttachedModified node) =>
      quill.Delta()..insert(node.raw, {'underline': true});

  quill.Delta serializeStrikethrough(AttachedModified node) =>
      quill.Delta()..insert(node.raw, {'strike': true});

  quill.Delta serializeInlineCode(AttachedModified node) =>
      quill.Delta()..insert(node.raw, {'code': true});

  quill.Delta serializeSubscript(AttachedModified node) =>
      quill.Delta()..insert(node.raw, {'small': true});

  quill.Delta serializeSuperscript(AttachedModified node) =>
      quill.Delta()..insert(node.raw, {'size': 'huge'});

  quill.Delta serializeUnknownType(AttachedModified node) =>
      quill.Delta()..insert(node.text);
}
