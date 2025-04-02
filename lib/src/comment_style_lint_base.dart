import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'comment_space_rule.dart';

PluginBase createPlugin() => _CommentStyleLintPlugin();

class _CommentStyleLintPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
    CommentSpaceRule(),
  ];
}