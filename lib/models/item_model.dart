class ItemModel {
  final String code, name, info;
  final int tier;
  final List<String> obtain;
  // ignore: library_private_types_in_public_api
  final List<_DropRateModel> drop;

  ItemModel.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        name = json['name'],
        tier = int.parse(json['tier']),
        info = json['info'],
        obtain = [for (var obtain_ in json['obtain']) obtain_.toString()],
        drop = [
          if (json['drop'] != null)
            for (var dropJson in json['drop']) _DropRateModel.fromJson(dropJson)
        ];
}

class _DropRateModel {
  final String stage;
  final double sanityPerItem;

  _DropRateModel.fromJson(Map<String, dynamic> json)
      : stage = json['stage'],
        sanityPerItem = double.parse(json['spi']);
}
