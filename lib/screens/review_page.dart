import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_supabase/blocs/reviews_bloc/review_bloc.dart';
import 'package:flutter_supabase/configs/routes.dart';
import 'package:flutter_supabase/widgets/dialog_widget.dart';

class ReviewScreen extends StatefulWidget {
  final int placeId;

  const ReviewScreen({Key? key, required this.placeId}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final TextEditingController commentController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ReviewBloc>().add(LoadReviews(widget.placeId));
  }

  @override
  void dispose() {
    commentController.dispose();
    ratingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Reviews'),
          backgroundColor: Colors.blueGrey,
          elevation: 4,
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ReviewBloc, ReviewState>(
                builder: (context, state) {
                  if (state is ReviewLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ReviewLoaded && state.reviews.isNotEmpty) {
                    return ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: state.reviews.length,
                      separatorBuilder: (_, __) => const Divider(color: Colors.grey),
                      itemBuilder: (context, index) {
                        final review = state.reviews[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              child: Text(review.rating.toString()),
                            ),
                            title: Text(review.comment, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 20),
                                const SizedBox(width: 4),
                                Text('${review.rating} Stars'),
                              ],
                            ),
                            isThreeLine: true,
                          ),
                        );
                      },
                    );
                  } else if (state is ReviewLoaded && state.reviews.isEmpty) {
                    return const Center(
                        child: Text('No reviews available', style: TextStyle(fontWeight: FontWeight.bold)));
                  } else if (state is ReviewError) {
                    return const Center(
                      child: Text('Some error happened, please check it again',
                          style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                    );
                  } else {
                    return const Center(child: Text('Loading reviews...'));
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          child: const Icon(Icons.add),
          onPressed: () {
            showCustomDialog(
              context,
              'please add a comment and rating',
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: commentController,
                      keyboardType: TextInputType.name,
                      decoration:
                          const InputDecoration(labelText: 'Comment', labelStyle: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: ratingController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          fillColor: Colors.white,
                          labelText: 'Rating',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ReviewBloc>().add(AddOrReplaceReview(
                            widget.placeId, commentController.text, int.parse(ratingController.text)));

                        Future.delayed(const Duration(milliseconds: 100), () {
                          Navigator.pushReplacementNamed(context, Routes.routeHome);
                        });
                      },
                      child: const Text('Submit Review'),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
