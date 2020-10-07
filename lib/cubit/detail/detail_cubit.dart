import 'package:bloc/bloc.dart';
import 'package:habit/repository/repository.dart';
import 'package:meta/meta.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  final Repository _repository;

  DetailCubit(this._repository) : super(DetailInitial());
}
