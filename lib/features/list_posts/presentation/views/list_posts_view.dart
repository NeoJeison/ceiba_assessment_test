import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ceiba_assessment_test/core/utils/size_config.dart';
import 'package:ceiba_assessment_test/core/widgets/text_display.dart';
import 'package:ceiba_assessment_test/dependency_injection.dart' as di;
import 'package:ceiba_assessment_test/core/utils/constants/styles.dart';
import 'package:ceiba_assessment_test/core/widgets/loading_spinner.dart';
import 'package:ceiba_assessment_test/core/widgets/information_item.dart';
import 'package:ceiba_assessment_test/features/list_users/domain/entities/user.dart';
import 'package:ceiba_assessment_test/features/list_posts/presentation/widgets/posts_list.dart';
import 'package:ceiba_assessment_test/features/list_posts/presentation/cubits/posts_list_cubit.dart';

class ListPostsView extends StatelessWidget {
  static String routeName = '/posts'; 

  const ListPostsView({Key? key}) : super(key: key);

  Widget _buildPostsList(BuildContext context) {
    return BlocBuilder<PostsListCubit, PostsListState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case Empty:
            return const Center(
              child: TextDisplay(message: 'List is empty')
            );
          case Loading:
            return const LoadingSpinner();
          case Loaded:
            return PostsList(posts: (state as Loaded).posts);
          case Error:
            return Center(
              child: TextDisplay(message: (state as Error).message)
            );
          default:
            return const Center(
              child: TextDisplay(message: 'No se pudieron cargar los usuarios correctamente.')
            );
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ModalRoute.of(context)!.settings.arguments != null ?
      ModalRoute.of(context)!.settings.arguments as User : null;

    if (user == null) {
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Prueba de Ingreso'
        ),
      ),
      body: BlocProvider(
        create: (context) => di.getIt<PostsListCubit>()..getPostsFromUser(user.id),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: SizeConfig.screenHeight! * 0.025,
                horizontal: SizeConfig.screenWidth! * 0.025
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextDisplay(
                    message: user!.name,
                    style: const TextStyle(
                      color: cDarkGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                    ),
                  ),
                  InformationItem(icon: Icons.phone, item: user.phone),
                  InformationItem(icon: Icons.email, item: user.email),
                ]
              )
            ),
            Expanded(
              child: _buildPostsList(context)
            )
          ],
        )
      )
    );
  }
}