import 'package:rxdart/rxdart.dart';

class SearchBloc {
  String initValue = "";
  BehaviorSubject<String> _subjectSearch = BehaviorSubject<String>();

  SearchBloc({required this.initValue}) {
    _subjectSearch = BehaviorSubject<String>.seeded(initValue);
  }

  Stream<String> get searchStream => _subjectSearch.stream.distinct().debounceTime(Duration(seconds: 1));

  void doSearch(String searchQuery){
    _subjectSearch.sink.add(searchQuery);
  }

  void dispose(){
    _subjectSearch.close();
  }
}
