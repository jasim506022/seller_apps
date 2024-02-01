import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seller_apps/const/const.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../const/utils.dart';
import '../../model/profilemodel.dart';
import '../../service/database/firebasedatabase.dart';
import '../../widget/empty_widget.dart';

class DeliveryUserProfileWidget extends StatelessWidget {
  const DeliveryUserProfileWidget({
    super.key,
    required this.userId,
    required this.orderId,
  });

  final String userId, orderId;

  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    String formattedDate = DateFormat('hh:mm a, MMM d, yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(int.parse(orderId)));
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Text(
            "User Details: ",
            style: textstyle.largeBoldText.copyWith(color: red),
          ),
        ),
        StreamBuilder(
            stream: FirebaseDatabase.userDetailsSnaphots(userId: userId),
            builder: (context, usersnapshots) {
              if (usersnapshots.connectionState == ConnectionState.waiting) {
                return const DeliveryUserLoading();
              } else if (usersnapshots.hasData) {
                ProfileModel userProfile =
                    ProfileModel.fromMap(usersnapshots.data!.data()!);

                return Container(
                  height: mq.height * .155,
                  width: mq.width,
                  // color: Colors.red,
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: mq.height * .011,
                        horizontal: mq.width * .044),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: mq.height * 0.12,
                          width: mq.height * 0.12,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: red, width: 2)),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(mq.height * 0.06),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: userProfile.imageurl!,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                backgroundColor: white,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: mq.width * 0.05,
                        ),
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: mq.width * 0.022),
                              child: Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(3),
                                  1: FlexColumnWidth(7),
                                },
                                children: [
                                  _buildTableRow(
                                      context, "Name", userProfile.name!),
                                  _buildTableRow(
                                      context, "Email", userProfile.email!),
                                  _buildTableRow(context, "Phone",
                                      "0${userProfile.phone!}"),
                                  _buildTableRow(
                                      context, "Order", formattedDate),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                );
              } else if (usersnapshots.hasError) {
                return EmptyWidget(
                  image: 'asset/empty/empty.png',
                  title: 'Error Found: ${usersnapshots.hasError}',
                );
              }
              return const DeliveryUserLoading();
            }),
      ],
    );
  }

  TableRow _buildTableRow(BuildContext context, String title, String value) {
    Textstyle textstyle = Textstyle(context);
    return TableRow(
      children: [
        TableCell(
          child: Text(
            title,
            style: textstyle.mediumTextbold
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        TableCell(
          child: Text(
            value,
            style: textstyle.mediumText600
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        SizedBox(
          height: mq.height * 0.025,
        ),
      ],
    );
  }
}

class DeliveryUserLoading extends StatelessWidget {
  const DeliveryUserLoading({super.key});

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return Container(
        height: mq.height * .155,
        width: mq.width,
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: mq.height * .011, horizontal: mq.width * .044),
          child: Shimmer.fromColors(
            baseColor: utils.baseShimmerColor,
            highlightColor: utils.highlightShimmerColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: mq.height * 0.12,
                  width: mq.height * 0.12,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: utils.widgetShimmerColor),
                ),
                SizedBox(
                  width: mq.width * 0.05,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: mq.width * 0.022),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        globalMethod.buildShimmerTextContainer(
                            utils.widgetShimmerColor, mq.height * 0.017),
                        globalMethod.buildShimmerTextContainer(
                            utils.widgetShimmerColor, mq.height * 0.017),
                        globalMethod.buildShimmerTextContainer(
                            utils.widgetShimmerColor, mq.height * 0.017),
                        globalMethod.buildShimmerTextContainer(
                            utils.widgetShimmerColor, mq.height * 0.017),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
