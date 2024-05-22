import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';

class JobRealCariTileWidget extends StatelessWidget {
  final String hasil;
  final String jobreal1Id;
  final String materi;
  final String picName;
  final DateTime realJam;
  final DateTime realTgl;
  final String catName;
  final String jobNama;
  final String mediaNama;
  final String customerNama;

  const JobRealCariTileWidget(
      {super.key,
      required this.hasil,
      required this.jobreal1Id,
      required this.materi,
      required this.picName,
      required this.realJam,
      required this.realTgl,
      required this.catName,
      required this.jobNama,
      required this.mediaNama,
      required this.customerNama});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        elevation: 2,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Registration ID",
                          style: MyText.bodyLarge(context)!
                              .copyWith(color: MyColors.grey_40)),
                      Container(height: 5),
                      Text(jobreal1Id,
                          style: MyText.bodyLarge(context)!
                              .copyWith(color: MyColors.grey_80)),
                      Container(height: 10),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date",
                          style: MyText.bodyLarge(context)!
                              .copyWith(color: MyColors.grey_40)),
                      Container(height: 5),
                      Text(
                          "${DateFormat('dd/MM/yyyy').format(realTgl)} ${DateFormat('HH:mm').format(realJam)}",
                          style: MyText.bodyLarge(context)!
                              .copyWith(color: MyColors.grey_80)),
                      Container(height: 10),
                    ],
                  ),
                ),
              ],
            ),
            Text("Customer",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),            
            Text(customerNama,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),            
            Text("Perihal",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(materi,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("Feedback",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(hasil,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
          ]),
        ));
  }
}
