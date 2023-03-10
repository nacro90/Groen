import 'package:groen/norg/model/model.dart';
import 'package:groen/parser/petit/model.dart';
import 'package:petitparser/petitparser.dart';
import 'package:provider/provider.dart';

import 'grammar.dart';

class PetitNorgParser extends NorgGrammar {
  @override
  Parser start() => super.start().map((value) => const PetitNorgNode(
        type: PetitNorgType.document,
        children: [],
      ));

  // @override
  // Parser document() => super.document().map((value) => null)
}
