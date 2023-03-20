import 'package:flutter_test/flutter_test.dart';
import 'package:groen/core/deserializer/petit/grammar.dart';
import 'package:petitparser/debug.dart';
import 'package:petitparser/petitparser.dart';
import 'package:petitparser/reflection.dart';

bool Function(String) accept(Parser parser, {bool tracing = false}) =>
    (input) => (tracing ? trace(parser) : parser).parse(input).isSuccess;

void main() {
  group('NorgGrammar', () {
    late NorgGrammar grammar;
    late Parser parser;
    setUp(() {
      grammar = NorgGrammar();
      parser = grammar.build();
    });
    test('should detect common problems', () {
      expect(linter(parser), isEmpty);
    });
    group('units', () {
      group('attached modifiers', () {
        test('bold', () {
          final parser = grammar.build(start: grammar.bold);
          expect('*bold*', accept(parser));
          expect('*bold with  whitespace*', accept(parser));
          expect('*bold with\nnewline*', accept(parser));
          expect('*bold with\n\nnewline*', isNot(accept(parser)));
          expect('**', isNot(accept(parser)));
          expect('* succeded whitespace*', isNot(accept(parser)));
          expect('*preceded whitespace *', isNot(accept(parser)));
        });
        test('italic', () {
          final parser = grammar.build(start: grammar.italic);
          expect('/italic/', accept(parser));
          expect('/italic with  whitespace/', accept(parser));
          expect('/italic with\nnewline/', accept(parser));
          expect('/italic with\n\nnewline/', isNot(accept(parser)));
          expect('//', isNot(accept(parser)));
          expect('/ succeded whitespace/', isNot(accept(parser)));
          expect('/preceded whitespace /', isNot(accept(parser)));
        });
        test('underline', () {
          final parser = grammar.build(start: grammar.underline);
          expect('_underline_', accept(parser));
          expect('_underline with  whitespace_', accept(parser));
          expect('_underline with\nnewline_', accept(parser));
          expect('_underline with\n\nnewline_', isNot(accept(parser)));
          expect('__', isNot(accept(parser)));
          expect('_ succeded whitespace_', isNot(accept(parser)));
          expect('_preceded whitespace _', isNot(accept(parser)));
        });
        test('strikethrough', () {
          final parser = grammar.build(start: grammar.strikethrough);
          expect('-strikethrough-', accept(parser));
          expect('-strikethrough with  whitespace-', accept(parser));
          expect('-strikethrough with\nnewline-', accept(parser));
          expect('-strikethrough with\n\nnewline-', isNot(accept(parser)));
          expect('--', isNot(accept(parser)));
          expect('- succeded whitespace-', isNot(accept(parser)));
          expect('-preceded whitespace -', isNot(accept(parser)));
        });
        test('spoiler', () {
          final parser = grammar.build(start: grammar.spoiler);
          expect('!spoiler!', accept(parser));
          expect('!spoiler with  whitespace!', accept(parser));
          expect('!spoiler with\nnewline!', accept(parser));
          expect('!spoiler with\n\nnewline!', isNot(accept(parser)));
          expect('!!', isNot(accept(parser)));
          expect('! succeded whitespace!', isNot(accept(parser)));
          expect('!preceded whitespace !', isNot(accept(parser)));
        });
        test('superscript', () {
          final parser = grammar.build(start: grammar.superscript);
          expect('^superscript^', accept(parser));
          expect('^superscript with  whitespace^', accept(parser));
          expect('^superscript with\nnewline^', accept(parser));
          expect('^superscript with\n\nnewline^', isNot(accept(parser)));
          expect('^^', isNot(accept(parser)));
          expect('^ succeded whitespace^', isNot(accept(parser)));
          expect('^preceded whitespace ^', isNot(accept(parser)));
        });
        test('subscript', () {
          final parser = grammar.build(start: grammar.subscript);
          expect(',subscript,', accept(parser));
          expect(',subscript with  whitespace,', accept(parser));
          expect(',subscript with\nnewline,', accept(parser));
          expect(',subscript with\n\nnewline,', isNot(accept(parser)));
          expect(',,', isNot(accept(parser)));
          expect(', succeded whitespace,', isNot(accept(parser)));
          expect(',preceded whitespace ,', isNot(accept(parser)));
        });
        test('inlineCode', () {
          final parser = grammar.build(start: grammar.inlineCode);
          expect('`inlineCode`', accept(parser));
          expect('`inlineCode with  whitespace`', accept(parser));
          expect('`inlineCode with\nnewline`', accept(parser));
          expect('`inlineCode with\n\nnewline`', isNot(accept(parser)));
          expect('``', isNot(accept(parser)));
          expect('` succeded whitespace`', isNot(accept(parser)));
          expect('`preceded whitespace `', isNot(accept(parser)));
        });
        test('inlineComment', () {
          final parser = grammar.build(start: grammar.inlineComment);
          expect('%inlineComment%', accept(parser));
          expect('%inlineComment with  whitespace%', accept(parser));
          expect('%inlineComment with\nnewline%', accept(parser));
          expect('%inlineComment with\n\nnewline%', isNot(accept(parser)));
          expect('%%', isNot(accept(parser)));
          expect('% succeded whitespace%', isNot(accept(parser)));
          expect('%preceded whitespace %', isNot(accept(parser)));
        });
      });

      group('link', () {
        test('url', () {
          final parser = grammar.build(start: grammar.url);
          expect('{http://www.test.com}', accept(parser));
          expect('{http://www\n.test.com}', accept(parser));
          expect('{http://www\n\n.test.com}', isNot(accept(parser)));
          expect('{\nhttp://www.test.com}', isNot(accept(parser)));
          expect('{http://www.test.com\n}', isNot(accept(parser)));
          expect('{  tnueshotn utnuho}', accept(parser));
        });
      });

      test('escaping', () {
        final parser = grammar.build(start: grammar.escaping);
        expect('\\*', accept(parser));
        expect('\\\n', accept(parser));
        expect('\\\\', accept(parser));
      });

      group('paragraph segment', () {
        late Parser parser;
        setUp(() {
          parser = grammar.build(start: grammar.paragraphSegment);
        });
        test('attached modifiers', () {
          expect('test1 test2  test3 *bold* /italic/', accept(parser));
        });
        test('escaping', () {
          expect('\\*\n', accept(parser));
          expect('\\*bold* test', accept(parser));
        });
      });

      test('paragraph', () {
        final parser = grammar.build(start: grammar.paragraph);
        expect('{test1}\ntest2  *test3*\ttest4', accept(parser));
      });

      test('document', () {
        final parser = grammar.build(start: grammar.document);
        expect('{test1}\ntest2  *test3*\ttest4\n\n/italic/ bold _htun_\n\n', accept(parser));
      });
    });
  });
}
