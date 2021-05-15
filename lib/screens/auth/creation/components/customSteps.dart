import "package:flutter/material.dart";

class Step1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: (Colors.grey[350])!,
                        offset: const Offset(0, 8),
                        blurRadius: 18,
                        spreadRadius: 1.0)
                  ]),
              child: Text(
                "1",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Container(
              width: 80.0,
              height: 5.0,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: (Colors.grey[200])!,
                  offset: const Offset(0, 3),
                  blurRadius: 10,
                )
              ]),
            ),
          ],
        ),
      ],
    );
  }
}

class Step2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 5.0,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: (Colors.grey[200])!,
                  offset: const Offset(0, 3),
                  blurRadius: 10,
                )
              ]),
            ),
            Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: (Colors.grey[350])!,
                        offset: const Offset(0, 8),
                        blurRadius: 18,
                        spreadRadius: 1.0)
                  ]),
              child: Text(
                "2",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Expanded(
              child: Container(
                height: 5.0,
                width: 1,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: (Colors.grey[200])!,
                    offset: const Offset(0, 3),
                    blurRadius: 10,
                  )
                ]),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class Step3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 5.0,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: (Colors.grey[200])!,
                  offset: const Offset(0, 3),
                  blurRadius: 10,
                )
              ]),
            ),
            Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: (Colors.grey[350])!,
                        offset: const Offset(0, 8),
                        blurRadius: 18,
                        spreadRadius: 1.0)
                  ]),
              child: Text(
                "3",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
