import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

enum Screens { home, items, stages, operators, enemies }

// Bloc //
class ScreenBloc extends Bloc<ScreenChangeEvent, ScreenState> {
  ScreenBloc() : super(const ScreenState.init()) {
    on<ScreenChangeEvent>(_changeScreen);
  }

  _changeScreen(ScreenChangeEvent event, emit) {
    emit(ScreenState(currScreen: event.screen));
  }
}

// Event //
class ScreenChangeEvent extends Equatable {
  final Screens screen;

  const ScreenChangeEvent({required this.screen});

  @override
  List<Object?> get props => [];
}

// State //
class ScreenState extends Equatable {
  final Screens currScreen;

  const ScreenState({required this.currScreen});
  const ScreenState.init() : this(currScreen: Screens.home);

  @override
  List<Object?> get props => [
        currScreen,
      ];
}
