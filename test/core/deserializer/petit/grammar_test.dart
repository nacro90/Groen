import 'package:flutter_test/flutter_test.dart';
import 'package:groen/data/deserializer/petit/grammar.dart';
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
      grammar = const NorgGrammar();
      parser = grammar.build();
    });
    test('should detect common problems', () {
      expect(linter(parser), isEmpty);
    });
    group('units', () {
      group('attached modifiers', () {
        test('bold', () {
          final parser = grammar.build(start: grammar.bold).end();
          expect('*bold*', accept(parser));
          expect('*bold with  whitespace*', accept(parser));
          expect('*bold with\nnewline*', accept(parser));
          expect('*bold with\n\nnewline*', isNot(accept(parser)));
          expect('**', isNot(accept(parser)));
          expect('* succeded whitespace*', isNot(accept(parser)));
          expect('*preceded whitespace *', isNot(accept(parser)));
          expect('c*preceded whitespace *', isNot(accept(parser)));
        });
        test('italic', () {
          final parser = grammar.build(start: grammar.italic).end();
          expect('/italic/', accept(parser));
          expect('/italic with  whitespace/', accept(parser));
          expect('/italic with\nnewline/', accept(parser));
          expect('/italic with\n\nnewline/', isNot(accept(parser)));
          expect('//', isNot(accept(parser)));
          expect('/ succeded whitespace/', isNot(accept(parser)));
          expect('/preceded whitespace /', isNot(accept(parser)));
        });
        test('underline', () {
          final parser = grammar.build(start: grammar.underline).end();
          expect('_underline_', accept(parser));
          expect('_underline with  whitespace_', accept(parser));
          expect('_underline with\nnewline_', accept(parser));
          expect('_underline with\n\nnewline_', isNot(accept(parser)));
          expect('__', isNot(accept(parser)));
          expect('_ succeded whitespace_', isNot(accept(parser)));
          expect('_preceded whitespace _', isNot(accept(parser)));
        });
        test('strikethrough', () {
          final parser = grammar.build(start: grammar.strikethrough).end();
          expect('-strikethrough-', accept(parser));
          expect('-strikethrough with  whitespace-', accept(parser));
          expect('-strikethrough with\nnewline-', accept(parser));
          expect('-strikethrough with\n\nnewline-', isNot(accept(parser)));
          expect('--', isNot(accept(parser)));
          expect('- succeded whitespace-', isNot(accept(parser)));
          expect('-preceded whitespace -', isNot(accept(parser)));
        });
        test('spoiler', () {
          final parser = grammar.build(start: grammar.spoiler).end();
          expect('!spoiler!', accept(parser));
          expect('!spoiler with  whitespace!', accept(parser));
          expect('!spoiler with\nnewline!', accept(parser));
          expect('!spoiler with\n\nnewline!', isNot(accept(parser)));
          expect('!!', isNot(accept(parser)));
          expect('! succeded whitespace!', isNot(accept(parser)));
          expect('!preceded whitespace !', isNot(accept(parser)));
        });
        test('superscript', () {
          final parser = grammar.build(start: grammar.superscript).end();
          expect('^superscript^', accept(parser));
          expect('^superscript with  whitespace^', accept(parser));
          expect('^superscript with\nnewline^', accept(parser));
          expect('^superscript with\n\nnewline^', isNot(accept(parser)));
          expect('^^', isNot(accept(parser)));
          expect('^ succeded whitespace^', isNot(accept(parser)));
          expect('^preceded whitespace ^', isNot(accept(parser)));
        });
        test('subscript', () {
          final parser = grammar.build(start: grammar.subscript).end();
          expect(',subscript,', accept(parser));
          expect(',subscript with  whitespace,', accept(parser));
          expect(',subscript with\nnewline,', accept(parser));
          expect(',subscript with\n\nnewline,', isNot(accept(parser)));
          expect(',,', isNot(accept(parser)));
          expect(', succeded whitespace,', isNot(accept(parser)));
          expect(',preceded whitespace ,', isNot(accept(parser)));
        });
        test('inlineCode', () {
          final parser = grammar.build(start: grammar.inlineCode).end();
          expect('`inlineCode`', accept(parser));
          expect('`inlineCode with  whitespace`', accept(parser));
          expect('`inlineCode with\nnewline`', accept(parser));
          expect('`inlineCode with\n\nnewline`', isNot(accept(parser)));
          expect('``', isNot(accept(parser)));
          expect('` succeded whitespace`', isNot(accept(parser)));
          expect('`preceded whitespace `', isNot(accept(parser)));
        });
        test('inlineComment', () {
          final parser = grammar.build(start: grammar.inlineComment).end();
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
          final parser = grammar.build(start: grammar.url).end();
          expect('{http://www.test.com}', accept(parser));
          expect('{http://www\n.test.com}', accept(parser));
          expect('{http://www\n\n.test.com}', isNot(accept(parser)));
          expect('{\nhttp://www.test.com}', isNot(accept(parser)));
          expect('{http://www.test.com\n}', isNot(accept(parser)));
          expect('{  tnueshotn utnuho}', accept(parser));
        });
      });

      test('escaping', () {
        final parser = grammar.build(start: grammar.escaping).end();
        expect('\\*', accept(parser));
        expect('\\\n', accept(parser));
        expect('\\\\', accept(parser));
      });

      group('paragraph segment', () {
        late Parser parser;
        setUp(() {
          parser = grammar.build(start: grammar.paragraphSegment).end();
        });
        test('attached modifiers', () {
          expect('test1 test2  test3 *bold* /italic/', accept(parser));
        });
        test('escaping', () {
          expect('\\*', accept(parser));
          expect('\\*bold* test', accept(parser));
          expect('\n', isNot(accept(parser)));
          expect('\n\n', isNot(accept(parser)));
        });
      });

      test('paragraph', () {
        final parser = grammar.build(start: grammar.paragraph).end();
        expect('{test1}\ntest2  *test3*\ttest4', accept(parser));
        expect('test', accept(parser));
        expect('test\n', isNot(accept(parser)));
      });

      test('document', () {
        final parser = grammar.build(start: grammar.document).end();
        expect('{test1}\ntest2  *test3*\ttest4\n\n/italic/ bold _htun_\n\n',
            accept(parser));
        expect('test', accept(parser));
        expect('  test   ', accept(parser));
        expect('test\n', accept(parser));
      });

      test('norgWhitespace', () {
        final parser = grammar.build(start: grammar.norgWhitespace).end();
        expect(' ', accept(parser));
        expect('    ', accept(parser));
        expect('\t', accept(parser));
        expect(' \t ', accept(parser));
        expect('\n', isNot(accept(parser)));
      });

      test('plainText', () {
        final parser = grammar.build(start: grammar.plainText).end();
        expect('test', accept(parser));
        expect('\n', isNot(accept(parser)));
        expect('*', accept(parser));
        expect('\\', accept(parser));
      });

      test('paragraphBreak', () {
        final parser = grammar.build(start: grammar.paragraphBreak).end();
        expect('\n\n', accept(parser));
        expect('\n\t \n', accept(parser));
        expect('\n  \n\t\n', accept(parser));
        expect('\n\n\n  ', isNot(accept(parser)));
      });

      test('precedence', () {
        // TODO: improve
        final parser = grammar.build(start: grammar.paragraphSegment).end();
        expect('{t*est} *', accept(parser));
      });
    });
  });
}
