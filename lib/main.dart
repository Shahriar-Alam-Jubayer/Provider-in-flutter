import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/counter_provider.dart';
import 'package:untitled1/list_map_provider.dart';
import 'package:untitled1/list_page.dart';
import 'package:untitled1/theme_provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CounterProvider()),
          ChangeNotifierProvider(create: (_) => ListMapProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: MyApp(),
      )
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
      ),
      themeMode: themeProvider.currentTheme, // ✅ handled by provider
      home: ListPage(),
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterProvider>(context); // Provider access
    print("called build function");

    return Scaffold(
      appBar: AppBar(title: const Text("Counter with Provider")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'আপনার সংখ্যা:',
              style: TextStyle(fontSize: 22),
            ),
            Text(
              '${counter.count}',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: counter.incrementCount,
                  child: const Text("➕ বাড়াও"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: counter.decrementCount,
                  child: const Text("➖ কমাও"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: counter.reset,
                  child: const Text("🔁 রিসেট"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}