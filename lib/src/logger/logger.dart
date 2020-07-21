library logger;

import 'package:logger/logger.dart';

//for logging
Logger getLogger() {
  return Logger(printer: PrettyPrinter());
}
