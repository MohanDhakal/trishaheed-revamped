import 'package:flutter_bloc/flutter_bloc.dart';
class CounterCubit extends Cubit<int>{
  CounterCubit():super(1);
  void increement()=>  emit(state+1);
  void decreement()=> emit(state-1);
}