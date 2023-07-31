import 'package:get_it/get_it.dart';
 

import '../../data/repository_pattern/firebase/login_repo.dart';
import '../../data/repository_pattern/firebase/phone_auth_repo.dart';
import '../../data/repository_pattern/firebase/register_repo.dart';
import '../../data/repository_pattern/remote_data/get_current_movie_data.dart';
import '../../data/repository_pattern/remote_data/get_home_screen_data.dart';
import '../../data/repository_pattern/remote_data/get_intersting_movie.dart';
import '../../data/repository_pattern/remote_data/search_movie.dart';
import '../../pages/auth_screens/phone_auth/controllers/bloc/phone_auth_bloc.dart';
import '../../pages/current_movie/controller/current_movie_bloc.dart';
import '../../pages/home_screen/controllers/home_screen_bloc.dart';
import '../../pages/intersting_movie_for_user/controller/intersting_movie_bloc.dart';

import '../../pages/login_screens/controllers/login_auth_bloc.dart';
import '../../pages/register_screens/controllers/register_bloc_bloc.dart';
import '../../pages/search/controllers/search_bloc.dart';

final sl = GetIt.asNewInstance();

class ServicesLocator {
  ServicesLocator();

  static void service() {
    sl.registerFactory<RegisterBloc>(() => RegisterBloc(sl(), sl()));
    sl.registerFactory<PhoneAuthBloc>(() => PhoneAuthBloc(sl(), sl()));
    sl.registerFactory<LoginAuthBloc>(() => LoginAuthBloc(sl(), sl()));
    sl.registerFactory<InterstingMovieBloc>(() => InterstingMovieBloc(sl()));
    sl.registerFactory<HomeScreenBloc>(() => HomeScreenBloc(sl()));
    sl.registerFactory<SearchBloc>(() => SearchBloc(sl()));
    sl.registerFactory<CurrentMovieBloc>(() => CurrentMovieBloc(sl()));

    sl.registerFactory<GetDataForHomeScreen>(
      () => FetchMovieData(),
    );

    sl.registerFactory<GetMoviesBySearch>(
      () => FetchMoviesBySearch(),
    );

    sl.registerFactory<RegisterReopsitory>(
      () => RegisterAuthByemailAndPassword(),
    );

    sl.registerFactory<PhoneAuthantication>(
      () => AuthUserByPhoneNumber(),
    );

    sl.registerFactory<GetIntrestingMovie>(
      () => FetchIntrestingMovie(),
    );

    sl.registerFactory<LoginRepository>(
      () => LoginByFirebase(),
    );

    sl.registerFactory<GetCurrentMovieDetails>(
      () => FetchCurrentMovie(),
    );
  }
}
