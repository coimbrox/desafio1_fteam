# desafio1_fteam

Projeto de demonstração Flutter para o desafio (Rick & Morty).

## Introdução rápida

Este projeto consome a API pública do Rick and Morty e exibe uma lista de
personagens com navegação para uma tela de detalhes.

O objetivo das mudanças recentes foi manter a aplicação simples, legível e
fácil de explicar seguindo um padrão MVVM leve.

## Arquitetura (MVVM)

- Model: `lib/shared/models/character.model.dart` — representa os dados retornados
	pela API.
- Service: `lib/shared/services/character.service.dart` — faz as requisições HTTP
	para `https://rickandmortyapi.com/api/character` (suporta `page` e `name`) e
	retorna um `ApiResponse`.
- ViewModel: `lib/features/home/viewmodel/home.viewmodel.dart` — responsável por
	buscar os dados, controlar paginação/busca e expor `loading`, `error` e
	`characters` para a view.
- Views (agora organizadas em `view/`):
	- `lib/features/home/view/home.page.dart` — tela que lista os personagens,
		com campo de busca e scroll infinito. Consome `HomeViewModel`.
	- `lib/shared/widgets/card_character.widget.dart` — cartão de personagem que
		mostra imagem e nome; ao tocar, abre a tela de detalhes.
	- `lib/features/details/view/details.page.dart` — mostra `name`, `status`,
		`species` e informações adicionais (id, type, gender, origin, location,
		episódios e data de criação).

Essa separação mantém a lógica (requisições, tratamento de erro e estado)
fora das widgets, o que facilita testes e explicação do fluxo.


## Como rodar os testes

No PowerShell, na raiz do projeto:

```powershell
flutter test
```

Para rodar com cobertura:

```powershell
flutter test --coverage
```

## Observações rápidas

- O `appConfig` está disponível em `lib/config/app.config.dart` e pode ser usado
	para controlar comportamentos por ambiente (ex.: `appConfig.showDebugBanner`).

## Como executar (Windows / PowerShell)

1. Instale dependências:

```powershell
flutter pub get
```

2. Execute o app (dispositivo conectado ou emulador):

```powershell
flutter run
```

3. Analisar o código (opcional):

```powershell
flutter analyze
```
