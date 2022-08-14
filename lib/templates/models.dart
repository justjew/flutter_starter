const String apiText = '''import 'package:shindenshin/shindenshin.dart';
import '&snakeName&.dart';

class &upperName&Api extends BaseModelApi<&upperName&> {
  @override
  String get url => '&snakeName&s';

  &upperName&Api(BaseApiClient apiClient, BaseModelParser<&upperName&> parser) : super(apiClient, parser);
}
''';

const String exportText = '''export '&snakeName&_api.dart';
export '&snakeName&.dart';
export '&snakeName&_parser.dart';
''';

const String modelText = '''import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shindenshin/shindenshin.dart';
&relatedImports&
part '&snakeName&.freezed.dart';
part '&snakeName&.g.dart';

@freezed
class &upperName& extends BaseModel with _\$&upperName& {
  const factory &upperName&({
    required dynamic id,
&fields&
  }) = _&upperName&;

  factory &upperName&.fromJson(Map<String, Object?> json) => _\$&upperName&FromJson(json);
}
''';

const String parserText = '''import 'package:shindenshin/shindenshin.dart';
import '&snakeName&.dart';

class &upperName&Parser extends BaseModelParser<&upperName&> {
  @override
  &upperName& fromJson(Map<String, Object?> json) {
    return &upperName&.fromJson(json);
  }
}
''';