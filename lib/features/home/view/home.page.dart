import 'package:desafio1_fteam/features/home/viewmodel/home.viewmodel.dart';
import 'package:desafio1_fteam/shared/widgets/card_character.widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeViewModel vm;
  late final ScrollController _scrollController;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    vm = HomeViewModel();
    vm.addListener(_onVmChanged);
    _scrollController = ScrollController()..addListener(_onScroll);
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    vm.removeListener(_onVmChanged);
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final threshold = 200.0;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;
    if (maxScroll - current <= threshold) {
      vm.loadNextPage();
    }
  }

  void _onVmChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Desafio Rick and Morty Fteam')),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Buscar por nome',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          vm.setQuery('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onSubmitted: (value) => vm.setQuery(value),
            ),
          ),
          // List area
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => vm.loadCharacters(reset: true),
              child: Builder(
                builder: (context) {
                  if (vm.loading && vm.characters.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (vm.error != null && vm.characters.isEmpty) {
                    return ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Text('Erro: ${vm.error}'),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () => vm.loadCharacters(reset: true),
                                child: const Text('Tentar novamente'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }

                  if (vm.characters.isEmpty) {
                    return ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 120),
                        Center(child: Text('Nenhum personagem encontrado')),
                      ],
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount:
                        vm.characters.length + (vm.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= vm.characters.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final c = vm.characters[index];
                      return CardCharacterWidget(character: c);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
