

// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirebaseHeper {
//   Future<void> getMarketsData() async {
//     try {
//       // Replace 'your_collection' with the name of your Firestore collection
//       QuerySnapshot collectionSnapshot =
//           await FirebaseFirestore.instance.collection('super_markets').get();

//       // Access the documents in the collection
//       List<QueryDocumentSnapshot> documents = collectionSnapshot.docs;

//       // Loop through the documents
//       for (var document in documents) {
//         // Access data from the document
//         var documentData = document.data() as Map<String, dynamic>;
//         var documentField = documentData['name'];

//         // Print or use the data as needed
//         print('Market name: $documentField');

//         // Access subcollection
//         CollectionReference subcollectionRef =
//             document.reference.collection('store_data');
//         QuerySnapshot subcollectionSnapshot = await subcollectionRef.get();

//         // Access documents in the subcollection
//         List<QueryDocumentSnapshot> subcollectionDocuments =
//             subcollectionSnapshot.docs;
//         for (var subcollectionDocument in subcollectionDocuments) {
//           var subcollectionData =
//               subcollectionDocument.data() as Map<String, dynamic>;
//           var subcollectionField = subcollectionData['category'];

//           // Print or use data from the subcollection
//           print('category: $subcollectionField');
//         }
//       }

//       print('Data retrieved successfully!');
//     } catch (error) {
//       print('Error fetching data: $error');
//     }
//   }
// }
