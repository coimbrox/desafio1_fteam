import 'package:desafio1_fteam/shared/models/character.model.dart';
import 'package:desafio1_fteam/shared/services/character.service.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    loadCharacters(reset: true);
  }

  final List<CharacterModel> _characters = [];
  List<CharacterModel> get characters => List.unmodifiable(_characters);

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  int _currentPage = 1;
  int _totalPages = 1;
  bool _isLoadingMore = false;
  String _query = '';

  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  bool get isLoadingMore => _isLoadingMore;
  String get query => _query;

  Future<void> loadCharacters({bool reset = false}) async {
    if (_loading) return;

    if (reset) {
      _currentPage = 1;
      _totalPages = 1;
      _characters.clear();
    }

    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await CharacterService.getCharacter(
        page: _currentPage,
        name: _query.isEmpty ? null : _query,
      );

      if (reset) {
        _characters
          ..clear()
          ..addAll(response.results);
      } else {
        _characters.addAll(response.results);
      }

      _totalPages = response.info.pages;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> loadNextPage() async {
    if (_isLoadingMore || _loading) return;
    if (_currentPage >= _totalPages) return;

    _isLoadingMore = true;
    _error = null;
    _currentPage += 1;
    notifyListeners();

    try {
      final response = await CharacterService.getCharacter(
        page: _currentPage,
        name: _query.isEmpty ? null : _query,
      );
      _characters.addAll(response.results);
      _totalPages = response.info.pages;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  void setQuery(String q) {
    _query = q.trim();
    _currentPage = 1;
    loadCharacters(reset: true);
  }
}
