class BlackboardModel {
  final String key;
  final double value;

  BlackboardModel.fromJson(Map<String, dynamic> json)
      : key = json['key'],
        value = json['value'];
}
