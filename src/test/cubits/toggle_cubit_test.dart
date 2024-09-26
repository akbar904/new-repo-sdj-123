
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/cubits/toggle_cubit.dart';

void main() {
	group('ToggleCubit', () {
		late ToggleCubit toggleCubit;

		setUp(() {
			toggleCubit = ToggleCubit();
		});

		tearDown(() {
			toggleCubit.close();
		});

		test('initial state is ToggleState with text "Cat" and icon Icons.pets', () {
			expect(toggleCubit.state.text, 'Cat');
			expect(toggleCubit.state.icon, Icons.pets);
		});

		blocTest<ToggleCubit, ToggleState>(
			'emits [ToggleState(text: "Dog", icon: Icons.person)] when toggleText is called from initial state',
			build: () => toggleCubit,
			act: (cubit) => cubit.toggleText(),
			expect: () => [ToggleState('Dog', Icons.person)],
		);

		blocTest<ToggleCubit, ToggleState>(
			'emits [ToggleState(text: "Cat", icon: Icons.pets)] when toggleText is called from state with text "Dog"',
			build: () => toggleCubit,
			act: (cubit) {
				cubit.toggleText(); // First toggle to Dog
				cubit.toggleText(); // Second toggle back to Cat
			},
			expect: () => [
				ToggleState('Dog', Icons.person),
				ToggleState('Cat', Icons.pets),
			],
		);
	});
}
