# untitled1

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Provider state management in flutter Notes :
একদম শুরু থেকে Flutter এ Provider ব্যাবহার করে State Management শিখতে চাইলে নিচের Step-by-Step গাইডটি তোমাকে খুব সাহায্য করবে। প্রতিটি পয়েন্ট বাংলায় ব্যাখ্যা করলাম উদাহরণ সহ।

✅ ১. setState() দিয়ে সাধারন State Management (Basic)
🔹 উদাহরণ:
class MyCounter extends StatefulWidget {
  @override
  _MyCounterState createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Count: $count')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            count++;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

🔸 setState() ছোটখাট স্টেট পরিবর্তনের জন্য উপযুক্ত। কিন্তু বড় অ্যাপ এ এটি ব্যবহার করলে কোড জটিল হয়ে যায়।

✅ ২. Provider Package পরিচিতি
🔹 Provider কি?
Provider হলো Flutter এর official state management package, যেটি Google নিজেই রিকমেন্ড করে।
 এটি ChangeNotifier ব্যবহার করে data ও UI আলাদা করে রাখে।
🔹 Provider ইনস্টল করো pubspec.yaml ফাইলে:
dependencies:
  provider: ^6.1.1


✅ ৩. ChangeNotifier তৈরি ও ব্যবহার
🔹 Step 1: মডেল ক্লাস তৈরি করো
import 'package:flutter/material.dart';

class CounterProvider with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // UI কে জানানো যে state পরিবর্তন হয়েছে
  }
}


✅ ৪. Provider ব্যবহার করে UI তৈরি
🔹 Step 2: main.dart এ ChangeNotifierProvider দিয়ে wrap করো
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CounterProvider(),
      child: MyApp(),
    ),
  );
}


✅ ৫. UI তে Data Access করার ৩ টি উপায়

✅ ১. Consumer Widget দিয়ে
Consumer<CounterProvider>(
  builder: (context, provider, child) {
    return Text('Count: ${provider.count}');
  },
)


✅ ২. Provider.of(context) দিয়ে
Text('Count: ${Provider.of<CounterProvider>(context).count}');

⚠️ এটা UI rebuild করে তাই performance-sensitive জায়গায় সাবধানতার সাথে ব্যবহার করো।

✅ ৩. Selector দিয়ে (Performance Optimization)
Selector<CounterProvider, int>(
  selector: (context, provider) => provider.count,
  builder: (context, value, child) {
    return Text('Count: $value');
  },
)


✅ ৬. MultiProvider ব্যবহার
একাধিক Provider থাকলে এইভাবে লিখো:
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => CounterProvider()),
    ChangeNotifierProvider(create: (_) => AuthProvider()),
  ],
  child: MyApp(),
)


✅ ৭. Local vs Global Provider
🔹 Global Provider:
main.dart এ উপরে wrap করলে এটি পুরো অ্যাপে access করা যাবে।
🔹 Local Provider:
কোনো নির্দিষ্ট widget এর ভিতর যদি শুধু state লাগে, তাহলে শুধু সেই widget এর ভেতর wrap করো।

✅ ৮. Practical Projects যেখানে Provider ব্যবহার করা হয়:
🔹 Counter App ✅
→ উপরের উদাহরণই
🔹 Auth App ✅
Login, Logout এর জন্য AuthProvider


User info রাখতে Provider


🔹 Cart App ✅
CartModel: item add/remove, total price


UI: Consumer/Selector দিয়ে সব update হয়


🔹 Theme Toggle App ✅
Dark Mode / Light Mode পরিবর্তন করতে Provider



✅ Counter App Example (ফুল কোড):
// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CounterProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterPage(),
    );
  }
}

class CounterProvider with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CounterProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Provider Counter")),
      body: Center(child: Text("Count: ${provider.count}", style: TextStyle(fontSize: 25))),
      floatingActionButton: FloatingActionButton(
        onPressed: provider.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}

✅ context.read vs context.watch vs context.select
Method
Purpose
Rebuilds UI?
Use For
context.read<T>()
Data or method access
❌ No
Write / Action
context.watch<T>()
Listens to changes
✅ Yes
Read / UI update
context.select<T, R>()
Listens to selected field
✅ Optimized
Read specific field

✅ Example Summary:
dart
// READ + REBUILD UI
Text('${context.watch<CounterProvider>().count}')

// WRITE without rebuild
onPressed: () {
  context.read<CounterProvider>().increment();
}
✅ Extra: Theme Toggle Example
dart

Switch(
  value: context.watch<ThemeProvider>().isDark,
  onChanged: (_) {
    context.read<ThemeProvider>().toggleTheme(); // Write ✅
  },
)
✅ উপসংহার:
context.read() → Provider থেকে data/method access করে, কিন্তু rebuild করে না


context.watch() → Rebuild করে, UI তে ব্যবহার হয়


Performance ও readability বাড়াতে, read/write ভিন্নভাবে handle করো



✅ উপসংহার:
বিষয়
বিস্তারিত
🎯 শুরু
ছোট অ্যাপে setState
📦 Provider
বড় অ্যাপের জন্য - clean ও scalable
🔁 UI Update
notifyListeners() ব্যবহার করে


🧠 Performance
Selector, Consumer smart ভাবে ব্যবহার করো
