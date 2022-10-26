import 'package:flutter/material.dart';
import 'package:flutter_pokedex_2022/common/error/failure.dart';
import 'package:flutter_pokedex_2022/common/models/pokemon.dart';
import 'package:flutter_pokedex_2022/common/repositories/pokemon_repository.dart';
import 'package:flutter_pokedex_2022/common/widgets/po_error.dart';
import 'package:flutter_pokedex_2022/common/widgets/po_loading.dart';
import 'package:flutter_pokedex_2022/features/pokedex/screens/details/pages/detail_page.dart';
import 'package:flutter_pokedex_2022/features/pokedex/screens/home/pages/home_error.dart';
import 'package:flutter_pokedex_2022/features/pokedex/screens/home/pages/home_loading.dart';

class DetailArguments {
  DetailArguments({required this.name});
  final String name;
}

class DetailContainer extends StatelessWidget {
  const DetailContainer(
      {super.key, required this.repository, required this.arguments});
  final IPokemonRepository repository;
  final DetailArguments arguments;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pokemon>>(
      future: repository.getAllPokemons(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return PoLoading();
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return DetailPage(name: arguments.name, list: snapshot.data!);
        }

        if (snapshot.hasError) {
          return PoError(
            error: (snapshot.error as Failure).message!,
          );
        }

        return Container();
      },
    );
  }
}
