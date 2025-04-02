import 'package:analyzer/error/listener.dart';
import 'package:analyzer/error/error.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'lint_visitor.dart';

class CommentSpaceRule extends DartLintRule {
  CommentSpaceRule()
      : super(
          code: LintCode(
            name: 'comment_space_required',
            problemMessage: 'A space is required after comment symbols',
            correctionMessage: 'Add a space after // in the comment',
          ),
        );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addCompilationUnit((node) {
      final visitor = CommentSpaceVisitor(reporter, this.code);
      node.accept(visitor);
    });
  }

  @override
  List<Fix> getFixes() => [_CommentSpaceFix()];
}

class _CommentSpaceFix extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError error,
    List<AnalysisError> errors,
  ) {
    context.registry.addCompilationUnit((node) {
      final text = resolver.source.contents.data;
      final lineInfo = resolver.lineInfo;
      final startOffset = error.offset;
      final lineNumber = lineInfo.getLocation(startOffset).lineNumber;
      final lineOffset = lineInfo.getOffsetOfLine(lineNumber - 1);

      final line = text.substring(
        lineOffset,
        text.indexOf('\n', lineOffset) != -1 ? text.indexOf('\n', lineOffset) : text.length,
      );

      final commentIndex = line.indexOf('//');
      if (commentIndex != -1 && commentIndex + 2 < line.length && line[commentIndex + 2] != ' ') {
        final builder = reporter.createChangeBuilder(
          message: 'Add space after //',
          priority: 80,
        );

        builder.addDartFileEdit((builder) {
          builder.addSimpleInsertion(lineOffset + commentIndex + 2, ' ');
        });
      }
    });
  }
}
