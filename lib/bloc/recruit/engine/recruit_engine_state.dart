import 'package:arkhive/enums/operator_position.dart';
import 'package:arkhive/enums/operator_profession.dart';
import 'package:arkhive/enums/rarity_tier.dart';
import 'package:arkhive/models/operator/operator_list_model.dart';
import 'package:equatable/equatable.dart';

enum RecruitStar {
  special('특별채용', ERarityTier.tier5),
  advSpecial('고급특별채용', ERarityTier.tier6);

  final String title;
  final ERarityTier tier;

  const RecruitStar(this.title, this.tier);
}

class RecruitEngineState extends Equatable {
  final Map<RecruitStar, bool>? star;
  final Map<EOperatorPosition, bool>? position;
  final Map<EOperatorProfession, bool>? profession;
  final Map<String, bool>? tags;

  const RecruitEngineState({
    this.star,
    this.position,
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
      position: const {
        EOperatorPosition.melee: false,
        EOperatorPosition.ranged: false,
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
    Map<EOperatorPosition, bool>? position,
    Map<EOperatorProfession, bool>? profession,
    Map<String, bool>? tags,
  }) =>
      RecruitEngineState(
        star: star ?? this.star,
        position: position ?? this.position,
        profession: profession ?? this.profession,
        tags: tags ?? this.tags,
      );

  @override
  List<Object?> get props => [
        star,
        position,
        profession,
        tags,
      ];
}
