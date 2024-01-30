import 'package:flutter/material.dart';
import 'package:my_project/app/issues/w3_d2/search/bloc/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchBloc _searchBloc = SearchBloc(initValue: "");


  @override
  void dispose() {
    _searchBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<String>(
        stream: _searchBloc.searchStream,
        builder: (context, snapshot) {
          return Column(
            children: [
              Text("API Call: ${snapshot.data}"),
              TextField(onChanged: (value) => _searchBloc.doSearch(value),),
            ],
          );
        }
      ),
    );
  }
}
