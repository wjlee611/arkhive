import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/item_model.dart';
import 'package:arkhive/tools/load_image_from_securestorage.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:flutter/material.dart';

class ItemButton extends StatelessWidget {
  const ItemButton({
    super.key,
    required this.item,
  });

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => OpenDetailScreen.onItemTab(
        code: item.code,
        itemImage: getImageFromSP("item/${item.code}"),
        context: context,
      ),
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.transparent),
        elevation: MaterialStatePropertyAll(0),
      ),
      child: FutureBuilder(
        future: getImageFromSP("item/${item.code}"),
        builder: (context, snapshot) {
          return Transform.scale(
            scale: 1.7,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset(
                  'assets/images/item${item.tier}.png',
                  width: Sizes.size52,
                  height: Sizes.size52,
                ),
                if (snapshot.hasData)
                  Transform.translate(
                    offset: const Offset(0, Sizes.size1),
                    child: Transform.scale(
                      scale: 0.85,
                      child: Hero(
                        tag: item.code,
                        child: Image.memory(
                          snapshot.data!,
                          width: Sizes.size52,
                          height: Sizes.size52,
                          gaplessPlayback: true,
                        ),
                      ),
                    ),
                  )
                else
                  Transform.scale(
                    scale: 0.7,
                    child: Hero(
                      tag: item.code,
                      child: Image.asset(
                        'assets/images/prts.png',
                        width: Sizes.size52,
                        height: Sizes.size52,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
