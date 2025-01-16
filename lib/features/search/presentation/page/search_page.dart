import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cubit/page_mode_cubit.dart';
import '../bloc/recomandSearch/recomand_search_cubit.dart';
import '../bloc/searchCubit/search_cubit.dart';
import '../widgets/recomand_search.dart';
import '../widgets/search_fieald.dart';
import '../widgets/search_output.dart';
import '../../../../service_locator.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<SearchCubit>()..getTrandingMedia(),
        ),
        BlocProvider(
          create: (context) => sl<RecomandSearchCubit>(),
        ),
        BlocProvider(
          create: (context) => PageModeCubit(),
        )
      ],
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            const SearchFieald(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
                children: [
                  BlocBuilder<PageModeCubit, PageModeState>(
                    builder: (context, state) {
                      if (state is SearchModeState) {
                        return const RecomandSearch();
                      } else {
                        return const SearchOutput();
                      }
                    },
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
