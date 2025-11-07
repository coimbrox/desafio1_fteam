import 'package:desafio1_fteam/features/details/view/details.page.dart';
import 'package:desafio1_fteam/shared/models/character.model.dart';
import 'package:desafio1_fteam/shared/widgets/card_character.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

CharacterModel _sampleCharacter() => CharacterModel(
  id: 1,
  name: 'Rick Sanchez',
  status: 'Alive',
  species: 'Human',
  type: '',
  gender: 'Male',
  origin: Ref(name: 'Earth (C-137)', url: ''),
  location: Ref(name: 'Citadel of Ricks', url: ''),
  image: '',
  episode: ['https://rickandmortyapi.com/api/episode/1'],
  url: 'https://rickandmortyapi.com/api/character/1',
  created: DateTime.tryParse('2017-11-04T18:48:46.250Z'),
);

void main() {
  testWidgets('CardCharacterWidget displays name', (WidgetTester tester) async {
    final character = _sampleCharacter();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CardCharacterWidget(character: character)),
      ),
    );

    expect(find.text('Rick Sanchez'), findsOneWidget);
    expect(find.byType(CardCharacterWidget), findsOneWidget);
  });

  testWidgets('DetailsPage shows main fields', (WidgetTester tester) async {
    final character = _sampleCharacter();

    await tester.pumpWidget(
      MaterialApp(home: DetailsPage(character: character)),
    );

    expect(find.text('Rick Sanchez'), findsWidgets);

    expect(find.text('Alive'), findsOneWidget);
    expect(find.text('Human'), findsOneWidget);
  });
}
