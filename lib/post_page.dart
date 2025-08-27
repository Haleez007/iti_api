import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/post_cubit.dart';
import 'cubit/post_state.dart';
class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  @override
  void initState() {
    context.read<PostCubit>().updatePost();
    super.initState();

  }
  Widget build(BuildContext context) {
  return BlocBuilder<PostCubit,PostState>(
    builder: (context,state) {
    return Scaffold(
      appBar: AppBar(
        title: Text('product',
        ),
        centerTitle: true,
      ),
      body :Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Column(
        children: [
          if(state is LoadingPostState)...[
          SizedBox(height: 300,),
          Center(child: CircularProgressIndicator()),],
          if(state is SuccessPostState)
            Expanded(
              child: ListView.builder(
                itemCount: state.posts.length,
                padding: EdgeInsets.only(top: 22),
                itemBuilder: (context,index) {
                  return ListTile(
                    leading: Image.network('${state.posts[index]['thumbnail']}',
                    height: 85,
                    width: 90,
                      fit: BoxFit.contain,
                    ),
                    title: Text('${state.posts[index]['title']}'),
                    subtitle: Text('${state.posts[index]['tags']}'),

                  );
                },

    ),
            ),
          if(state is ErrorPostState)
            Center(child: Text(state.message)),
        ],
      ),
    ),
    );
  }
    );
  }}
