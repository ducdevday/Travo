import 'package:flutter/material.dart';

import 'bloc/counter_bloc.dart';

class CounterPage extends StatefulWidget {

  CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final CounterBloc _counterBloc = CounterBloc(initialCount: 0);

  @override
  void dispose() {
    super.dispose();
    _counterBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Counter"),),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              StreamBuilder(
                  stream: _counterBloc.counterStream,
                  builder: (context, AsyncSnapshot<int> snapshot) {
                    return Text(snapshot.data.toString());
                  })
            ],
          ),
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                onPressed: _counterBloc.increment,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              )),
          FloatingActionButton(
            onPressed: _counterBloc.decrement,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ]));
  }
}
