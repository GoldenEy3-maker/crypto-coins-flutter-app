import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/core/di/get_it.dart";
import "package:flutter_application_1/core/l10n/app_localizations.dart";
import "package:flutter_application_1/features/posts/domain/usecases/usecases.dart";
import "package:flutter_application_1/features/posts/presentation/blocs/blocs.dart";
import "package:flutter_application_1/features/posts/presentation/views/views.dart";
import "package:flutter_bloc/flutter_bloc.dart";

@RoutePage()
class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final i10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(i10n.blocExampleInfiniteScrollPostsTitle)),
      body: BlocProvider(
        create: (context) =>
            PostsBloc(getPosts: getIt.get<GetPosts>())
              ..add(PostsFetchRequested()),
        child: const PostsListView(),
      ),
    );
  }
}
