import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:taskshare/bloc/account_bloc.dart';
import 'package:taskshare/model/service_provider.dart';

class AccountBlocProvider extends BlocProvider<AccountBloc> {
  AccountBlocProvider({
    @required Widget child,
  }) : super(
          child: child,
          creator: (context) {
            final container = ServiceProvider.of(context);
            return AccountBloc(authenticator: container.authenticator);
          },
        );

  static AccountBloc of(BuildContext context) => BlocProvider.of(context);
}
