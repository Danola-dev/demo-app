import 'package:demo_app/models/categories.dart';
import 'package:demo_app/models/shoes.dart';
import 'package:flutter/material.dart';

const availableCategories = [
  Category(id: 'Nike', title: 'Nike'),
  Category(id: 'c2', title: 'Adidas'),
  Category(id: 'c3', title: 'Converse'),
];

const dummyShoes = [
  Shoes(
    id: 's1',
    category: 'Nike',
    title: 'Nike Pegasus 42',
    imageUrl:
        'https://static.nike.com/a/images/t_web_pw_592_v2/f_auto/u_9ddf04c7-2a9a-4d76-add1-d15af8f0263d,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/dfa628f5-3f72-457b-b7ec-17e685f6b979/W+NIKE+AIR+ZOOM+PEGASUS+42.png',
    price: 105,
    rating: 4.5,
    color: [Colors.white, Colors.black, Colors.greenAccent, Colors.redAccent],
    size: [39, 40, 41, 42, 43],
    details: "Quality Women's Road Running Shoes",
  ),
  Shoes(
    id: 's2',
    category: 'Adidas',
    title: 'Jordan 11 Retro low',
    imageUrl:
        'https://static.nike.com/a/images/t_web_pw_592_v2/f_auto/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/899cb535-08a1-40dc-a045-557edb3e8de5/JORDAN+11+RETRO+LOW+%28TD%29.png',
    price: 80,
    rating: 4.5,
    color: [Colors.lightBlueAccent, Colors.redAccent, Colors.blueGrey],
    size: [40, 41, 42, 43],
    details: 'Quality fitted shoes designed to keep your feet dry',
  ),
  Shoes(
    id: 's3',
    category: 'Converse',
    title: 'Nike Air Force 1',
    imageUrl:
        'https://static.nike.com/a/images/t_web_pw_592_v2/f_auto/u_9ddf04c7-2a9a-4d76-add1-d15af8f0263d,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/e777c881-5b62-4250-92a6-362967f54cca/WMNS+AIR+FORCE+1+%2707.png',
    price: 90,
    rating: 5.0,
    color: [Colors.white, Colors.black],
    size: [40, 41, 42, 43, 44],
    details:
        'The Nike Air Force 1 is a polyester fabric designed to help keep your feet more comfortable',
  ),
  Shoes(
    id: 's4',
    category: 'Nike',
    title: 'Nike Zoom Vomero',
    imageUrl:
        'https://static.nike.com/a/images/t_web_pw_592_v2/f_auto/u_9ddf04c7-2a9a-4d76-add1-d15af8f0263d,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/lkwfba88t6qix4qxaavi/NIKE+ZOOM+VOMERO+5.png',
    price: 70,
    rating: 4.0,
    color: [Colors.grey, Colors.white10],
    size: [40, 41, 42, 43, 44, 45],
    details:
        'The Nike Air Force 1 is a polyester fabric designed to help keep your feet more comfortable',
  ),
];
