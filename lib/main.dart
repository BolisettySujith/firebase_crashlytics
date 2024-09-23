import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_crashlytics_app/Home2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Firebase Crashlytics"),
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(
                onPressed: () => throw Exception("Exception error test"),
                child: const Text("Throw Test Exception"),
              ),
              TextButton(
                onPressed: () => throw ArgumentError("Argument error", "Argument error test"),
                child: const Text("ArgumentError Exception"),
              ),
              TextButton(
                onPressed: () => throw AssertionError("Assertion Error test"),
                child: const Text("AssertionError Exception"),
              ),
              TextButton(
                onPressed: () => throw const FormatException("Format exception test"),
                child: const Text("FormatException Exception"),
              ),
              TextButton(
                onPressed: () => throw TimeoutException("Timeout exception test"),
                child: const Text("Timeout Exception"),
              ),
              TextButton(
                onPressed: () => throw Exception(),
                child: const Text("Throw Test Exception"),
              ),
              TextButton(
                onPressed: () {
                  try {
                    // Code that might throw an exception
                    throw FormatException('Example synchronous exception');
                  } catch (e, s) {
                    // Log the exception to Crashlytics
                    FirebaseCrashlytics.instance.recordError(e, s);
                  }

                },
                child: const Text("Example synchronous exception"),
              ),
              TextButton(
                onPressed: () {
                  try {
                    // Simulate a network request
                    throw HttpException('Failed to fetch data');
                  } catch (e, s) {
                    // Log the exception to Crashlytics
                    FirebaseCrashlytics.instance.recordError(e, s);
                  }
                },
                child: const Text("Example synchronous exception"),
              ),
              TextButton(
                onPressed: () {
                  try {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Page1()),
                    );
                  } catch (e, s) {
                    FirebaseCrashlytics.instance.recordError(e, s, reason: "main.dart file 97");
                  }

                },
                child: const Text("navigate to page 1"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}