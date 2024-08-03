import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trishaheed/counterbloc/counter_bloc.dart';
import 'package:trishaheed/counterbloc/counter_event.dart';
import 'package:trishaheed/counterbloc/counter_state.dart';

class CounterAppOne extends StatelessWidget {
  const CounterAppOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('This is a Counter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
            return Text(
              state.count.toString(),
              style: TextStyle(fontSize: 24),
            );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => context.read<CounterBloc>().add(IncreementEvent()),
                child: Container(
                  width: 100,
                  height: 36,
                  alignment: Alignment.center,
                  child: Text('Increement'),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.purple.shade50,
                  ),
                ),
              ),
              SizedBox(width: 16),
              GestureDetector(
                onTap: () => context.read<CounterBloc>().add(DecreementEvent()),
                child: Container(
                  width: 100,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.purple.shade50,
                  ),
                  child: Text('Decreement'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
