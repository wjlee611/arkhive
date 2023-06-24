import 'package:arkhive/models/item_model.dart';
import 'package:flutter/material.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  final _searchController = TextEditingController();
  late Future<List<ItemModel>> _futureItems;
  bool _isLoading = false;
  final String _searchKeyword = "";

  @override
  void initState() {
    super.initState();
    _futureItems = futureItems();
  }

  Future<List<ItemModel>> futureItems() async {
    setState(() {
      _isLoading = true;
    });

    List<ItemModel> result = [];

    return result;
  }

  List<ItemModel> _runFilter(List<ItemModel> list) {
    return list.where((item) {
      final nameLower = item.name.toLowerCase();
      final searchLower = _searchKeyword.toLowerCase();

      return nameLower.contains(searchLower);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(),
          SliverFillRemaining(
            child: FutureBuilder(
              future: _futureItems,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var filteredLists = _runFilter(snapshot.data!);
                  return const CustomScrollView();
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
