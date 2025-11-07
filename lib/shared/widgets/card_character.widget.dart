import 'package:desafio1_fteam/constants/colors.constants.dart';
import 'package:desafio1_fteam/features/details/view/details.view.dart';
import 'package:desafio1_fteam/shared/models/character.model.dart';
import 'package:flutter/material.dart';

class CardCharacterWidget extends StatelessWidget {
  const CardCharacterWidget({
    super.key,
    required this.character,
    this.onTap,
    this.onTapDelete,
  });

  final CharacterModel character;
  final VoidCallback? onTap;
  final VoidCallback? onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap:
            onTap ??
            () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DetailsPage(character: character),
                ),
              );
            },
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorsConstants.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  // avatar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: character.image.isNotEmpty
                          ? Image.network(
                              character.image,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.person, size: 32),
                              ),
                            )
                          : Container(
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.person, size: 32),
                            ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // name and species (small subtitle)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          character.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          character.species,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (onTapDelete != null)
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: onTapDelete,
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
