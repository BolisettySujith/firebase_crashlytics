import 'dart:async';

import 'package:flutter/material.dart';


class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home page 2"),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () => throw Exception("Exception error test1"),
            child: const Text("Throw Test Exception"),
          ),
          TextButton(
            onPressed: () => throw ArgumentError("Argument error", "Argument error test1"),
            child: const Text("ArgumentError Exception"),
          ),
          TextButton(
            onPressed: () => throw AssertionError("Assertion Error test1"),
            child: const Text("AssertionError Exception"),
          ),
          TextButton(
            onPressed: () => throw const FormatException("Format exception test1"),
            child: const Text("FormatException Exception"),
          ),
          TextButton(
            onPressed: () => throw TimeoutException("Timeout exception test1"),
            child: const Text("Timeout Exception"),
          ),
          TextButton(
            onPressed: () => throw Exception(),
            child: const Text("Throw Test Exception1"),
          ),

        ],
      ),
    );
  }
}
