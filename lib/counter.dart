// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:iti_api/cubit/counter_cubit.dart';
//
// import 'cubit/counter_state.dart';
// class Counter extends StatefulWidget {
//   const Counter({super.key});
//
//   @override
//   State<Counter> createState() => _CounterState();
// }
//
// class _CounterState extends State<Counter> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('counter')),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 14.0,horizontal: 14),
//         child:
//         Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () => context.read<CounterCubit>().increment(),
//                 child: const Text('+', style: TextStyle(fontSize: 24)),
//               ),
//               const SizedBox(height: 20),
//               BlocBuilder<CounterCubit, CounterState>(
//                 builder: (context, state) {
//                   return Text(
//                     "${state.counter}",
//                     style: const TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => context.read<CounterCubit>().decrement(),
//                 child: const Text('-', style: TextStyle(fontSize: 24)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// class IconIncrementWidget extends StatelessWidget {
//   const IconIncrementWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () => context.read<CounterCubit>().increment(),
//       child: const Text('+', style: TextStyle(fontSize: 24)),
//     );
//     // const SizedBox(height: 20),
//     // BlocBuilder<CounterCubit, CounterState>(
//     // builder: (context, state) {
//     // return Text(
//     // "${state.counter}",
//     // style: const TextStyle(
//     // fontSize: 30,
//     // fontWeight: FontWeight.bold,
//     // ),
//     // );
//     // },
//     // ),
//     // const;
//   }
// }
//
//
