import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/dictionary/entity/dictionary.entity.dart';

class DictionaryListComponent extends StatefulWidget {
  const DictionaryListComponent(this.fetchDictionaries, {Key? key}) : super(key: key);

  final Future<List<DictionaryEntity>> fetchDictionaries;

  @override
  State<DictionaryListComponent> createState() => _DictionaryListComponentState();
}

class _DictionaryListComponentState extends State<DictionaryListComponent> {
  final List<DictionaryEntity> _dictionaries = [];
  bool _isLoading = false;
  int _currentPage = 0;

  final int _pageSize = 20;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchData();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _fetchData();
    }
  }

  Future<void> _fetchData() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final dictionaries = await widget.fetchDictionaries
          .then((list) => list.skip(_currentPage * _pageSize).take(_pageSize).toList());

      final newDictionaries = List.generate(99, (index) => dictionaries[0]);

      setState(() {
        // _dictionaries.addAll(dictionaries);
        _dictionaries.addAll(newDictionaries);
        _isLoading = false;
        _currentPage++;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching dictionaries: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _dictionaries.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _dictionaries.length) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final dictionary = _dictionaries[index];
          return GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  dictionary.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  '등록된 단어 개수 : ${dictionary.words.length}개',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
