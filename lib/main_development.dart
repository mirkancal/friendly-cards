// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:friendly_cards/app/app.dart';
import 'package:friendly_cards/app/app_bloc_observer.dart';
import 'package:friendly_cards/app/app_development.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runZonedGuarded(
    () => runApp(DevicePreview(
        enabled: !kReleaseMode, builder: (context) => const AppDevelopment())),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
