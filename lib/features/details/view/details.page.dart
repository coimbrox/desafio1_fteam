import 'package:desafio1_fteam/features/details/viewmodel/details.viewmodel.dart';
import 'package:desafio1_fteam/shared/models/character.model.dart';
import 'package:desafio1_fteam/shared/widgets/info_row.widget.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.character});

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    final vm = DetailsViewModel(character);

    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: character.image.isNotEmpty
                      ? Image.network(character.image, fit: BoxFit.cover)
                      : Container(
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.person, size: 80),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        character.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Chip(
                  backgroundColor: vm.getStatusColor(),
                  label: Text(
                    character.status,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 0,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoRow(title: 'ID', value: character.id.toString()),
                    InfoRow(title: 'Type', value: vm.type),
                    InfoRow(title: 'Species', value: character.species),
                    InfoRow(title: 'Gender', value: character.gender),
                    InfoRow(title: 'Origin', value: character.origin.name),
                    InfoRow(title: 'Location', value: character.location.name),
                    InfoRow(title: 'Created', value: vm.formatCreated()),
                    const SizedBox(height: 8),
                    Text(
                      'Episodes',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      children: [
                        ...vm.getEpisodeIds().map(
                          (id) => Padding(
                            padding: const EdgeInsets.only(right: 6, bottom: 6),
                            child: Chip(label: Text('Ep $id')),
                          ),
                        ),
                        if (vm.hasMoreEpisodes)
                          const Padding(
                            padding: EdgeInsets.only(right: 6, bottom: 6),
                            child: Chip(label: Text('...')),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
