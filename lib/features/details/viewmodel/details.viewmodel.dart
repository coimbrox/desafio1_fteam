import 'package:desafio1_fteam/shared/models/character.model.dart';
import 'package:flutter/material.dart';

class DetailsViewModel extends ChangeNotifier {
  final CharacterModel character;

  DetailsViewModel(this.character);

  Color getStatusColor() {
    final s = character.status.toLowerCase();
    if (s == 'alive') return Colors.green;
    if (s == 'dead') return Colors.red;
    return Colors.grey;
  }

  String formatCreated() {
    if (character.created == null) return '-';
    return character.created!.toLocal().toString().split('.').first;
  }

  List<String> getEpisodeIds() {
    final ids = <String>[];
    for (var i = 0; i < character.episode.length && i < 12; i++) {
      final epUrl = character.episode[i];
      final parts = epUrl.split('/');
      ids.add(parts.isNotEmpty ? parts.last : (i + 1).toString());
    }
    return ids;
  }

  bool get hasMoreEpisodes => character.episode.length > 12;
  String get type => character.type.isNotEmpty ? character.type : '-';
}
