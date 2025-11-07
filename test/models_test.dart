import 'package:desafio1_fteam/shared/models/api_response.model.dart';
import 'package:desafio1_fteam/shared/models/character.model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CharacterModel.fromJson', () {
    test('parses full character json', () {
      final json = {
        'id': 1,
        'name': 'Rick Sanchez',
        'status': 'Alive',
        'species': 'Human',
        'type': '',
        'gender': 'Male',
        'origin': {'name': 'Earth (C-137)', 'url': ''},
        'location': {'name': 'Citadel of Ricks', 'url': ''},
        'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
        'episode': ['https://rickandmortyapi.com/api/episode/1'],
        'url': 'https://rickandmortyapi.com/api/character/1',
        'created': '2017-11-04T18:48:46.250Z',
      };

      final model = CharacterModel.fromJson(json);

      expect(model.id, 1);
      expect(model.name, 'Rick Sanchez');
      expect(model.status, 'Alive');
      expect(model.species, 'Human');
      expect(model.origin.name, 'Earth (C-137)');
      expect(model.location.name, 'Citadel of Ricks');
      expect(model.episode, isNotEmpty);
      expect(model.created, isNotNull);
    });
  });

  group('ApiResponse.fromJson', () {
    test('parses info and results', () {
      final json = {
        'info': {'count': 1, 'pages': 1, 'next': null, 'prev': null},
        'results': [
          {
            'id': 1,
            'name': 'Rick Sanchez',
            'status': 'Alive',
            'species': 'Human',
            'type': '',
            'gender': 'Male',
            'origin': {'name': 'Earth (C-137)', 'url': ''},
            'location': {'name': 'Citadel of Ricks', 'url': ''},
            'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
            'episode': ['https://rickandmortyapi.com/api/episode/1'],
            'url': 'https://rickandmortyapi.com/api/character/1',
            'created': '2017-11-04T18:48:46.250Z',
          },
        ],
      };

      final resp = ApiResponse.fromJson(json);
      expect(resp.info.count, 1);
      expect(resp.info.pages, 1);
      expect(resp.results, hasLength(1));
      expect(resp.results.first.name, 'Rick Sanchez');
    });
  });
}
