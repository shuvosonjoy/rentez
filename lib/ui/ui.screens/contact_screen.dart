
import 'package:flutter/material.dart';
import 'package:rent_ez/ui/ui.widgets/background_body.dart';


class ContactScreen extends StatefulWidget {
  const ContactScreen ({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact',style: TextStyle(
          color: Colors.amber,
          fontSize:30,
          fontWeight: FontWeight.w900,
        ),),
        elevation: 20,
        toolbarHeight:80,
        backgroundColor:Colors.black54,

      ),
      body: BackgroundBody(
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(30.0),
              child:Column(
                children: [
                  const SizedBox(height: 100,),
                  Text('Contact with rentEZ Team',style: TextStyle(
                    fontSize:20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black54,
                  ),),

                  const SizedBox(height:25,),
                  boxList,
                ],
              )
          ),

        ),
      ),
    );
  }


  SizedBox get boxList{
    return SizedBox(
      child:ListView.separated(
        itemCount:1,
        primary: false,
        shrinkWrap: true,
        itemBuilder:(context,index) {
          return SizedBox(
            height: 300,
            //width: 50,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 30,
              color: Colors.white,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.all(20),
                    child: Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Icon(Icons.email,color: Colors.deepPurple,),
                              const SizedBox(width: 10,),
                              Text('rentEZ@gmail.com',style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey
                              ),),
                            ],
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.phone,color: Colors.deepPurple,),
                              const SizedBox(width: 10,),
                              Text('01782163624',style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey
                              ),),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.facebook,color: Colors.deepPurple,),
                              const SizedBox(width: 10,),
                              Text('www.facebook.com/rentEZ',style: TextStyle(
                                fontSize:16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.webhook_sharp,color: Colors.deepPurple,),
                              const SizedBox(width: 10,),
                              Text('www.rentEZ.com',style: TextStyle(
                                fontSize:20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),

            ),
          );
        },
        separatorBuilder:(_,__) {
          return const SizedBox(
            height: 10,
          );
        },
      ),
    );
  }


}
