import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_cubit.dart';
class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('This is a Counter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<CounterCubit,int>(
            builder: (context,state) {
              return Text(state.toString(),style: TextStyle(fontSize: 24),);
            }
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  context.read<CounterCubit>().increement();
                },
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
                onTap: (){
                  //TODO: Implement Decrement Counter
                  context.read<CounterCubit>().decreement();

                },
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
