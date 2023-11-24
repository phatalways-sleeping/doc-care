// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:auth_domain/auth_domain.dart';
import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/change_password/controller/change_password_bloc.dart';
import 'package:utility/utility.dart';

class DCChangePasswordScreen extends StatefulWidget {
  const DCChangePasswordScreen({super.key});

  @override
  State<DCChangePasswordScreen> createState() => _DCChangePasswordScreenState();
}

class _DCChangePasswordScreenState extends State<DCChangePasswordScreen> {
  Timer? _timer;
  int _start = 10;
  bool _timerStarted = false;

  void startTimer() {
    setState(() {
      _start = 10; // Reset the countdown
      _timerStarted = true;
    });

    const oneSec = Duration(seconds: 1);
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO(phucchuhoang): change appBar to custom app bar
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: BlocProvider(
        create: (_) => ChangePasswordBloc(
          NotificationManager.instance,
          SupabaseAuthenticationRepository.instance,
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.width * 0.05,
                      vertical: context.height * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Forgot Password',
                          style: context.textTheme.h6BoldPoppins.copyWith(
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          'Receive password reset link through email.',
                          style: context.textTheme.h1RegularPoppins.copyWith(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                          builder: (context, state) {
                            return DCOutlinedWithHeadingTextFormField(
                              heading: const Text('Email'),
                              headingColor: context.colorScheme.onSurface,
                              borderColor: context.colorScheme.onBackground,
                              color: context.colorScheme.onBackground,
                              borderRadius: 16,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (context, controller) {
                                context.read<ChangePasswordBloc>().add(
                                      EmailInputEvent(email: controller.text),
                                    );
                              },
                              onFocusChange: (context, focusNode) {
                                if (!focusNode.hasFocus) {
                                  context
                                      .read<ChangePasswordBloc>()
                                      .add(ValidateEmailEvent(state.email));
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: BlocBuilder<ChangePasswordBloc,
                              ChangePasswordState>(
                            builder: (context, state) {
                              // TODO(phucchuhoang): design what to do after send reset password link
                              if (_start > 0 && _timerStarted) {
                                // During cooldown period, show countdown
                                return Text(
                                  'Resend available in $_start seconds',
                                  style: context.textTheme.h1RegularPoppins
                                      .copyWith(fontSize: 16),
                                );
                              } else if (state is ChangePasswordError) {
                                // When there is an error
                                return DCButton(
                                  text: 'Email is not valid',
                                  onPressed: (context) {},
                                );
                              } else {
                                // Default state - button is enabled
                                return DCButton(
                                  text: 'Send reset password link',
                                  onPressed: (context) {
                                    context.read<ChangePasswordBloc>().add(
                                          ChangePasswordButtonPressedEvent(),
                                        );
                                    startTimer(); // Start or restart the timer
                                  },
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
