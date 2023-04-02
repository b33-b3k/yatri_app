 import 'package:flutter/material.dart';
 
 SlidingUpPanel(
        // making false it does
        // not render outside
        renderPanelSheet: false,
        // panel
        panel: Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 253, 253, 253),
              borderRadius: BorderRadius.all(Radius.circular(24.0)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20.0,
                  color: Colors.grey,
                ),
              ]),
          margin: const EdgeInsets.all(24.0),
          child: const Center(
            child: Text("This is the SlidingUpPanel when open"),
          ),
        ),
        // collapsed
        collapsed: Container(
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
          ),
          child: const Center(child: null),
        ),
        body: const Center(
          child: Text("This the widget behind the Sliding panel"),
        ),
      ),



















      
      body: SlidingUpPanel(
        renderPanelSheet: false,
        panel: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
            boxShadow: [
              BoxShadow(
                blurRadius: 20.0,
                color: Colors.grey,
              ),
            ],
          ),
          margin: const EdgeInsets.all(24.0),
          child: const Center(
            child: Image(
              //up panel
              image: AssetImage('../../lib/assets/images/busstop.jpg'),
            ),
          ),
        ),
        
      ),