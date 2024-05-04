import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_supabase/blocs/auth_bloc/auth_bloc.dart';

import 'package:flutter_supabase/blocs/places_bloc/places_bloc.dart';
import 'package:flutter_supabase/blocs/reviews_bloc/review_bloc.dart';
import 'package:flutter_supabase/repository/supabase_repository.dart';
import 'package:flutter_supabase/api/supabase_manager.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;
  final SupabaseManager supabaseManager;

  const AppBlocProvider({Key? key, required this.child, required this.supabaseManager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlaceBloc>(
          create: (context) => PlaceBloc(SupabaseRepository(supabaseManager)),
        ),
        BlocProvider<ReviewBloc>(
          create: (context) => ReviewBloc(SupabaseRepository(supabaseManager)),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(SupabaseRepository(supabaseManager)),
        ),
      ],
      child: child,
    );
  }
}
