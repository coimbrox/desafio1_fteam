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
  @override
  void initState() {
    super.initState();
    vm = HomeViewModel();
    vm.addListener(_onVmChanged);
  }

  @override
  void dispose() {
    vm.removeListener(_onVmChanged);
    vm.dispose();
    super.dispose();
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
              controller: vm.searchController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Buscar por nome',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: vm.searchText.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: vm.clearSearch,
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onSubmitted: (_) => vm.submitSearch(),
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
                    controller: vm.scrollController,
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
