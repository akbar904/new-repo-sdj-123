
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/cubits/toggle_cubit.dart';
import 'package:simple_app/models/toggle_state.dart';
import 'package:simple_app/widgets/toggle_text.dart';

class HomeScreen extends StatelessWidget {
	const HomeScreen({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Home Screen'),
			),
			body: Center(
				child: BlocBuilder<ToggleCubit, ToggleState>(
					builder: (context, state) {
						return ToggleText(
							text: state.text,
							icon: state.icon,
							onTap: () => context.read<ToggleCubit>().toggleText(),
						);
					},
				),
			),
		);
	}
}
