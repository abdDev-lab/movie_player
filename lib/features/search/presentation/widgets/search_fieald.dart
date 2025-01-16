import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cubit/page_mode_cubit.dart';
import '../bloc/recomandSearch/recomand_search_cubit.dart';
import 'package:uicons/uicons.dart';

class SearchFieald extends StatefulWidget {
  const SearchFieald({super.key});

  @override
  State<SearchFieald> createState() => _SearchFiealdState();
}

class _SearchFiealdState extends State<SearchFieald> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    
      margin: const EdgeInsets.only(left: 16, right: 16, top: 32 , bottom: 16),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          suffixIcon: BlocBuilder<PageModeCubit, PageModeState>(
            builder: (context, state) {
              if (state is SearchModeState) {
                return IconButton(
                    onPressed: () {
                      BlocProvider.of<PageModeCubit>(context).borwseMode();
                      textEditingController.clear();
                      FocusScope.of(context).unfocus();
                    },
                    icon: Icon(
                      UIcons.regularRounded.cross,
                      size: 18,
                    ));
              } else {
                return const SizedBox();
              }
            },
          ),
          prefixIcon: Icon(UIcons.regularRounded.search),
          hintText: "Search",
          
        ),
        onTap: () {
          BlocProvider.of<PageModeCubit>(context).searchMode();
        },
        onChanged: (value) {
          BlocProvider.of<RecomandSearchCubit>(context)
              .getRecomandMedia(textEditingController);
        },
      ),
    );
  }
}
