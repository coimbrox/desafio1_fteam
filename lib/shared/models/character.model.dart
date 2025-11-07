class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Ref origin;
  final Ref location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime? created;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
    id: (json['id'] ?? 0) as int,
    name: json['name']?.toString() ?? '',
    status: json['status']?.toString() ?? '',
    species: json['species']?.toString() ?? '',
    type: json['type']?.toString() ?? '',
    gender: json['gender']?.toString() ?? '',
    origin: Ref.fromJson(json['origin'] ?? const {}),
    location: Ref.fromJson(json['location'] ?? const {}),
    image: json['image']?.toString() ?? '',
    episode: (json['episode'] as List<dynamic>? ?? const [])
        .map((e) => e.toString())
        .toList(),
    url: json['url']?.toString() ?? '',
    created: DateTime.tryParse(json['created']?.toString() ?? ''),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'status': status,
    'species': species,
    'type': type,
    'gender': gender,
    'origin': origin.toJson(),
    'location': location.toJson(),
    'image': image,
    'episode': episode,
    'url': url,
    'created': created?.toIso8601String(),
  };
}

class Ref {
  final String name;
  final String url;

  Ref({required this.name, required this.url});

  factory Ref.fromJson(Map<String, dynamic> json) => Ref(
    name: json['name']?.toString() ?? '',
    url: json['url']?.toString() ?? '',
  );

  Map<String, dynamic> toJson() => {'name': name, 'url': url};
}
