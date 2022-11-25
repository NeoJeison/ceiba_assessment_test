import 'package:ceiba_assessment_test/core/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ceiba_assessment_test/core/utils/size_config.dart';
import 'package:ceiba_assessment_test/features/list_users/presentation/widgets/users_list.dart';
import 'package:ceiba_assessment_test/core/widgets/text_display.dart';
import 'package:ceiba_assessment_test/core/widgets/loading_spinner.dart';
import 'package:ceiba_assessment_test/features/list_users/presentation/cubits/users_list_cubit.dart';

class ListUsersView extends StatelessWidget {
  static String routeName = '/'; 

  const ListUsersView({Key? key}) : super(key: key);

  Widget _buildUsersList(BuildContext context) {
    return BlocBuilder<UsersListCubit, UsersListState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case Empty:
            return const Center(
              child: TextDisplay(message: 'List is empty')
            );
          case Loading:
            return const LoadingSpinner();
          case Loaded:
            return UsersList(users: (state as Loaded).users);
          case Filtered:
            final users = (state as Filtered).filteredUsers;
            return users.isEmpty ? const Center(
              child: TextDisplay(message: 'List is empty')
            ) : UsersList(users: users);
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
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prueba de Ingreso'
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.screenHeight! * 0.025,
              horizontal: SizeConfig.screenWidth! * 0.025
            ),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Buscar usuario",
                labelStyle: TextStyle(
                  color: cDarkGreen
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: cDarkGreen
                  )
                )
              ),
              onChanged: (value) {
                context.read<UsersListCubit>().search(value);
              },
            ),
          ),
          Expanded(
            child: _buildUsersList(context)
          )
        ],
      )
    );
  }
}