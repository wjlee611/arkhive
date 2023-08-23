import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.init);

  changeLoadStatus(SplashState status) {
    emit(status);
  }
}

enum SplashState {
  init('초기화 중입니다'),
  tags('태그 데이터를\n불러오는 중입니다'),
  range('사거리 데이터를\n불러오는 중입니다'),
  penguin('펭귄 물류 데이터를\n분석하는 중입니다'),
  complete('어서오세요, 박사님.'),
  errorTags('태그 데이터를 불러오는데 실패했습니다.'),
  errorRange('사거리 데이터를 불러오는데 실패했습니다.'),
  errorPenguin('펭귄 물류 데이터를 불러오는데 실패했습니다.');

  const SplashState(this.message);

  final String message;
}
