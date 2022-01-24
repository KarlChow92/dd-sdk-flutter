// Unless explicitly stated otherwise all files in this repository are licensed under the Apache License Version 2.0.
// This product includes software developed at Datadog (https://www.datadoghq.com/).
// Copyright 2019-2022 Datadog, Inc.

enum BatchSize { small, medium, large }
enum UploadFrequency { frequent, average, rare }
enum TrackingConsent { granted, notGranted, pending }
enum DatadogSite { us1, us3, us5, eu1, us1Fed }
enum Verbosity { debug, info, warn, error, none }

class LoggingConfiguration {
  bool sendNetworkInfo;
  bool printLogsToConsole;
  bool bundleWithRum;
  bool bundleWithTrace;

  LoggingConfiguration({
    this.sendNetworkInfo = false,
    this.printLogsToConsole = false,
    this.bundleWithRum = true,
    this.bundleWithTrace = true,
  });

  Map<String, dynamic> encode() {
    return {
      'sendNetworkInfo': sendNetworkInfo,
      'printLogsToConsole': printLogsToConsole,
      'bundleWithRum': bundleWithRum,
      'bundleWithTrace': bundleWithTrace,
    };
  }
}

class TracingConfiguration {
  bool sendNetworkInfo;
  bool bundleWithRum;

  TracingConfiguration({
    this.sendNetworkInfo = false,
    this.bundleWithRum = true,
  });

  Map<String, dynamic> encode() {
    return {
      'sendNetworkInfo': sendNetworkInfo,
      'bundleWithRum': bundleWithRum,
    };
  }
}

class RumConfiguration {
  String applicationId;
  double sampleRate;

  RumConfiguration({
    required this.applicationId,
    this.sampleRate = 100.0,
  });

  Map<String, dynamic> encode() {
    return {
      'applicationId': applicationId,
      'sampleRate': sampleRate,
    };
  }
}

class DdSdkConfiguration {
  String clientToken;
  String env;
  bool nativeCrashReportEnabled;
  DatadogSite? site;
  TrackingConsent trackingConsent;
  BatchSize? batchSize;
  UploadFrequency? uploadFrequency;
  String? customEndpoint;

  LoggingConfiguration? loggingConfiguration;
  TracingConfiguration? tracingConfiguration;
  RumConfiguration? rumConfiguration;

  final Map<String, dynamic> additionalConfig = {};

  DdSdkConfiguration({
    required this.clientToken,
    required this.env,
    required this.trackingConsent,
    this.nativeCrashReportEnabled = false,
    this.site,
    this.uploadFrequency,
    this.batchSize,
    this.customEndpoint,
    this.loggingConfiguration,
    this.tracingConfiguration,
    this.rumConfiguration,
  });

  Map<String, dynamic> encode() {
    return {
      'clientToken': clientToken,
      'env': env,
      'nativeCrashReportEnabled': nativeCrashReportEnabled,
      'site': site?.toString(),
      'batchSize': batchSize?.toString(),
      'uploadFrequency': uploadFrequency?.toString(),
      'trackingConsent': trackingConsent.toString(),
      'customEndpoint': customEndpoint,
      'loggingConfiguration': loggingConfiguration?.encode(),
      'tracingConfiguration': tracingConfiguration?.encode(),
      'rumConfiguration': rumConfiguration?.encode(),
      'additionalConfig': additionalConfig
    };
  }
}