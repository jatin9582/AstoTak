import 'package:astrotak/model/astrologermodel.dart';
import 'package:flutter/material.dart';

class AstrologerCard extends StatelessWidget{

  final AstrologerModel astrologerModel;

  const AstrologerCard(this.astrologerModel,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              // color: Colors.red,
              child: astrologerModel.imageUrl != null
                  ?
              Image.network(astrologerModel.imageUrl!,errorBuilder:(context, url, error) => const Icon(Icons.error) ,)
                  : null,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(astrologerModel.fullName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .subtitle1!
                                .apply(
                                    color: Colors.black, fontWeightDelta: 12)),
                      ),
                      Text(
                        '${astrologerModel.experience} Years',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle2!
                            .apply(color: Colors.black),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  imageAndText('assets/images/talk.png',
                      astrologerModel.skills.join(',')),
                  const SizedBox(
                    height: 10,
                  ),
                  imageAndText('assets/images/talk.png',
                      astrologerModel.languages.join(',')),
                  const SizedBox(
                    height: 10,
                  ),
                  imageAndText('assets/images/talk.png', '₹${astrologerModel.pricePerMinute.toStringAsFixed(0)}/Min',
                      fontWeight: FontWeight.w800),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width:MediaQuery.of(context).size.width*0.4,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xffFF944D),
                            minimumSize: Size(90, 50)),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.call),
                            Expanded(
                                child: Text(
                              'Talk on Call',
                              textAlign: TextAlign.center,
                            ))
                          ],
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const Divider(),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget imageAndText(String image, String text,
      {FontWeight fontWeight = FontWeight.w400}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 20,
            height: 20,
            child: Image.asset(
              image,
              color: Colors.red,
            )),
        const SizedBox(
          width: 5,
        ),
        Flexible(
            flex: 3,
            child: Text(
              text,
              style: TextStyle(fontWeight: fontWeight),
            )),
        Flexible(child: Container())
      ],
    );
  }

}