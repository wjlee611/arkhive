import 'package:arkhive/enums/operator_profession.dart';
import 'package:arkhive/models/operator/operator_list_model.dart';
import 'package:equatable/equatable.dart';

enum RecruitStar {
  special('특별채용'),
  advSpecial('고급특별채용');

  final String title;

  const RecruitStar(this.title);
}

enum RecruitRange {
  melee('근거리'),
  range('원거리');

  final String title;

  const RecruitRange(this.title);
}

class RecruitEngineState extends Equatable {
  final Map<RecruitStar, bool>? star;
  final Map<RecruitRange, bool>? range;
  final Map<EOperatorProfession, bool>? profession;
  final Map<String, bool>? tags;

  const RecruitEngineState({
    this.star,
    this.range,
    this.profession,
    this.tags,
  });

  factory RecruitEngineState.init(List<OperatorListModel> operators) {
    Map<String, bool> tags = {};

    for (var op in operators) {
      for (var tag in op.tagList) {
        tags[tag] = false;
      }
    }

    return RecruitEngineState(
      star: const {
        RecruitStar.special: false,
        RecruitStar.advSpecial: false,
      },
      range: const {
        RecruitRange.melee: false,
        RecruitRange.range: false,
      },
      profession: const {
        EOperatorProfession.medic: false,
        EOperatorProfession.warrior: false,
        EOperatorProfession.special: false,
        EOperatorProfession.sniper: false,
        EOperatorProfession.pioneer: false,
        EOperatorProfession.tank: false,
        EOperatorProfession.caster: false,
        EOperatorProfession.support: false,
      },
      tags: tags,
    );
  }

  RecruitEngineState copyWith({
    Map<RecruitStar, bool>? star,
    Map<RecruitRange, bool>? range,
    Map<EOperatorProfession, bool>? profession,
    Map<String, bool>? tags,
  }) =>
      RecruitEngineState(
        star: star ?? this.star,
        range: range ?? this.range,
        profession: profession ?? this.profession,
        tags: tags ?? this.tags,
      );

  @override
  List<Object?> get props => [
        star,
        range,
        profession,
        tags,
      ];
}
