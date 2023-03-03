import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON LIST',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'JSON ACTIVITY'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>>? _data;

  Future<void> _loadData() async {
    final jsonStr = await DefaultAssetBundle.of(context).loadString('lib/data.json');
    final jsonData = json.decode(jsonStr);
    setState(() {
      _data = List<Map<String, dynamic>>.from(jsonData['items']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _data == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _data!.length,
        itemBuilder: (context, index) {
          final item = _data![index];
          return ListTile(
            leading: Image.network(item['photo']),
            title: Text(item['user']),
            subtitle: Text(item['message']),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadData,
        tooltip: 'Load Data',
        child: const Icon(Icons.cloud_download),
      ),
    );
  }
}




