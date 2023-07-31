import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.init);

  changeLoadStatus(SplashState status) {
    emit(status);
  }
}

enum SplashState {
  init('초기화 중입니다'),
  tags('필수 데이터를 불러오는 중입니다 (1/2)'),
  range('필수 데이터를 불러오는 중입니다 (2/2)'),
  penguin('펭귄 물류 데이터를 분석하는 중입니다'),
  complete('어서오세요, 박사님.'),
  error('초기화에 실패했습니다.');

  const SplashState(this.message);

  final String message;
}
