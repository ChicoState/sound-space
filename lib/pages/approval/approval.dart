import 'package:flutter/material.dart';
import 'package:soundspace/constants/style.dart';
//user authentication
import 'package:soundspace/pages/account/application_state.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/pages/account/authentication.dart';
//routing
import 'package:get/get.dart';
import 'package:soundspace/constants/controllers.dart';
import 'package:soundspace/helpers/responsiveness.dart';
//other
import 'approval_request_form.dart';
import 'view_approvals.dart';

class ApprovalPage extends StatelessWidget {
  const ApprovalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width; // page width
    double _height = MediaQuery.of(context).size.height; // page height
    return Scaffold(
      body: Container(
          // background color of upload page
          height: _height,
          width: _width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                // define gradient colors (top left to bottom right)
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple.shade100, Colors.blue.shade100]),
          ),
          child: Padding(
              padding: EdgeInsets.fromLTRB(_width / 10, _height / 13,
                  _width / 10, _height / 13), // left, top, right, bottom
              child: Container(
                  // define container to hold upload prompts
                  height: MediaQuery.of(context).size.height * 0.66,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.grey.shade50, Colors.grey.shade200]),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 6),
                            color: lightGrey.withOpacity(0.1),
                            blurRadius: 12)
                      ],
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // BEGIN APPROVAL PAGE (ABOVE IS ONLY STYLING)
                      Consumer<ApplicationState>(
                        builder: (context, appState, _) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            if (appState.loginState ==
                                ApplicationLoginState.loggedIn) ...[
                              //form to submit artwork for approval
                              const ApprovalRequestForm(),
                              //list of approvals with option to reject (remove)
                              const SizedBox(height: 8),
                              //list of approvals with option to reject (remove)
                              const SizedBox(
                                height: 350,
                                child: SingleChildScrollView(
                                    child: ViewApprovals()),
                              )
                            ] else ...[
                              //user is logged out, prompt redirect to account page
                              const Center(
                                  child: Text(
                                'Please log in to approve/request approval',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              )),
                              SizedBox(height: _height / 64),
                              ElevatedButton(
                                  // Created elevated button with gradient style
                                  onPressed: () {
                                    menuController
                                        .changeActiveItemTo("Account");
                                    if (ResponsiveWidget.isSmallScreen(
                                        context)) {
                                      Get.back();
                                    }
                                    navigationController.navigateTo("/account");
                                  },
                                  // define button theme and text
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors
                                          .transparent, // hide large button
                                      shadowColor: Colors
                                          .transparent, // hide button shadow
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  // add gradient to button
                                  child: Ink(
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                              colors: [
                                                Colors.purpleAccent,
                                                Colors.blueAccent
                                              ]),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      // define container to hold the text button
                                      child: Container(
                                          height: 50,
                                          width: 200,
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Log In',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ))))
                            ],
                          ],
                        ),
                      )
                    ],
                  )))),
    );
  }
}
