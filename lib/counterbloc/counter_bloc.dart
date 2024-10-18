import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trishaheed/counterbloc/counter_event.dart';
import 'package:trishaheed/counterbloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<IncreementEvent>(_onIncreement);
    on<DecreementEvent>(_onDecreement);
  }
  //event handler for increement
  _onIncreement(event, Emitter<CounterState> emit)  {
    emit(CounterState(state.count + 1));
  }

  //event handler for decreement
_onDecreement(event, Emitter<CounterState> emit)  {
    emit(CounterState(state.count - 1));
  }


}
