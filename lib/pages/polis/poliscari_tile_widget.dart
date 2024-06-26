import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';

class PolisCariTileWidget extends StatelessWidget {
  final double cstPremi;
  final String insuredNama;
  final DateTime periodeAkhir;
  final DateTime periodeAwal;
  final String polisNo;
  final String polis1Id;
  final double tsi;
  final String cobNama;
  final String rekanNama;
  final String curr;
  final String sppaNo;

  const PolisCariTileWidget(
      {super.key,
      required this.cstPremi,
      required this.insuredNama,
      required this.periodeAkhir,
      required this.periodeAwal,
      required this.polisNo,
      required this.polis1Id,
      required this.tsi,
      required this.cobNama,
      required this.rekanNama,
      required this.curr,
      required this.sppaNo});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.amber[50],
        margin: const EdgeInsets.symmetric(horizontal: 10),
        elevation: 2,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(sppaNo,
                    textAlign: TextAlign.left,
                    style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80, fontWeight: FontWeight.w700)),
                const Spacer(),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(40)),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(" $cobNama ",
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.titleSmall),
                    ),
                  ),
                ),
              ],
            ),
            Text(insuredNama,
                textAlign: TextAlign.left,
                maxLines: 1,
                style: MyText.titleLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Row(
              children: [
                Text(
                    '${DateFormat('dd/MM/yyyy').format(periodeAwal)} - ${DateFormat('dd/MM/yyyy').format(periodeAkhir)}',
                    textAlign: TextAlign.left,
                    style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80, fontWeight: FontWeight.w700))
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("TSI :",
                          style: MyText.bodyLarge(context)!
                      .copyWith(color: MyColors.grey_40)),
                      Container(height: 5),
                      Text('$curr ${NumberFormat("#,###").format(tsi)}',
                          style: MyText.bodyLarge(context)!
                      .copyWith(color: MyColors.grey_80, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Premi :",
                          style: MyText.bodyLarge(context)!
                      .copyWith(color: MyColors.grey_40)),
                      Container(height: 5),
                      Text("$curr ${NumberFormat("#,###").format(cstPremi)}",
                        textAlign: TextAlign.right,
                        style: MyText.bodyLarge(context)!
                        .copyWith(color: MyColors.grey_80, fontWeight: FontWeight.w700))
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ));
  }
}
