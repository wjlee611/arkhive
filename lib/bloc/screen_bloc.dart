import 'package:arkhive/enums/screen.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
  final EScreen screen;

  const ScreenChangeEvent({required this.screen});

  @override
  List<Object?> get props => [];
}

// State //
class ScreenState extends Equatable {
  final EScreen currScreen;

  const ScreenState({required this.currScreen});
  const ScreenState.init() : this(currScreen: EScreen.home);

  @override
  List<Object?> get props => [
        currScreen,
      ];
}
