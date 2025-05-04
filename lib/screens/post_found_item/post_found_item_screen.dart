import 'package:flutter/material.dart';
import 'package:lost_and_found_mobile/providers/create_post_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      if (!context.mounted) return;
      context.read<CreatePostProvider>().addPhoto(pickedFile.path);
    }
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Select Image Source'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(context, ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CreatePostProvider>(context);

    const Color primaryColor = Color(0xFF4F5BD5);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Create Post', style: TextStyle(color: Colors.white)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Category
            Consumer<CreatePostProvider>(
              builder: (context, provider, child) {
                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: 'Select item category',
                    prefixIcon: const Icon(Icons.category_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                  ),
                  value:
                      provider.itemCategory.isEmpty
                          ? null
                          : provider.itemCategory,
                  items:
                      provider.availableCategories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      provider.setItemCategory(newValue);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                );
              },
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
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
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
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
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
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
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
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
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
            // Photo Upload Grid
            Consumer<CreatePostProvider>(
              builder: (context, provider, child) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.photos.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    if (index == provider.photos.length) {
                      // Add photo button
                      return GestureDetector(
                        onTap: () => _showImageSourceDialog(context),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              size: 32,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }
                    // Display selected photo
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(provider.photos[index]),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () => provider.removePhoto(index),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
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
                onPressed:
                    provider.isSubmitting
                        ? null
                        : () async {
                          try {
                            await provider.submitPost();
                            if (!context.mounted) return;
                            // Show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Post created successfully!'),
                              ),
                            );
                            Navigator.pop(context);
                          } catch (e) {
                            if (!context.mounted) return;
                            // Show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to create post: $e'),
                              ),
                            );
                          }
                        },
                child:
                    provider.isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
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
