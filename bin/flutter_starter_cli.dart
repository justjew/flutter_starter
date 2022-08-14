import 'package:flutter_starter_cli/config/config.dart';
import 'package:flutter_starter_cli/config/config_reader.dart';
import 'package:flutter_starter_cli/exceptions.dart';
import 'package:flutter_starter_cli/runner.dart';

Future<void> main(List<String> _) async {
  try {
    final Config config = ConfigReader().read();
    await Runner(config).init();
  } on ConfigNotExist catch (_) {
    print('Example config file was created. Fill it and re-run the command.');
  } on ProgressError catch (error) {
    print(error.message);
  }
}
