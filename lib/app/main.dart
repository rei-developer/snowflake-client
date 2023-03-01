import 'package:flutter/material.dart';
import 'package:snowflake_client/init/app.init.dart';
import 'package:snowflake_client/network/tcp_connection.dart';
import 'package:snowflake_client/utils/json_to_binary.util.dart';

void main() => AppInit().run();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TcpConnection? _connection;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final connection = TcpConnection('127.0.0.1', 8080);
      await connection.connect();
      setState(() => _connection = connection);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              MaterialButton(
                color: Colors.pink,
                child: Text('send'),
                onPressed: () {
                  _connection?.sendMessage(
                    1,
                    jsonToBinary({"test": 'hi'}),
                  );
                },
              ),
              MaterialButton(
                color: Colors.blue,
                child: Text('send'),
                onPressed: () {
                  _connection?.sendMessage(
                    2,
                    jsonToBinary({"bye": 23423}),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Close',
        child: const Icon(Icons.close),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
