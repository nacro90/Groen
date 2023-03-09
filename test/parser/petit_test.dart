import 'package:flutter_test/flutter_test.dart';
import 'package:groen/parser/petit.dart';
import 'package:petitparser/petitparser.dart';
import 'package:petitparser/reflection.dart';

bool Function(String) accept(Parser parser) =>
    (input) => parser.parse(input).isSuccess;

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
    group('attached modifiers', () {
      test('bold', () {
        final parser = grammar.build(start: grammar.bold);
        expect('*bold*', accept(parser));
        expect('*bold with  whitespace*', accept(parser));
        expect('**', isNot(accept(parser)));
        expect('* succeded whitespace*', isNot(accept(parser)));
        // expect('*preceded whitespace *', isNot(accept(parser)));
      });
      test('italic', () {
        final parser = grammar.build(start: grammar.italic);
        expect('/italic/', accept(parser));
        expect('/italic with  whitespace/', accept(parser));
        expect('//', isNot(accept(parser)));
        expect('/ succeded whitespace/', isNot(accept(parser)));
        // expect( '/preceded whitespace /', isNot(accept(parser)));
      });
      test('underline', () {
        final parser = grammar.build(start: grammar.underline);
        expect('_underline_', accept(parser));
        expect('_underline with  whitespace_', accept(parser));
        expect('__', isNot(accept(parser)));
        expect('_ succeded whitespace_', isNot(accept(parser)));
        // expect( '_preceded whitespace _', isNot(accept(parser)));
      });
      test('strikethrough', () {
        final parser = grammar.build(start: grammar.strikethrough);
        expect('-strikethrough-', accept(parser));
        expect('-strikethrough with  whitespace-', accept(parser));
        expect('--', isNot(accept(parser)));
        expect('- succeded whitespace-', isNot(accept(parser)));
        // expect( '-preceded whitespace -', isNot(accept(parser)));
      });
      test('spoiler', () {
        final parser = grammar.build(start: grammar.spoiler);
        expect('!spoiler!', accept(parser));
        expect('!spoiler with  whitespace!', accept(parser));
        expect('!!', isNot(accept(parser)));
        expect('! succeded whitespace!', isNot(accept(parser)));
        // expect( '!preceded whitespace !', isNot(accept(parser)));
      });
      test('superscript', () {
        final parser = grammar.build(start: grammar.superscript);
        expect('^superscript^', accept(parser));
        expect('^superscript with  whitespace^', accept(parser));
        expect('^^', isNot(accept(parser)));
        expect('^ succeded whitespace^', isNot(accept(parser)));
        // expect( '^preceded whitespace ^', isNot(accept(parser)));
      });
      test('subscript', () {
        final parser = grammar.build(start: grammar.subscript);
        expect(',subscript,', accept(parser));
        expect(',subscript with  whitespace,', accept(parser));
        expect(',,', isNot(accept(parser)));
        expect(', succeded whitespace,', isNot(accept(parser)));
        // expect( ',preceded whitespace ,', isNot(accept(parser)));
      });
      test('inlineCode', () {
        final parser = grammar.build(start: grammar.inlineCode);
        expect('`inlineCode`', accept(parser));
        expect('`inlineCode with  whitespace`', accept(parser));
        expect('``', isNot(accept(parser)));
        expect('` succeded whitespace`', isNot(accept(parser)));
        // expect( '`preceded whitespace `'` isNot(accept(parser)));
      });
      test('inlineComment', () {
        final parser = grammar.build(start: grammar.inlineComment);
        expect('%inlineComment%', accept(parser));
        expect('%inlineComment with  whitespace%', accept(parser));
        expect('%%', isNot(accept(parser)));
        expect('% succeded whitespace%', isNot(accept(parser)));
        // expect( '%preceded whitespace %'% isNot(accept(parser)));
      });
    });
    group('link', () {
      test('url', () {
        final parser = grammar.build(start: grammar.url);
        expect('{http://www.test.com}', accept(parser));
        expect('{}', isNot(accept(parser)));
      });
    });
  });
}
