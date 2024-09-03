import 'package:everlane/bloc/question_result/bloc/question_result_bloc.dart';
import 'package:everlane/bloc/question_result/bloc/question_result_event.dart';
import 'package:everlane/bloc/question_result/bloc/question_result_state.dart';
import 'package:everlane/widgets/customcolor.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:everlane/data/datasources/qst_service.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Recommended Product",
          style: CustomFont().appbarText,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) =>
            QuestionResultBloc(QstService())..add(FetchProduct()),
        child: BlocBuilder<QuestionResultBloc, QuestionResultState>(
          builder: (context, state) {
            if (state is QuestionResultLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QuestionResultLoaded) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of items per row
                  childAspectRatio: 0.75, // Aspect ratio of each item
                ),
                itemCount:
                    state.qstresult.length, // Assuming qstresults is a list
                itemBuilder: (context, index) {
                  final product = state.qstresult[index];
                  return Card(
                    color: CustomColor.buttoniconColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            product.image ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${product.name ?? ""}',
                              style: CustomFont().titleText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '${product.price?.toString() ?? "N/A"}',
                            style: CustomFont().subText,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  );
                },
              );
            } else if (state is QuestionResulError) {
              return Center(child: Text("Error: ${state.message}"));
            } else {
              return const Center(child: Text("No data"));
            }
          },
        ),
      ),
    );
  }
}
