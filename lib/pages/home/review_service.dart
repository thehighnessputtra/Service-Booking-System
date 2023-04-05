import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_booking_system/utils/constant.dart';
import 'package:algorithmic/sorting.dart';

class ListReviewService extends StatefulWidget {
  final List<DocumentSnapshot> listHasilBooking;
  const ListReviewService({super.key, required this.listHasilBooking});

  @override
  State<ListReviewService> createState() => _ListReviewServiceState();
}

class _ListReviewServiceState extends State<ListReviewService> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100 * widget.listHasilBooking.length.toDouble(),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          // itemCount: 1,
          itemCount: widget.listHasilBooking.length,
          itemBuilder: (context, index) {
            final itemsList = widget.listHasilBooking[index];
            String storageNama = itemsList["nama"];
            String storageTipeMotor = itemsList["tipeMotor"];
            String storageRating = itemsList["rating"];
            String storageKomentar = itemsList["komentar"];

            // selectionSort(widget.listHasilBooking);
            // for (var currentIndex = 0;
            //     currentIndex <= widget.listHasilBooking.length - 1;
            //     currentIndex++) {
            //   var smallerIndex = currentIndex;
            //   for (var i = currentIndex + 1;
            //       i <= widget.listHasilBooking.length;
            //       i++) {
            //     if (widget.listHasilBooking[i] < widget.listHasilBooking[smallerIndex]) {
            //       smallerIndex = i;
            //     }
            //   }
            //   final tmp = widget.listHasilBooking[currentIndex];
            //   widget.listHasilBooking[currentIndex] =
            //       widget.listHasilBooking[smallerIndex];
            //   widget.listHasilBooking[smallerIndex] = tmp;
            // }
            // print("HASIL ${widget.listHasilBooking}");
            return storageRating == "Belum ada rating"
                ? const SizedBox()
                : Container(
                    color: Colors.lightGreen[300],
                    padding: const EdgeInsets.all(3),
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(children: [
                                Row(
                                  children: [
                                    Text(storageRating, style: size18),
                                    const SizedBox(
                                      width: 2.0,
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 18,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(storageTipeMotor,
                                        style: size14.copyWith(
                                            color:
                                                Colors.black.withOpacity(0.7))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(storageNama, style: size14),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text('"$storageKomentar"',
                                            style: size14)),
                                  ],
                                ),
                              ]),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
          }),
    );
  }
}
