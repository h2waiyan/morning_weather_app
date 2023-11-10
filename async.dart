import 'dart:io';

void main() {
  performTask();
}

void performTask() async {
  task1();
  String data2 = await task2();
  task3(data2);
}

void task1() {
  String text1 = "Function 1";
  print("Function 1 is running");
}

Future<String> task2() async {
  String text2 = '';
  Duration three = Duration(seconds: 3);

  await Future.delayed(three, () {
    text2 = "Function 2";
    print("Function 2 is running");
  });

  return text2;
}

void task3(String result) {
  String text3 = "Function 3";
  print("Function 3 is running with data from ${result} <<<<<<<");
}
