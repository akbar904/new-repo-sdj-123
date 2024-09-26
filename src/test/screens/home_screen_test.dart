
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:simple_app/screens/home_screen.dart';
import 'package:simple_app/cubits/toggle_cubit.dart';
import 'package:simple_app/models/toggle_state.dart';

class MockToggleCubit extends MockCubit<ToggleState> implements ToggleCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		late ToggleCubit toggleCubit;

		setUp(() {
			toggleCubit = MockToggleCubit();
		});

		testWidgets('Initial state shows "Cat" with clock icon', (WidgetTester tester) async {
			when(() => toggleCubit.state).thenReturn(ToggleState('Cat', Icons.access_time));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<ToggleCubit>(
						create: (_) => toggleCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('Toggles to "Dog" with person icon when clicked', (WidgetTester tester) async {
			when(() => toggleCubit.state).thenReturn(ToggleState('Cat', Icons.access_time));
			whenListen(
				toggleCubit,
				Stream.fromIterable([ToggleState('Dog', Icons.person)]),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<ToggleCubit>(
						create: (_) => toggleCubit,
						child: HomeScreen(),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
