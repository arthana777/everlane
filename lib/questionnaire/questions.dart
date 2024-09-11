import 'package:everlane/bloc/question_bloc/bloc/question_bloc.dart';
import 'package:everlane/bloc/question_bloc/bloc/question_event.dart';
import 'package:everlane/bloc/question_bloc/bloc/question_state.dart';
import 'package:everlane/questionnaire/dropdown_widget.dart';
import 'package:everlane/questionnaire/result_page.dart';
import 'package:everlane/widgets/customcolor.dart';
import 'package:everlane/widgets/customfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  // String? selectedGender;
  String? selectedGenderKey;
  String? selectedHeight;
  String? selectedSkinType;
  String? selectedWeather;
  String? selectedUsage;

  List<Map<String, dynamic>> genderItems = [
    {"gender_name": "male", "gener_key": "M"},
    {"gender_name": "female", "gener_key": "F"}
  ];
  List<GenderModel> gendersList = [
    GenderModel(name: "Male", key: "M"),
    GenderModel(name: "Female", key: "F"),
  ];
  List<String> heightItems = ['SHORT', 'MEDIUM', 'TALL'];
  List<String> skinTypeItems = ['FAIR', 'MEDIUM', 'DARK'];
  List<String> weatherItems = ['WINTER', 'SUMMER', 'MONSOON', 'AUTUMN'];
  List<String> usageItems = ['CASUAL', 'FORMAL', 'SPORT', 'PARTY'];

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionBloc, QuestionState>(
        listener: (context, state) {
          if (state is QuestionLoading) {
            Fluttertoast.showToast(
              msg: "Data updated",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          } else if (state is QuestionUpdated) {
            Fluttertoast.showToast(
              msg: "Upadated Data",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ResultPage(),
              ),
            );
          } else if (state is QuestionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${state.message}')),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Provide structured and standardized responses, making the analysis process more streamlined and less time-consuming.",
              style: CustomFont().subText,
            ),
            SizedBox(height: 20.h),
            DropDownnLatest(
              hint: "Select Gender",
              onChanged: (value) {
                selectedGenderKey = value.key;
                setState(() {});
              },
              value: selectedGenderKey,
              dataList: gendersList,
            ),
            SizedBox(height: 10.h),
            DropDownnLatest(
              hint: "Select Height",
              onChanged: (value) {
                selectedHeight = value.name;
                setState(() {});
              },
              value: selectedHeight,
              dataList: heightItems.map((item) => DropdownModel(item)).toList(),
            ),
            SizedBox(height: 10.h),
            DropDownnLatest(
              hint: "Select Skin Type",
              onChanged: (value) {
                selectedSkinType = value.name;
                setState(() {});
              },
              value: selectedSkinType,
              dataList:
                  skinTypeItems.map((item) => DropdownModel(item)).toList(),
            ),
            SizedBox(height: 10.h),
            DropDownnLatest(
              hint: "Select Weather",
              onChanged: (value) {
                selectedWeather = value.name;
                setState(() {});
              },
              value: selectedWeather,
              dataList:
                  weatherItems.map((item) => DropdownModel(item)).toList(),
            ),
            SizedBox(height: 10.h),
            DropDownnLatest(
              hint: "Select Usages",
              onChanged: (value) {
                selectedUsage = value.name;
                setState(() {});
              },
              value: selectedUsage,
              dataList: usageItems.map((item) => DropdownModel(item)).toList(),
            ),
            SizedBox(height: 10.h),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10).w,
                  ),
                ),
                onPressed: () async {
                  print("Update button pressed");

                  // Collect the data from the dropdowns
                  Map<String, dynamic> data = {
                    "gender": selectedGenderKey,
                    "height": selectedHeight,
                    "skin_type": selectedSkinType,
                    "weather": selectedWeather,
                    "usages": selectedUsage,
                  };

                  print("Data to be sent: $data");

                  // Dispatch the event to update the question
                  BlocProvider.of<QuestionBloc>(context)
                      .add(UpdateQuestion(data: data));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResultPage(),
                    ),
                  );
                },
                child: Text("Update", style: CustomFont().buttontext),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ));
  }

  Widget buildDropdown(String title, String? value, List<String> items,
      ValueChanged<String?> onChanged) {
    return Container(
      height: 50.h,
      width: double.infinity.w,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 1),
            blurRadius: 1.0,
          ),
        ],
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.all(const Radius.circular(5).w),
      ),
      child: Center(
        child: ListTile(
          leading: Text(title, style: CustomFont().titleText),
          trailing: DropdownButton<String>(
            dropdownColor: Colors.white,
            alignment: Alignment.topRight,
            borderRadius: BorderRadius.circular(10).w,
            value: value,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: CustomFont().titleText,
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}

class GenderModel {
  final String? name;
  final String? key;
  GenderModel({this.name, this.key});
}

class DropdownModel {
  final String name;
  DropdownModel(this.name);
}
