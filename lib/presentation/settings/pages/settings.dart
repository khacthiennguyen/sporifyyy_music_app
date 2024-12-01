import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sporifyyy/common/widgets/appbar/app_bar.dart';
import 'package:sporifyyy/presentation/settings/bloc/biometrics_cubit.dart';
import 'package:sporifyyy/presentation/settings/bloc/biometrics_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(25),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: BlocProvider(
          create: (_) => BiometricsCubit()..getuser(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Biometrics"),
              BlocBuilder<BiometricsCubit, BiometricsState>(
                builder: (context, state) {
                  if (state is BiometricsLoading) {
                    return CircularProgressIndicator();
                  }
                  if (state is BiometricsLoaded) {
                    return CupertinoSwitch(
                        value: state.userEntity.isBiometric!,
                        onChanged: (bool newValue) async {
                          context.read<BiometricsCubit>().updateBiometricsStatus();
                        });
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
