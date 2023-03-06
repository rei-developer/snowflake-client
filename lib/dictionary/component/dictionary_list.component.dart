import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/dictionary/entity/dictionary.entity.dart';
import 'package:snowflake_client/dictionary/provider/word_matching.provider.dart';

class DictionaryListComponent extends ConsumerStatefulWidget {
  const DictionaryListComponent(this.fetchDictionaries, {Key? key}) : super(key: key);

  final Future<List<DictionaryEntity>> fetchDictionaries;

  @override
  ConsumerState<DictionaryListComponent> createState() => _DictionaryListComponentState();
}

class _DictionaryListComponentState extends ConsumerState<DictionaryListComponent> {
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

      // final newDictionaries = List.generate(99, (index) => dictionaries[0]);

      setState(() {
        _dictionaries.addAll(dictionaries);
        // _dictionaries.addAll(newDictionaries);
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
    final wordMatchingCtrl = ref.read(wordMatchingControllerProvider.notifier);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.separated(
        controller: _scrollController,
        itemCount: _dictionaries.length + (_isLoading ? 1 : 0),
        separatorBuilder: (_, __) => SizedBox(height: 10.r),
        itemBuilder: (_, index) {
          if (index == _dictionaries.length) {
            return const Center(child: CircularProgressIndicator());
          }
          final dictionary = _dictionaries[index];
          return GestureDetector(
            onTap: () => wordMatchingCtrl.setup(context, dictionary),
            child: Container(
              width: double.infinity,
              height: 60.r,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dictionary.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5.r),
                  Text('Words length : ${dictionary.words.length}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
