import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:flutter_js/javascript_runtime.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JSConfig(),
    );
  }
}

class JSConfig extends StatefulWidget {
  const JSConfig({Key? key}) : super(key: key);

  @override
  State<JSConfig> createState() => _JSConfigState();
}

class _JSConfigState extends State<JSConfig> {
  int counter = 0;
  JavascriptRuntime runtime = getJavascriptRuntime();
  final _num1Controller = TextEditingController();
  final _num2Controller = TextEditingController();

  dynamic path = rootBundle.loadString("assets/file.js");

  @override
  Widget build(BuildContext context) {
    Color c = Theme.of(context).primaryColor;

    return Scaffold(
        appBar: AppBar(
          title: const Text("JS with Flutter"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _num1Controller,
                  decoration: InputDecoration(
                      label: Text("Num1"),
                      hintText: "Enter first number",
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _num2Controller,
                  decoration: InputDecoration(
                      label: Text("Num2"),
                      hintText: "Enter second number",
                      border: OutlineInputBorder()
                  ),

                ),
              ),
              Text(
                counter.toString(),
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                  onPressed: () async {
                    final result = await additionFn(runtime, int.parse(_num1Controller.text.toString()), int.parse(_num2Controller.text.toString()));

                    setState(() {
                      counter = result as int;
                    });
                  },
                  child: Text("Add")),


              ElevatedButton(
                  onPressed: () async {
                    final result = await substractionFn(runtime, int.parse(_num1Controller.text.toString()), int.parse(_num2Controller.text.toString()));

                    setState(() {
                      counter = result as int;
                    });
                  },
                  child: Text("Sub")),

              ElevatedButton(
                  onPressed: () async {
                    final result = await multiplicationFn(runtime, int.parse(_num1Controller.text.toString()), int.parse(_num2Controller.text.toString()));

                    setState(() {
                      counter = result as int;
                    });
                  },
                  child: Text("Mul")),

              ElevatedButton(
                  onPressed: () async {
                    final result = await divisionFn(runtime, int.parse(_num1Controller.text.toString()), int.parse(_num2Controller.text.toString()));

                    setState(() {
                      counter = result as int;
                    });
                  },
                  child: Text("Div")),
            ],
          ),
        ));
  }

  dynamic additionFn(JavascriptRuntime runtime, int v1, int v2) async {
    final jsFile = await path;

    JsEvalResult jsEvalResult =
    runtime.evaluate("""${jsFile}addition($v1, $v2)""");

    return int.parse(jsEvalResult.stringResult);
  }

  dynamic substractionFn(JavascriptRuntime runtime, int v1, int v2) async {
    final jsFile = await path;

    JsEvalResult jsEvalResult =
    runtime.evaluate("""${jsFile}subtraction($v1, $v2)""");

    return int.parse(jsEvalResult.stringResult);
  }

  dynamic multiplicationFn(JavascriptRuntime runtime, int v1, int v2) async {
    final jsFile = await path;

    JsEvalResult jsEvalResult =
    runtime.evaluate("""${jsFile}multiplication($v1, $v2)""");

    return int.parse(jsEvalResult.stringResult);
  }

  dynamic divisionFn(JavascriptRuntime runtime, int v1, int v2) async {
    final jsFile = await path;

    JsEvalResult jsEvalResult =
    runtime.evaluate("""${jsFile}division($v1, $v2)""");

    return int.parse(jsEvalResult.stringResult);
  }
}