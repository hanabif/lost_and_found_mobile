// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../widgets/input_field.dart';
// import '../../providers/create_post_provider.dart';



// class CreatePostScreen extends StatefulWidget {
// static const routeName = '/create-post';

//   const CreatePostScreen({Key? key}) : super(key: key);

//   @override
//   _CreatePostScreenState createState() => _CreatePostScreenState();
// }

// class _CreatePostScreenState extends State<CreatePostScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _categoryController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _detailsController = TextEditingController();
//   final TextEditingController _marksController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => CreatePostProvider(),
//       child: Consumer<CreatePostProvider>(
//         builder: (context, provider, _) => Scaffold(
//           appBar: AppBar(title: const Text('Create Post')),
//           body: SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   InputField(
//                     controller: _categoryController,
//                     hintText: 'Item category',
//                     prefixIcon: Icons.category,
//                   ),
//                   const SizedBox(height: 12),
//                   InputField(
//                     controller: _locationController,
//                     hintText: 'Enter your location',
//                     prefixIcon: Icons.location_on,
//                   ),
//                   const SizedBox(height: 12),
//                   InputField(
//                     controller: _nameController,
//                     hintText: 'Item name',
//                     prefixIcon: Icons.label,
//                   ),
//                   const SizedBox(height: 12),
//                   TextFormField(
//                     controller: _detailsController,
//                     maxLines: 3,
//                     maxLength: 200,
//                     decoration: InputDecoration(
//                       hintText: 'Item Details (200 chars max)',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   InputField(
//                     controller: _marksController,
//                     hintText: 'Special Marks (optional)',
//                     prefixIcon: Icons.star_border,
//                   ),
//                   const SizedBox(height: 20),
//                   const Text('Upload photos', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//                   const SizedBox(height: 8),
//                   // Grid of 6 photo pickers
//                   GridView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       mainAxisSpacing: 8,
//                       crossAxisSpacing: 8,
//                       childAspectRatio: 1,
//                     ),
//                     itemCount: provider.images.length,
//                     itemBuilder: (context, i) {
//                       final file = provider.images[i];
//                       return GestureDetector(
//                         onTap: () => provider.pickImage(i),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: Colors.grey.shade200,
//                           ),
//                           child: file == null
//                               ? const Icon(Icons.add_a_photo, size: 30, color: Colors.grey)
//                               : Stack(
//                                   fit: StackFit.expand,
//                                   children: [
//                                     Image.file(File(file.path), fit: BoxFit.cover),
//                                     Positioned(
//                                       top: 4,
//                                       right: 4,
//                                       child: GestureDetector(
//                                         onTap: () => provider.removeImage(i),
//                                         child: const Icon(Icons.cancel, color: Colors.redAccent),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                         ),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 24),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: provider.isSubmitting
//                           ? null
//                           : () {
//                               if (_formKey.currentState!.validate()) {
//                                 provider.submitPost(
//                                   category: _categoryController.text,
//                                   location: _locationController.text,
//                                   name: _nameController.text,
//                                   details: _detailsController.text,
//                                   specialMarks: _marksController.text,
//                                 );
//                               }
//                             },
//                       child: provider.isSubmitting
//                           ? const SizedBox(
//                               height: 20,
//                               width: 20,
//                               child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
//                             )
//                           : const Text('Post now'),
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:lost_and_found_mobile/providers/create_post_provider.dart';
import 'package:provider/provider.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final provider = Provider.of<CreatePostProvider>(context);
    // Define the color used for the header and button
    const Color primaryColor = Color(0xFF4F5BD5);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Create Post',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Category
            TextField(
              decoration: InputDecoration(
                hintText: 'Item category',
                prefixIcon: const Icon(Icons.category_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              ),
              onChanged: provider.setItemCategory,
            ),
            const SizedBox(height: 16),
            // Location
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your location',
                prefixIcon: const Icon(Icons.location_on_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              ),
              onChanged: provider.setLocation,
            ),
            const SizedBox(height: 16),
            // Item Name
            TextField(
              decoration: InputDecoration(
                hintText: 'Item name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              ),
              onChanged: provider.setItemName,
            ),
            const SizedBox(height: 16),
            // Item Details
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Item Details (100 characters)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              ),
              onChanged: provider.setItemDetails,
            ),
            const SizedBox(height: 16),
            // Special Mark
            TextField(
              decoration: InputDecoration(
                hintText: 'Special Mark (optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              ),
              onChanged: provider.setSpecialMark,
            ),
            const SizedBox(height: 24),
            // Upload Photos Label
            const Text(
              'Upload photos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            // Photo Upload Grid (2 rows x 3 columns)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(Icons.add, size: 32, color: Colors.grey),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            // Post Now Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  try {
                    await provider.submitPost();
                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Post created successfully!')),
                    );
                  } catch (e) {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to create post: $e')),
                    );
                  }
                },
                child: const Text(
                  'Post now',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

