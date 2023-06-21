import 'package:equatable/equatable.dart';

class OperatorStatusState extends Equatable {
  // Operator status
  final int potential;
  final int elite;
  final int level;
  final int maxLevel;
  final int favor;
  // Calculated operator stats
  final double maxHp;
  final double atk;
  final double def;
  final double magicResistance;
  final double respawnTime;
  final double cost;
  final double blockCnt;
  final double atkSpeed;

  const OperatorStatusState({
    required this.potential,
    required this.elite,
    required this.level,
    required this.maxLevel,
    required this.favor,
    required this.maxHp,
    required this.atk,
    required this.def,
    required this.magicResistance,
    required this.respawnTime,
    required this.cost,
    required this.blockCnt,
    required this.atkSpeed,
  });

  const OperatorStatusState.init()
      : potential = 0,
        elite = 0,
        level = 1,
        maxLevel = 1,
        favor = 0,
        maxHp = 0,
        atk = 0,
        def = 0,
        magicResistance = 0,
        respawnTime = 0,
        cost = 0,
        blockCnt = 0,
        atkSpeed = 0;

  OperatorStatusState copyWith({
    int? potential,
    int? elite,
    int? level,
    int? maxLevel,
    int? favor,
    double? maxHp,
    double? atk,
    double? def,
    double? magicResistance,
    double? respawnTime,
    double? cost,
    double? blockCnt,
    double? atkSpeed,
  }) {
    return OperatorStatusState(
      potential: potential ?? this.potential,
      elite: elite ?? this.elite,
      level: level ?? this.level,
      maxLevel: maxLevel ?? this.maxLevel,
      favor: favor ?? this.favor,
      maxHp: maxHp ?? this.maxHp,
      atk: atk ?? this.atk,
      def: def ?? this.def,
      magicResistance: magicResistance ?? this.magicResistance,
      respawnTime: respawnTime ?? this.respawnTime,
      cost: cost ?? this.cost,
      blockCnt: blockCnt ?? this.blockCnt,
      atkSpeed: atkSpeed ?? this.atkSpeed,
    );
  }

  @override
  List<Object?> get props => [
        potential,
        elite,
        level,
        maxLevel,
        favor,
        maxHp,
        atk,
        def,
        magicResistance,
        respawnTime,
        cost,
        blockCnt,
        atkSpeed,
      ];
}
