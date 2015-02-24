import "package:lson/lson.dart";

const String IN = r"""
[
  {
    "_id": "54ebfb2281971be98c3b08c6",
    "index": 0,
    "guid": "da62a35f-b4bd-44fa-82bb-2abbc727144b",
    "isActive": true,
    "balance": "3,578.04",
    "picture": "http://placehold.it/32x32",
    "age": 40,
    "eyeColor": "green",
    "name": {
      "first": "Booth",
      "last": "Christensen"
    },
    "company": "DYNO",
    "email": "booth.christensen@dyno.me",
    "registered": "Monday, December 1, 2014 11:58 PM",
    "latitude": 26.973394,
    "longitude": 102.651443,
    "tags": [
      "fugiat",
      "labore",
      "laboris",
      "reprehenderit",
      "mollit",
      "cillum",
      "ipsum"
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
        "name": "Ratliff Mccullough"
      },
      {
        "id": 1,
        "name": "Greta Merrill"
      },
      {
        "id": 2,
        "name": "Rosario Estes"
      }
    ],
    "greeting": "Hello, Booth! You have 10 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "54ebfb22c49cbfa82c879a88",
    "index": 1,
    "guid": "04c6dd29-6af1-4fdd-8daf-834f253e8a40",
    "isActive": false,
    "balance": "3,851.46",
    "picture": "http://placehold.it/32x32",
    "age": 39,
    "eyeColor": "brown",
    "name": {
      "first": "Estela",
      "last": "Sweeney"
    },
    "company": "NETILITY",
    "email": "estela.sweeney@netility.ca",
    "registered": "Sunday, November 2, 2014 12:37 PM",
    "latitude": 56.942484,
    "longitude": -89.80034,
    "tags": [
      "duis",
      "pariatur",
      "officia",
      "culpa",
      "mollit",
      "Lorem",
      "voluptate"
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
        "name": "Mcguire Watson"
      },
      {
        "id": 1,
        "name": "Jaime Garcia"
      },
      {
        "id": 2,
        "name": "Pennington Wilcox"
      }
    ],
    "greeting": "Hello, Estela! You have 10 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "54ebfb22b33e28a6336684e5",
    "index": 2,
    "guid": "f44ece5d-bc19-483a-89a7-96b45317cffa",
    "isActive": true,
    "balance": "1,157.65",
    "picture": "http://placehold.it/32x32",
    "age": 22,
    "eyeColor": "green",
    "name": {
      "first": "Mccullough",
      "last": "Hull"
    },
    "company": "AMTAP",
    "email": "mccullough.hull@amtap.tv",
    "registered": "Tuesday, August 12, 2014 4:38 AM",
    "latitude": -84.876217,
    "longitude": 9.946012,
    "tags": [
      "culpa",
      "aliqua",
      "laborum",
      "consequat",
      "aute",
      "magna",
      "consequat"
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
        "name": "Warren Rodriquez"
      },
      {
        "id": 1,
        "name": "Rose Barry"
      },
      {
        "id": 2,
        "name": "Maldonado Warren"
      }
    ],
    "greeting": "Hello, Mccullough! You have 5 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "54ebfb22ee84acb896a6bb81",
    "index": 3,
    "guid": "7f362a2c-64ac-43b4-8890-74aeeb5eb99c",
    "isActive": false,
    "balance": "2,791.18",
    "picture": "http://placehold.it/32x32",
    "age": 31,
    "eyeColor": "brown",
    "name": {
      "first": "Travis",
      "last": "Delgado"
    },
    "company": "ZOUNDS",
    "email": "travis.delgado@zounds.name",
    "registered": "Wednesday, December 10, 2014 5:25 AM",
    "latitude": -29.838184,
    "longitude": -25.273412,
    "tags": [
      "aliquip",
      "laboris",
      "deserunt",
      "Lorem",
      "officia",
      "sit",
      "consequat"
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
        "name": "Garcia Rodriguez"
      },
      {
        "id": 1,
        "name": "Aileen Cannon"
      },
      {
        "id": 2,
        "name": "Merrill Ellis"
      }
    ],
    "greeting": "Hello, Travis! You have 8 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "54ebfb22a5727f6e12096dd5",
    "index": 4,
    "guid": "91f1bcc5-e226-4ee4-a8ac-6eb5e06b6167",
    "isActive": false,
    "balance": "3,081.03",
    "picture": "http://placehold.it/32x32",
    "age": 20,
    "eyeColor": "blue",
    "name": {
      "first": "Winters",
      "last": "Carver"
    },
    "company": "FIBRODYNE",
    "email": "winters.carver@fibrodyne.org",
    "registered": "Saturday, March 1, 2014 10:02 PM",
    "latitude": -82.952557,
    "longitude": -15.74577,
    "tags": [
      "ut",
      "proident",
      "excepteur",
      "sit",
      "ex",
      "officia",
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
        "name": "Santiago Puckett"
      },
      {
        "id": 1,
        "name": "Leola Buckner"
      },
      {
        "id": 2,
        "name": "Miles Walsh"
      }
    ],
    "greeting": "Hello, Winters! You have 8 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "54ebfb2271c8bf7a7e19d92f",
    "index": 5,
    "guid": "808aff1f-651a-4b89-b988-0257fe849f0c",
    "isActive": true,
    "balance": "2,734.29",
    "picture": "http://placehold.it/32x32",
    "age": 39,
    "eyeColor": "green",
    "name": {
      "first": "Hamilton",
      "last": "Coleman"
    },
    "company": "BUZZMAKER",
    "email": "hamilton.coleman@buzzmaker.com",
    "registered": "Thursday, July 3, 2014 12:38 PM",
    "latitude": -1.50744,
    "longitude": -173.176211,
    "tags": [
      "do",
      "duis",
      "eu",
      "magna",
      "in",
      "ipsum",
      "voluptate"
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
        "name": "Kaye Sellers"
      },
      {
        "id": 1,
        "name": "Valeria Rich"
      },
      {
        "id": 2,
        "name": "Nolan Hale"
      }
    ],
    "greeting": "Hello, Hamilton! You have 10 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "54ebfb22e9f843d95e715cf1",
    "index": 6,
    "guid": "353dd89c-07ad-43c4-96fe-cb13f8b5c451",
    "isActive": true,
    "balance": "1,058.70",
    "picture": "http://placehold.it/32x32",
    "age": 37,
    "eyeColor": "blue",
    "name": {
      "first": "Callahan",
      "last": "Ware"
    },
    "company": "PEARLESSA",
    "email": "callahan.ware@pearlessa.biz",
    "registered": "Sunday, November 23, 2014 8:41 AM",
    "latitude": 6.671073,
    "longitude": 177.229802,
    "tags": [
      "aliqua",
      "nostrud",
      "est",
      "sit",
      "irure",
      "sit",
      "velit"
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
        "name": "Karyn Wheeler"
      },
      {
        "id": 1,
        "name": "Celina Ruiz"
      },
      {
        "id": 2,
        "name": "Shauna Bradford"
      }
    ],
    "greeting": "Hello, Callahan! You have 10 unread messages.",
    "favoriteFruit": "banana"
  }
]
""";

void main() {
  print(prettify(encode(parse(IN))));
}