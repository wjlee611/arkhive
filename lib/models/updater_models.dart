class UpdateVersionsModel {
  final Map<String, UpdateDependencyModel> versions;

  UpdateVersionsModel.fromJson(Map<String, dynamic> json)
      : versions = {
          for (var key in json.keys)
            key: UpdateDependencyModel.fromJson(json[key])
        };
}

class UpdateDependencyModel {
  Map<String, List<String>> categories;

  UpdateDependencyModel.fromJson(Map<String, dynamic> json)
      : categories = {
          for (var key in json.keys)
            key: [
              if (json[key] != null)
                for (var data in json[key]!) data
            ]
        };

  UpdateDependencyModel() : categories = {};

  void add({
    required String key,
    required String value,
  }) {
    if (categories[key] == null) {
      categories[key] = [];
    }
    categories[key]!.add(value);
  }
}
