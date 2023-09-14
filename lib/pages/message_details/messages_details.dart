import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_dashboard/helpers/function_helper.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/models/user_model.dart';
import 'package:flutter_web_dashboard/widgets/texts.dart';

import '../../bloc/suggestion_cubit/suggestion_cubit.dart';
import '../../constants/constans.dart';
import '../../models/SupportMessage.dart';
import '../../widgets/fields.dart';

class MessagesDetails extends StatefulWidget {
  final String userId;


  MessagesDetails({required this.userId});

  @override
  State<MessagesDetails> createState() => _MessagesDetailsState();
}

class _MessagesDetailsState extends State<MessagesDetails> {

  final TextEditingController _controllerMessages = TextEditingController();
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SuggestionCubit.get(context).getMessagesUser(userId: widget.userId).then((value){


    });

  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerMessages.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SuggestionCubit, SuggestionState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (ctx,state){
        if(state is GetMessagesSuccess){

          Future.delayed(Duration.zero,(){
            _controller.animateTo(
              _controller.position.maxScrollExtent,
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
            );
          });




        }

        return Scaffold(
          body: Center(
            child: Container(

              margin: EdgeInsets.symmetric(vertical: 20),
                width:ResponsiveWidget.isSmallScreen(context)?double.infinity: 600,
                height: 700,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(color: Colors.blue,width: 2),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: SuggestionCubit.get(context).loadGetMessages
                    ? Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      color: Colors.blue,
                    ),
                  ),
                ):Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _controller,

                        itemCount: SuggestionCubit.get(context).messagesUser.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (ctx, index){
                        ResponseMessage message=    SuggestionCubit.get(context).messagesUser[index];
                        return Row(
                         mainAxisAlignment:message.support!.sender=="admin"? MainAxisAlignment.end:MainAxisAlignment.start,
                          children: [
                         Container(
                           width:ResponsiveWidget.isSmallScreen(context)?double.infinity: 500,
                           margin: EdgeInsets.all(3),
                           padding: EdgeInsets.all(3),

                           child: ListTile(
                             leading:message.support!.sender=="admin"?Text(
                               message.support!.date.split("T")[0],

                               style: TextStyle(fontSize: 12,color: Colors.black),
                             ) : Container(
                               width: 50,
                               height: 50,
                               decoration: BoxDecoration(
                                 border: Border.all(color: Colors.black.withOpacity(.5),width: 2),
                                 borderRadius: BorderRadius.circular(25)
                               ),
                               child: ClipRRect(
                                 borderRadius: BorderRadius.circular(30),
                                 child: CachedNetworkImage(
                                   imageUrl:
                                   "$baseUrlImages${message.sender!.imageUrl}",
                                   height: 50,
                                   width: 50,
                                   placeholder: (context, url) => Center(
                                       child: CircularProgressIndicator()),
                                   errorWidget: (context, url, error) =>
                                       Icon(Icons.person),
                                 ),
                               ),
                             ),
                             trailing: message.support!.sender=="admin"?Container(
                               width: 50,
                               height: 50,
                               decoration: BoxDecoration(
                                   border: Border.all(color: Colors.black.withOpacity(.5),width: 2),
                                   borderRadius: BorderRadius.circular(25)
                               ),
                               child: ClipRRect(
                                 borderRadius: BorderRadius.circular(30),
                                 child: CachedNetworkImage(
                                   imageUrl:
                                   "$baseUrlImages${currentUser!.imageUrl}",
                                   height: 50,
                                   width: 50,
                                   placeholder: (context, url) => Center(
                                       child: CircularProgressIndicator()),
                                   errorWidget: (context, url, error) =>
                                       Icon(Icons.person),
                                 ),
                               ),
                             ):Text(
                               message.support!.date.split("T")[0],

                               style: TextStyle(fontSize: 12,color: Colors.black),
                             ) ,
                             title: Container(
                               padding: EdgeInsets.all(4),
                               child: Text(
                                 message.support!.sender=="admin"?"Admin" :message.sender!.fullName??"",
                                 textAlign: message.support!.sender=="admin"? TextAlign.end:TextAlign.start,
                                 style: TextStyle(fontSize: 16,color: message.support!.sender=="admin"?Colors.red:Colors.black),
                               ),
                             ),
                             subtitle: Container(
                               padding: EdgeInsets.all(20),
                               decoration: BoxDecoration(
                                 color:message.support!.sender=="admin"?  Colors.deepOrangeAccent.withOpacity(.5)   : Colors.green.withOpacity(.5),
                                 borderRadius:      BorderRadius.only(
                                   topRight:message.support!.sender=="admin"? Radius.circular(15):Radius.circular(0),
                                   topLeft:message.support!.sender=="admin"? Radius.circular(0):Radius.circular(15),
                                   bottomLeft: Radius.circular(15),
                                   bottomRight: Radius.circular(15),
                                 ),

                               ),
                               child: Text(
                                 message.support!.message??"",
                                 textAlign:message.support!.sender=="admin"? TextAlign.end:TextAlign.start,
                                 style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                               ),
                             ),
                           ),
                         )
                          ],
                        );
                      }),

                    ),
                    // container send message
                    Container(
                      height: 60,
                      width: double.infinity,

                      margin: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextField2(
                              controller: _controllerMessages,
                              hint: "اضافة رد جديد",
                              inputType: TextInputType.text,
                            ),
                          ),
                          SizedBox(width: 20,),
                            IconButton(onPressed: (){
                              SupportMessage message = new SupportMessage( message: _controllerMessages.text, userId: widget.userId, sender: "admin",date: DateTime.now().toString());

                              if(_controllerMessages.text.isNotEmpty){

                                SuggestionCubit.get(context).addMessage(message).then((value){

                                });
                                _controllerMessages.text="";
                              }
                            }, icon: Icon(
                              Icons.send,color: Colors.green,
                            ))

                        ],
                      ),
                    )
                  ],
                )

            ),
          ),
        );
      },
    );
  }
}
