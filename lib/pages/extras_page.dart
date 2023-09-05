import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../model/states/smc_state.dart';
import '../widgets/smc_detail.dart';

class ExtrasPage extends StatelessWidget {
  const ExtrasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final responsiveWrapper = ResponsiveWrapper.of(context);

    return ListView(
      children: <Widget>[
        SizedBox(height: 24),
        Consumer<SmcState>(builder: (context, model, child) {
          return responsiveWrapper.isSmallerThan(DESKTOP)
              ? Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SMC and TPC Details',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      MaterialButton(
                        onPressed: () {
                          model.selectedMember = SelectedMember.SMC;
                        },
                        color: model.selectedMember == SelectedMember.SMC
                            ? Colors.purple
                            : Colors.blue,
                        child: Text(
                          "School Management Committee",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 16),
                      MaterialButton(
                        onPressed: () {
                          model.selectedMember = SelectedMember.TPC;
                        },
                        color: model.selectedMember == SelectedMember.TPC
                            ? Colors.purple
                            : Colors.blue,
                        child: Text(
                          "Teacher Parents Committee",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              : Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 36.0),
                      child: Text(
                        'SMC and TPC Details',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 16),
                    MaterialButton(
                      onPressed: () {
                        model.selectedMember = SelectedMember.SMC;
                      },
                      color: model.selectedMember == SelectedMember.SMC
                          ? Colors.purple
                          : Colors.blue,
                      child: Text(
                        "School Management Committee",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 16),
                    MaterialButton(
                      onPressed: () {
                        model.selectedMember = SelectedMember.TPC;
                      },
                      color: model.selectedMember == SelectedMember.TPC
                          ? Colors.purple
                          : Colors.blue,
                      child: Text(
                        "Teacher Parents Committee",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                );
        }),
        SizedBox(height: 16),
        Divider(
          thickness: 2,
          color: Colors.black,
        ),
        StickyHeader(),
        SizedBox(height: 16),
        Consumer<SmcState>(builder: (context, model, child) {
          if (!model.loading) {
            return ListView.builder(
                itemCount: model.selectedMember == SelectedMember.SMC
                    ? model.smcs.length
                    : model.tpcs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final member = model.selectedMember == SelectedMember.SMC
                      ? model.smcs[index]
                      : model.tpcs[index];
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: size.width,
                      child: SmcDetail(
                        name: member.name,
                        phoneNumber: member.phoneNumber ?? "N/A",
                        email: member.email ?? "N/A",
                        address: member.address,
                        post: member.post,
                      ),
                    ),
                  );
                });
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 36,
                  height: 36,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            );
          }
        })
      ],
    );
  }
}

class StickyHeader extends StatelessWidget {
  const StickyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  'Name',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Post',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Email',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Phone',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Address',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.black,
          thickness: 2,
        ),
      ],
    );
  }
}
