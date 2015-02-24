import "package:lson/lson.dart";

const String IN = r"""
[
  {
    "_id": "54ebfff807e2d5bf2dc64747",
    "index": 0,
    "guid": "0498a877-fad4-465e-b6f0-203d9b644684",
    "isActive": false,
    "balance": "$3,234.93",
    "picture": "http://placehold.it/32x32",
    "age": 28,
    "eyeColor": "green",
    "name": {
      "first": "Renee",
      "last": "Ramsey"
    },
    "company": "ANDRYX",
    "email": "renee.ramsey@andryx.com",
    "phone": "+1 (803) 547-2953",
    "address": "518 Poplar Avenue, Freetown, Nevada, 5537",
    "about": "Qui incididunt labore sunt culpa ex labore consectetur pariatur dolore sit sint labore laboris fugiat. Aliquip id tempor mollit ullamco voluptate fugiat voluptate aliqua qui. Ullamco veniam veniam culpa ut proident nostrud. Proident excepteur fugiat elit do incididunt Lorem duis. Ex ea consequat ut laborum consectetur.\r\n",
    "registered": "Monday, August 4, 2014 2:30 AM",
    "latitude": 72.029693,
    "longitude": -78.536197,
    "tags": [
      "qui",
      "nisi",
      "sit",
      "mollit",
      "sunt",
      "mollit",
      "culpa"
    ],
    "range": [
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9
    ],
    "friends": [
      {
        "id": 0,
        "name": "Singleton French"
      },
      {
        "id": 1,
        "name": "Summers Skinner"
      },
      {
        "id": 2,
        "name": "Daphne Nicholson"
      }
    ],
    "greeting": "Hello, Renee! You have 10 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "54ebfff86c30afe3c2f1e2ab",
    "index": 1,
    "guid": "02d025d8-0ee6-44b6-9b44-5e5e1df63127",
    "isActive": false,
    "balance": "$3,233.43",
    "picture": "http://placehold.it/32x32",
    "age": 30,
    "eyeColor": "brown",
    "name": {
      "first": "Alexis",
      "last": "Waters"
    },
    "company": "ISIS",
    "email": "alexis.waters@isis.net",
    "phone": "+1 (981) 487-3542",
    "address": "433 Mill Street, Heil, West Virginia, 5552",
    "about": "Esse sit velit elit commodo cillum non minim deserunt aute magna. Aliquip tempor occaecat pariatur id. Velit enim ad nisi commodo est quis culpa et ullamco sunt. Velit consectetur commodo ad velit eiusmod non anim reprehenderit nisi enim commodo excepteur. Ut duis elit incididunt do minim cillum. Exercitation fugiat sit sint irure id aliqua officia mollit anim ut culpa mollit occaecat amet.\r\n",
    "registered": "Saturday, January 18, 2014 4:44 AM",
    "latitude": 66.697887,
    "longitude": 54.070797,
    "tags": [
      "proident",
      "nulla",
      "tempor",
      "ad",
      "ea",
      "non",
      "labore"
    ],
    "range": [
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9
    ],
    "friends": [
      {
        "id": 0,
        "name": "Esperanza Lindsey"
      },
      {
        "id": 1,
        "name": "Roseann Chase"
      },
      {
        "id": 2,
        "name": "Sherrie Robertson"
      }
    ],
    "greeting": "Hello, Alexis! You have 9 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "54ebfff838e22c18d32bfaf8",
    "index": 2,
    "guid": "2ae013c0-2e42-42d5-a3f4-bd04bfc501bd",
    "isActive": false,
    "balance": "$3,714.30",
    "picture": "http://placehold.it/32x32",
    "age": 39,
    "eyeColor": "brown",
    "name": {
      "first": "Roman",
      "last": "Morgan"
    },
    "company": "PLASMOS",
    "email": "roman.morgan@plasmos.info",
    "phone": "+1 (915) 570-3082",
    "address": "201 Tapscott Avenue, Maplewood, Delaware, 5298",
    "about": "Duis amet magna officia nulla irure magna cillum velit. Do duis non laborum in esse pariatur officia sit non ad fugiat voluptate esse. Excepteur do culpa excepteur culpa enim occaecat culpa veniam minim dolor. Sunt qui esse proident mollit non incididunt reprehenderit.\r\n",
    "registered": "Thursday, July 24, 2014 4:32 AM",
    "latitude": -44.426416,
    "longitude": -23.69754,
    "tags": [
      "duis",
      "excepteur",
      "mollit",
      "fugiat",
      "cupidatat",
      "eiusmod",
      "ullamco"
    ],
    "range": [
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9
    ],
    "friends": [
      {
        "id": 0,
        "name": "Hinton Salas"
      },
      {
        "id": 1,
        "name": "Kristin Golden"
      },
      {
        "id": 2,
        "name": "Mendoza Howe"
      }
    ],
    "greeting": "Hello, Roman! You have 8 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "54ebfff832f794d893fb386f",
    "index": 3,
    "guid": "fa9c85f7-6a15-474e-b4b4-9832046501e0",
    "isActive": false,
    "balance": "$1,208.40",
    "picture": "http://placehold.it/32x32",
    "age": 34,
    "eyeColor": "blue",
    "name": {
      "first": "Horne",
      "last": "Walsh"
    },
    "company": "OPTICON",
    "email": "horne.walsh@opticon.biz",
    "phone": "+1 (904) 486-3338",
    "address": "604 Schroeders Avenue, Hasty, Louisiana, 5136",
    "about": "Irure aliqua aute esse sint do tempor. Sunt veniam pariatur laborum dolore sit in commodo officia aliqua laborum sunt. Nulla commodo quis officia qui deserunt aliqua ut veniam in aliquip quis. Deserunt fugiat non non officia eu ipsum non esse cillum Lorem reprehenderit officia magna voluptate. Nostrud deserunt elit magna labore ex culpa voluptate nostrud.\r\n",
    "registered": "Saturday, March 22, 2014 9:30 AM",
    "latitude": 4.735035,
    "longitude": -137.343773,
    "tags": [
      "eiusmod",
      "nulla",
      "proident",
      "nulla",
      "minim",
      "cillum",
      "anim"
    ],
    "range": [
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9
    ],
    "friends": [
      {
        "id": 0,
        "name": "Puckett Stark"
      },
      {
        "id": 1,
        "name": "Alyssa Sheppard"
      },
      {
        "id": 2,
        "name": "Adkins Murphy"
      }
    ],
    "greeting": "Hello, Horne! You have 8 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "54ebfff8e4a51ee62824ed7f",
    "index": 4,
    "guid": "92a488e6-d4dc-42a2-ba91-f808d194328d",
    "isActive": false,
    "balance": "$1,118.07",
    "picture": "http://placehold.it/32x32",
    "age": 20,
    "eyeColor": "green",
    "name": {
      "first": "Holland",
      "last": "Ewing"
    },
    "company": "GRONK",
    "email": "holland.ewing@gronk.org",
    "phone": "+1 (871) 435-2649",
    "address": "716 Macdougal Street, Crumpler, Connecticut, 6165",
    "about": "Amet elit et aute ut tempor nulla deserunt officia duis consectetur. Enim in ipsum laboris nostrud consequat tempor enim id et elit Lorem. Aliqua ex anim ipsum sint sint officia ullamco deserunt. Id exercitation velit deserunt ipsum.\r\n",
    "registered": "Thursday, February 20, 2014 12:27 PM",
    "latitude": -73.050501,
    "longitude": -69.445859,
    "tags": [
      "occaecat",
      "minim",
      "velit",
      "officia",
      "elit",
      "commodo",
      "irure"
    ],
    "range": [
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9
    ],
    "friends": [
      {
        "id": 0,
        "name": "Elsa Snider"
      },
      {
        "id": 1,
        "name": "Delores Price"
      },
      {
        "id": 2,
        "name": "Faulkner Vang"
      }
    ],
    "greeting": "Hello, Holland! You have 10 unread messages.",
    "favoriteFruit": "apple"
  }
]
""";

void main() {
  print(prettify(encode(parse(IN))));
}