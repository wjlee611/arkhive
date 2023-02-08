import 'package:arkhive/global_data.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/tools/load_image_from_sharedpreference.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:arkhive/tools/willpop_function.dart';
import 'package:arkhive/widgets/nav_widget.dart';
import 'package:flutter/material.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  GlobalData globalData = GlobalData();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '창고 아이템',
          style: TextStyle(
            fontFamily: FontFamily.nanumGothic,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.blueGrey.shade700,
        leading: IconButton(
          icon: const Icon(Icons.sort),
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
        ),
      ),
      body: WillPopScope(
        onWillPop: () => WillPopFunction.onWillPop(context: context),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: globalData.items.length,
                  (context, index) {
                    return ElevatedButton(
                      onPressed: () => OpenDetailScreen.onItemTab(
                        list: globalData.items,
                        code: globalData.items[index].code,
                        itemImage: getImageFromSP(
                            "item/${globalData.items[index].code}"),
                        context: context,
                      ),
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.transparent),
                        elevation: MaterialStatePropertyAll(0),
                      ),
                      child: FutureBuilder(
                        future: getImageFromSP(
                            "item/${globalData.items[index].code}"),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Transform.scale(
                              scale: 1.8,
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Image.asset(
                                      'assets/images/item${globalData.items[index].tier}.png'),
                                  Transform.scale(
                                    scale: 0.8,
                                    child: Hero(
                                      tag: globalData.items[index].code,
                                      child: Image.memory(snapshot.data!),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return Transform.scale(
                            scale: 1.5,
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Image.asset(
                                    'assets/images/item${globalData.items[index].tier}.png'),
                                Hero(
                                  tag: globalData.items[index].code,
                                  child: Image.asset('assets/images/prts.png'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade700,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 2,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '///    ${globalData.items.length} results    ///',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: FontFamily.nanumGothic,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
      drawer: const NavDrawer(),
    );
  }
}
