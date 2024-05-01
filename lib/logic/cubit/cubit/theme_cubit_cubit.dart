import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_cubit_state.dart';

class ThemeCubitCubit extends Cubit<ThemeCubitState> {
  ThemeCubitCubit() : super(ThemeCubitInitial());
}
