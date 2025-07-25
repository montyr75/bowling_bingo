import 'package:flutter/foundation.dart';

import 'features/app/services/logger_service.dart';

// app info
const appName = "bowling_bingo";
const version = "0.0.3";
const debugMode = !kReleaseMode;

// create logger
final log = LoggerService(appName: appName, debugMode: debugMode);
