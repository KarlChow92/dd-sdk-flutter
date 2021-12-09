import 'package:datadog_sdk/pigeon.dart';

import './datadog_sdk_platform_interface.dart';

import './version.dart' show ddSdkVersion;

// class DdSdkConfiguration {
//   final String clientToken;
//   final String env;
//   final String? applicationId;
//   final bool nativeCrashReportEnabled;
//   final double sampleRate;
//   final String? site;
//   final String? trackingConsent;
//   final Map<String, dynamic> additionalConfig = {};

//   DdSdkConfiguration({
//     required this.clientToken,
//     required this.env,
//     this.applicationId,
//     this.nativeCrashReportEnabled = false,
//     this.sampleRate = 100.0,
//     this.site,
//     this.trackingConsent,
//   });

//   Map<String, dynamic> encode() {
//     return {
//       'clientToken': clientToken,
//       'env': env,
//       'applicationId': applicationId,
//       'nativeCrashReportEnabled': nativeCrashReportEnabled,
//       'sampleRate': sampleRate,
//       'site': site,
//       'trackingConsent': trackingConsent,
//       'additionalConfig': additionalConfig
//     };
//   }
// }

class _DatadogConfigKey {
  static const source = '_dd.source';
  static const version = '_dd.sdk_version';
}

class DatadogSdk {
  static DatadogSdkPlatform get _platform {
    return DatadogSdkPlatform.instance;
  }

  static DatadogSdk? _singleton;
  factory DatadogSdk() {
    _singleton ??= DatadogSdk._();
    return _singleton!;
  }

  DatadogSdk._();

  Future<void> initialize(DdSdkConfiguration configuration) {
    configuration.additionalConfig ??= {};
    //configuration.additionalConfig![_DatadogConfigKey.source] = 'flutter';
    configuration.additionalConfig![_DatadogConfigKey.version] = ddSdkVersion;

    return _platform.initialize(configuration);
  }

  DdLogs get ddLogs => _platform.ddLogs;
}
