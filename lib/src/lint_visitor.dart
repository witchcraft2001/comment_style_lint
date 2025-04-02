import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class CommentSpaceVisitor extends RecursiveAstVisitor<void> {
  final ErrorReporter _reporter;
  final LintCode _code;

  CommentSpaceVisitor(this._reporter, this._code);

  @override
  void visitCompilationUnit(CompilationUnit node) {
    final lineInfo = node.lineInfo;
    final commentTokens = _getCommentTokens(node.beginToken);

    for (var commentToken in commentTokens) {
      final lexeme = commentToken.lexeme;
      if (lexeme.startsWith('//') && !lexeme.startsWith('// ') && !lexeme.startsWith('///')) {
        final location = lineInfo.getLocation(commentToken.offset);
        _reporter.reportErrorForOffset(
          _code,
          commentToken.offset,
          2, // длина //
        );
      }
    }

    super.visitCompilationUnit(node);
  }

  List<Token> _getCommentTokens(Token token) {
    final comments = <Token>[];

    Token? commentToken = token.precedingComments;
    while (commentToken != null) {
      comments.add(commentToken);
      commentToken = commentToken.next;
    }

    Token? current = token;
    while (current != null && current.type != TokenType.EOF) {
      commentToken = current.precedingComments;
      while (commentToken != null) {
        comments.add(commentToken);
        commentToken = commentToken.next;
      }

      current = current.next;
    }

    return comments;
  }
}