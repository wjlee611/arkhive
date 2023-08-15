import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/cubit/penguin_cubit.dart';
import 'package:arkhive/models/common_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PenguinServerSelector extends StatelessWidget {
  const PenguinServerSelector({super.key});

  void _onSelected(BuildContext context, PenguinServer server) {
    final cubit = context.read<PenguinCubit>();
    if (cubit.state.server == server) return;

    cubit.loadPenguin(server: server);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PenguinCubit, PenguinState>(
      builder: (context, state) => PopupMenuButton(
        initialValue: state.server,
        onSelected: (server) => _onSelected(context, server),
        offset: const Offset(0, 0),
        icon: BlocBuilder<PenguinCubit, PenguinState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              if (state.status == CommonLoadState.loading) {
                return const SizedBox(
                  width: Sizes.size20,
                  height: Sizes.size20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: Sizes.size2,
                  ),
                );
              }
              return const Icon(
                Icons.storage,
                color: Colors.white,
              );
            }),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: Sizes.size5,
            color: Colors.blueGrey.shade700,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(Sizes.size10)),
        ),
        elevation: 0,
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: PenguinServer.cn,
            child: Text(
              'CN',
              style: TextStyle(
                fontSize: Sizes.size14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const PopupMenuItem(
            value: PenguinServer.us,
            child: Text(
              'US',
              style: TextStyle(
                fontSize: Sizes.size14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
