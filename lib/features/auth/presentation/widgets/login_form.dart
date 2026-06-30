import "package:flutter/material.dart";
import "package:flutter_application_1/core/l10n/app_localizations.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../domain/params/params.dart";
import "../blocs/blocs.dart";

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final i10n = AppLocalizations.of(context)!;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            final failure = state.failure;

            if (failure != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(failure.message)));
            }
          },
          child: Form(
            key: _formKey,
            autovalidateMode: .onUserInteraction,
            child: Padding(
              padding: const .symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: i10n.email),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return i10n.emailRequired;
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: i10n.password),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return i10n.passwordRequired;
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<AuthBloc>().add(
                          AuthLoginSubmitted(
                            params: LoginParams(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          ),
                        );
                      }
                    },
                    child: state.isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            i10n.login,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: .w600,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
