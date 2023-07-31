import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/app_constance/icon_constance.dart';
import 'custom_container.dart';

class LoadingHomeScreenWidget extends StatelessWidget {
  const LoadingHomeScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.white24,
      highlightColor: Colors.grey,
      child: ListView(
        children: [
          Container(
            width: media.width,
            height: media.height * .55,
            color: Colors.green,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15),
            child: Column(
              children: [
                CustomContainerWidget(media: media),
                const SizedBox(
                  height: 10,
                ),
                CustomContainerWidget(media: media),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 120),
                  child: CustomContainerWidget(media: media),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: media.width * .3,
                      height: media.height * .03,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadiusDirectional.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        width: media.width * .16,
                        height: media.height * .03,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadiusDirectional.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  // color: Colors.er,
                  alignment: Alignment.center,
                  height: media.height * .23,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 15,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: media.width * .22,
                            height: media.height * .17,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: media.width * .22,
                            height: media.height * .03,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: media.width * .3,
                      height: media.height * .03,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadiusDirectional.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        width: media.width * .16,
                        height: media.height * .03,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadiusDirectional.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Image.asset(
                      IconConstance.iPlayIcon,
                      width: 80,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
