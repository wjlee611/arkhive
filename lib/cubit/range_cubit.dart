import 'dart:convert';
import 'dart:isolate';
import 'package:arkhive/models/base/range_model.dart';
import 'package:arkhive/models/common_models.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RangeCubit extends Cubit<RangeState> {
  RangeCubit() : super(const RangeState(status: CommonLoadState.init));

  Future<void> loadRange({
    required Region dbRegion,
  }) async {
    emit(state.copyWith(status: CommonLoadState.loading));

    try {
      String jsonString = await rootBundle
          .loadString('${getGameDataRoot(dbRegion)}excel/range_table.json');

      ReceivePort port = ReceivePort();
      await Isolate.spawn(
        _deserializeRangeModel,
        [port.sendPort, jsonString],
      );
      Map<String, RangeModel> ranges = await port.first;
      port.close();

      emit(state.copyWith(
        status: CommonLoadState.loaded,
        ranges: ranges,
      ));
      return;
    } catch (e) {
      emit(state.copyWith(status: CommonLoadState.error));
      return;
    }
  }

  // Isolate
  static void _deserializeRangeModel(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];

    Map<String, RangeModel> ranges = {};

    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    for (var range in jsonData.entries) {
      var rangeModel = RangeModel.fromJson(range.value);
      ranges[range.key] = rangeModel;
    }

    Isolate.exit(sendPort, ranges);
  }
}

class RangeState extends Equatable {
  final Map<String, RangeModel>? ranges;
  final CommonLoadState? status;

  const RangeState({
    this.ranges,
    this.status,
  });

  RangeState copyWith({
    Map<String, RangeModel>? ranges,
    CommonLoadState? status,
  }) =>
      RangeState(
        ranges: ranges,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        ranges,
        status,
      ];
}
