import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_app/core/api/services/favourite/get_my_favourite_service.dart';
import 'package:patient_app/core/api/services/local/cache_helper.dart';
import 'favourite_states.dart';

class FavouriteCubit extends Cubit<FavouriteStates> {
  FavouriteCubit() : super(FavouriteInitial());

  Future<void> getFavourite() async {
    (await GetMyFavouritedService.getFavourite(
      token: CacheHelper.getData(key: 'Token'),
    ))
        .fold(
      (failure) {
        emit(FavouriteFailure(failureMsg: failure.errorMessege));
      },
      (favourite) {
        emit(FavouriteSuccess(doctors: favourite));
      },
    );
  }
}
