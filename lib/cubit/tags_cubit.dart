import 'dart:convert';
import 'dart:isolate';
import 'package:arkhive/models/base/tags_model.dart';
import 'package:arkhive/models/common_models.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagsCubit extends Cubit<TagsState> {
  TagsCubit() : super(const TagsState(status: CommonLoadState.init));

  Future<void> loadTags({
    required Region dbRegion,
  }) async {
    emit(state.copyWith(status: CommonLoadState.loading));

    try {
      // richText tags
      String jsonString = await rootBundle
          .loadString('${getGameDataRoot(dbRegion)}excel/gamedata_const.json');

      ReceivePort port = ReceivePort();
      await Isolate.spawn(
        _deserializeTagsModel,
        [port.sendPort, jsonString],
      );
      var response = await port.first;
      Map<String, TagRichTextModel> richTextTags = response[0];
      Map<String, TagTermDescriptionModel> termTags = response[1];
      port.close();

      // subProfDict
      jsonString = await rootBundle
          .loadString('${getGameDataRoot(dbRegion)}excel/uniequip_table.json');

      port = ReceivePort();
      await Isolate.spawn(
        _deserializeSubProfDict,
        [port.sendPort, jsonString],
      );
      Map<String, String> subProfDict = await port.first;
      port.close();

      emit(state.copyWith(
        richTextTags: richTextTags,
        termTags: termTags,
        subProfDict: subProfDict,
        status: CommonLoadState.loaded,
      ));
      return;
    } catch (e) {
      emit(state.copyWith(status: CommonLoadState.error));
      return;
    }
  }

  // Isolate
  static void _deserializeTagsModel(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];

    Map<String, TagRichTextModel> richTextTags = {};
    Map<String, TagTermDescriptionModel> termTags = {};

    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    Map<String, dynamic> richTextData = jsonData['richTextStyles'];
    Map<String, dynamic> termData = jsonData['termDescriptionDict'];

    for (var tag in richTextData.entries) {
      var tagModel = TagRichTextModel(value: tag.value);
      richTextTags['<@${tag.key}>'] = tagModel;
    }
    for (var tag in termData.entries) {
      var tagModel = TagTermDescriptionModel.fromJson(tag.value);
      termTags['<\$${tag.key}>'] = tagModel;
    }

    Isolate.exit(sendPort, [richTextTags, termTags]);
  }

  static void _deserializeSubProfDict(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];

    Map<String, String> subProfDict = {};

    Map<String, dynamic> jsonData = jsonDecode(jsonString)['subProfDict'];

    for (var subProf in jsonData.entries) {
      subProfDict[subProf.key] = subProf.value['subProfessionName'];
    }

    Isolate.exit(sendPort, subProfDict);
  }
}

class TagsState extends Equatable {
  final Map<String, TagRichTextModel>? richTextTags;
  final Map<String, TagTermDescriptionModel>? termTags;
  final Map<String, String>? subProfDict;
  final CommonLoadState? status;

  const TagsState({
    this.richTextTags,
    this.termTags,
    this.subProfDict,
    this.status,
  });

  TagsState copyWith({
    Map<String, TagRichTextModel>? richTextTags,
    Map<String, TagTermDescriptionModel>? termTags,
    final Map<String, String>? subProfDict,
    CommonLoadState? status,
  }) =>
      TagsState(
        richTextTags: richTextTags ?? this.richTextTags,
        termTags: termTags ?? this.termTags,
        subProfDict: subProfDict ?? this.subProfDict,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        richTextTags,
        termTags,
        subProfDict,
        status,
      ];
}
