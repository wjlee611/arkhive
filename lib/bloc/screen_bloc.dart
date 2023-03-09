import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class ScreenBloc extends Bloc<ScreenChangeEvent, ScreenState> {
  ScreenBloc() : super(const ScreenState.init()) {
    on<ScreenChangeEvent>(_changeScreen);
  }

  _changeScreen(ScreenChangeEvent event, emit) {
    print('update');
    emit(ScreenState(currScreen: event.screen));
  }
}

enum Screens { home, items, stages, gimmick, operators, enemies }

class ScreenChangeEvent extends Equatable {
  final Screens screen;

  const ScreenChangeEvent({required this.screen});

  @override
  List<Object?> get props => [];
}

class ScreenState extends Equatable {
  final Screens currScreen;

  const ScreenState({required this.currScreen});
  const ScreenState.init() : this(currScreen: Screens.home);

  @override
  List<Object?> get props => [
        currScreen,
      ];
}
