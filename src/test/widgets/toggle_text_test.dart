
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:com.example.simple_app/widgets/toggle_text.dart';
import 'package:com.example.simple_app/cubits/toggle_cubit.dart';
import 'package:com.example.simple_app/models/toggle_state.dart';

class MockToggleCubit extends Mock implements ToggleCubit {}

void main() {
	group('ToggleText Widget Tests', () {
		late ToggleCubit toggleCubit;

		setUp(() {
			toggleCubit = MockToggleCubit();
		});

		testWidgets('initial state shows "Cat" with clock icon', (WidgetTester tester) async {
			when(() => toggleCubit.state).thenReturn(ToggleState('Cat', Icons.access_time));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: toggleCubit,
						child: ToggleText(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('tap toggles state to "Dog" with person icon', (WidgetTester tester) async {
			when(() => toggleCubit.state).thenReturn(ToggleState('Cat', Icons.access_time));
			when(() => toggleCubit.toggleText()).thenAnswer((_) {
				when(() => toggleCubit.state).thenReturn(ToggleState('Dog', Icons.person));
			});

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: toggleCubit,
						child: ToggleText(),
					),
				),
			);

			await tester.tap(find.byType(InkWell));
			await tester.pumpAndSettle();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
