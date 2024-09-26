
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/toggle_cubit.dart';
import '../models/toggle_state.dart';

class ToggleText extends StatelessWidget {
	const ToggleText({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return BlocBuilder<ToggleCubit, ToggleState>(
			builder: (context, state) {
				return InkWell(
					onTap: () {
						context.read<ToggleCubit>().toggleText();
					},
					child: Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Text(state.text),
							SizedBox(width: 8),
							Icon(state.icon),
						],
					),
				);
			},
		);
	}
}
