enum EOperatorPhase {
  phase0(0),
  phase1(1),
  phase2(2);

  final int value;

  const EOperatorPhase(this.value);
}

EOperatorPhase operatorPhaseConverter(String phase) {
  switch (phase) {
    case 'PHASE_0':
    case '0':
      return EOperatorPhase.phase0;
    case 'PHASE_1':
    case '1':
      return EOperatorPhase.phase1;
    case 'PHASE_2':
    case '2':
      return EOperatorPhase.phase2;
    default:
      return EOperatorPhase.phase0;
  }
}
