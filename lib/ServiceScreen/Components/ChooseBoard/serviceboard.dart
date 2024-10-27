import 'package:flutter/material.dart';
import 'package:booking_app/Providers/service_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceBoard extends StatefulWidget {
  @override
  _ServiceBoardState createState() => _ServiceBoardState();
}

class _ServiceBoardState extends State<ServiceBoard>  with SingleTickerProviderStateMixin {
  bool _showCategories = true; // Show categories initially
  List<Service> _selectedServices = []; // List to hold selected services
  Map<Service, bool> _serviceSelection = {}; // Map to track service selection
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize the AnimationController
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Define the scale animation from 0 (invisible) to 1 (full size)
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    // Start the animation
    _animationController.forward();
  }

  @override
Widget build(BuildContext context) {
  // Access the ServiceProvider
  final serviceProvider = Provider.of<ServiceProvider>(context);

  return Stack(
    children: [
      Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white, // Set background color to white
              borderRadius: BorderRadius.circular(16.0), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Subtle shadow for depth
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // Changes the position of the shadow
                ),
              ],
            ),
            child: Column(
              children: [
                // Row containing category buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.start, // Align buttons to the left
                  children: [
                   ElevatedButton(
                      onPressed: () {
                        // Toggle category list visibility
                        setState(() {
                          _showCategories = !_showCategories;
                          _selectedServices = []; // Reset services when toggling categories
                          _serviceSelection.clear(); // Clear selection state
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  const Color.fromARGB(255, 55, 81, 109), // Set the button background color
                        foregroundColor: Colors.white, // Set the text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0), // Set the desired border radius
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0), // Optional: set padding
                      ),
                      child: Text(
                        'All Categories',
                        style: TextStyle(
                          fontSize: 6.5.sp, // Set the desired font size
                          color: Colors.white, // This color can be removed since it's already set in foregroundColor
                        ),
                      ),
                    ),

                    SizedBox(width: 8.0), // Spacer between buttons
                    ...serviceProvider.categories.map((category) {
                      return Padding( // Add padding around each button
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle button press for each category
                            print('Selected category: ${category.categoryName}');
                            _fetchServices(category); // Fetch services based on selected category
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:  const Color.fromARGB(255, 55, 81, 109), // Set the button background color
                            foregroundColor: Colors.white, // Set the text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0), // Set the desired border radius
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0), // Optional: set padding
                          ),
                          child: Text(category.categoryName,
                                    style: TextStyle(
                                    fontSize: 6.5.sp, // Set the desired font size
                                    color: Colors.white, // This color can be removed since it's already set in foregroundColor
                                  )
                                  ),       
                        ),
                      );
                    }).toList(),
                  ],
                ),
                SizedBox(height: 16.0), // Spacer between row and next child
                // Search bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by name',
                    hintStyle: TextStyle(fontSize: 6.sp), // Adjust hint text size here
                    prefixIcon: Icon(Icons.search), // Search icon
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  style: TextStyle(fontSize: 6.sp),
                ),
                SizedBox(height: 16.0), // Spacer
                // Display category list if toggled
                if (_showCategories)
                  Expanded(
                    child: SingleChildScrollView( // Enable scrolling
                      child: Column(
                        children: serviceProvider.categories.asMap().entries.map((entry) {
                          var category = entry.value; // Get the category

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              color: Colors.white, // Category container color
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category.categoryName,
                                    style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.bold, color: Colors.orange),
                                  ),
                                  // Display services in the selected category
                                  ...category.services.asMap().entries.map((serviceEntry) {
                                    int serviceIndex = serviceEntry.key; // Get the service index
                                    var service = serviceEntry.value; // Get the service

                                    // Alternating color for service containers
                                    Color containerColor = (serviceIndex % 2 == 0)
                                        ? Colors.white
                                        : (Colors.grey[200] ?? Colors.grey); // Fallback color

                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 4.0), // Left: 10, Top: 4, Right: 10, Bottom: 4
                                      child: GestureDetector(
                                        onTap: () {
                                          // Handle pick service action when the container is clicked
                                          _toggleServiceSelection(service);
                                          Provider.of<ServiceSelectionProvider>(context, listen: false).toggleServiceSelection(service);
                                        },
                                        onLongPress: () {
                                          _showServiceDetailsDialog(service, [
                                            'https://media.allure.com/photos/63976f46edbdb19d32ef2be1/16:9/w_2240,c_limit/Anneke%20Knot%20Hard%20Gel%20Manicure.png',
                                            'https://envi.in/wp-content/uploads/2021/11/manicures-scaled-1.jpg'
                                          ]); // Show full service details on long press
                                        },
                                        child: Container( // Add container for each service
                                          padding: EdgeInsets.all(16.0), // Add padding inside the container
                                          decoration: BoxDecoration(
                                            color: containerColor, // Apply the alternating color
                                            borderRadius: BorderRadius.circular(12.0), // Rounded corners
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 5, // Allocate 5 parts to name and description
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        _showServiceDetailsDialog(service, [
                                                          'https://media.allure.com/photos/63976f46edbdb19d32ef2be1/16:9/w_2240,c_limit/Anneke%20Knot%20Hard%20Gel%20Manicure.png',
                                                          'https://envi.in/wp-content/uploads/2021/11/manicures-scaled-1.jpg'
                                                        ]); // Show full service details on long press
                                                      },
                                                      child: Text(service.name, style: TextStyle(fontSize: 6.sp,color: const Color.fromARGB(255, 55, 81, 109),fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                                                    ),
                                                    Text(
                                                      service.description,
                                                      maxLines: 1, // Limit to one line
                                                      overflow: TextOverflow.ellipsis, // Show ellipsis if text is too long
                                                      style: TextStyle(
                                                        fontSize: 5.sp,
                                                        color:Color.fromRGBO(163, 163, 163, 0.8),
                                                        fontWeight: FontWeight.bold, 
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 30.0), // Spacer
                                              Expanded(
                                                flex: 1, // Allocate 1 part to price
                                                child: Text('\$${service.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 6.sp,color: const Color.fromARGB(255, 55, 81, 109),fontWeight: FontWeight.bold)),
                                              ),
                                              SizedBox(width: 8.0), // Spacer
                                              Expanded(
                                                flex: 1, // Allocate 1 part to duration
                                                child: Text('${service.duration} min', style: TextStyle(fontSize: 6.sp,color: const Color.fromARGB(255, 55, 81, 109),fontWeight: FontWeight.bold)),
                                              ),
                                              // Circle button to pick the service
                                              SizedBox(width: 8.0), // Spacer before the button
                                              GestureDetector(
                                                onTap: () {
                                                  // Handle pick service action
                                                  _toggleServiceSelection(service);
                                                  Provider.of<ServiceSelectionProvider>(context, listen: false).toggleServiceSelection(service);
                                                },
                                                child: Container(
                                                  width: 7.sp, // Adjusted width of the button
                                                  height: 7.sp, // Adjusted height of the button
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: _serviceSelection[service] == true 
                                                        ? const Color.fromARGB(255, 208, 208, 208) 
                                                        : const Color.fromARGB(255, 255, 255, 255), // Change color based on selection
                                                    border: Border.all(
                                                      color: Colors.black, // Black border color
                                                      width: 0.5, // Width of the border
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                // Display selected services
                if (_selectedServices.isNotEmpty)
                  Expanded(
                    child: Center( // Center the services
                      child: ListView.builder(
                        itemCount: _selectedServices.length,
                        itemBuilder: (context, index) {
                          Color containerColor = (index % 2 == 0)
                              ? Colors.white
                              : (Colors.grey[200] ?? Colors.grey); // Fallback color

                          final service = _selectedServices[index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 4.0),
                            child: GestureDetector(
                              onTap: () {
                                // Handle pick service action when the container is clicked
                                _toggleServiceSelection(service);
                                Provider.of<ServiceSelectionProvider>(context, listen: false).toggleServiceSelection(service);
                              },
                              onLongPress: () {
                                _showServiceDetailsDialog(service, [
                                  'https://media.allure.com/photos/63976f46edbdb19d32ef2be1/16:9/w_2240,c_limit/Anneke%20Knot%20Hard%20Gel%20Manicure.png',
                                  'https://envi.in/wp-content/uploads/2021/11/manicures-scaled-1.jpg'
                                ]); // Show full service details on long press
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: containerColor, // Alternate color
                                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                                ),
                                child: Row(
                                children: [
                                              Expanded(
                                                flex: 5, // Allocate 5 parts to name and description
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        _showServiceDetailsDialog(service, [
                                                          'https://media.allure.com/photos/63976f46edbdb19d32ef2be1/16:9/w_2240,c_limit/Anneke%20Knot%20Hard%20Gel%20Manicure.png',
                                                          'https://envi.in/wp-content/uploads/2021/11/manicures-scaled-1.jpg'
                                                        ]); // Show full service details on long press
                                                      },
                                                      child: Text(service.name, style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline,fontSize: 6.sp,color: const Color.fromARGB(255, 55, 81, 109))),
                                                    ),
                                                    Text(
                                                      service.description,
                                                      maxLines: 1, // Limit to one line
                                                      overflow: TextOverflow.ellipsis, // Show ellipsis if text is too long
                                                      style: TextStyle(
                                                        fontSize: 5.sp,
                                                        color:Color.fromRGBO(163, 163, 163, 0.8),
                                                        fontWeight: FontWeight.bold, 
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 30.0), // Spacer
                                              Expanded(
                                                flex: 1, // Allocate 1 part to price
                                                child: Text('\$${service.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 6.sp,color: const Color.fromARGB(255, 55, 81, 109),fontWeight: FontWeight.bold)),
                                              ),
                                              SizedBox(width: 8.0), // Spacer
                                              Expanded(
                                                flex: 1, // Allocate 1 part to duration
                                                child: Text('${service.duration} min', style: TextStyle(fontSize: 6.sp,color: const Color.fromARGB(255, 55, 81, 109),fontWeight: FontWeight.bold)),
                                              ),
                                              // Circle button to pick the service
                                              SizedBox(width: 8.0), // Spacer before the button
                                              GestureDetector(
                                                onTap: () {
                                                  // Handle pick service action
                                                  _toggleServiceSelection(service);
                                                  Provider.of<ServiceSelectionProvider>(context, listen: false).toggleServiceSelection(service);
                                                },
                                                child: Container(
                                                  width: 7.sp, // Adjusted width of the button
                                                  height: 7.sp, // Adjusted height of the button
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: _serviceSelection[service] == true 
                                                        ? const Color.fromARGB(255, 208, 208, 208) 
                                                        : const Color.fromARGB(255, 255, 255, 255), // Change color based on selection
                                                    border: Border.all(
                                                      color: Colors.black, // Black border color
                                                      width: 0.5, // Width of the border
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}


  void _fetchServices(ServiceCategory category) {
    setState(() {
      _selectedServices = category.services; // Get services from the selected category
      _showCategories = false; // Hide categories after selecting one
      _serviceSelection.clear(); // Clear selection state
    });
  }

List<Service> _temporarySelectedServices = []; // Temporary list for selected services

void _toggleServiceSelection(Service service) {
  // Toggle the selection state of the service
  setState(() {
    // Check if the service is already in the temporary selection list
    if (_temporarySelectedServices.contains(service)) {
      // If it exists, remove it from the temporary list
      _temporarySelectedServices.remove(service);
    } else {
      // If not, add it to the temporary list
      _temporarySelectedServices.add(service);
    }

    // Update the service selection map to reflect the temporary selection state
    _serviceSelection[service] = _temporarySelectedServices.contains(service);
  });

  // Print the temporary list of selected services
  print('Temporary selected services: $_temporarySelectedServices');
}

/*
  showDialog(
    context: context,
    barrierDismissible: true, // Allow tapping outside to close the dialog
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white, // Set the background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // Rounded corners
        ),
        title: Text(
          service.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20, // Title font size
          ),
        ),
        content: Text(
          service.description,
          style: TextStyle(fontSize: 16), // Description font size
        ), // Show full description
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue, // Text color for button
            ),
            child: Text("Close"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}*/
void _showServiceDetailsDialog(Service service, List<String> imageUrls) {
  showDialog(
    context: context,
    barrierDismissible: true, // Allow tapping outside to close the dialog
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white, // Set the background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // Rounded corners
        ),
        title: Text(
          service.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 7.sp, // Title font size
          ),
        ),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.6, // Set fixed width
          height: MediaQuery.of(context).size.height * 0.5, // Set fixed height
          child: SingleChildScrollView( // Make it scrollable if needed
            child: Column(
              mainAxisSize: MainAxisSize.min, // Shrink to fit content
              children: [
                Text(
                  service.description,
                  style: TextStyle(fontSize: 7.sp), // Description font size
                ),
                
                SizedBox(height: 10), // Add some space between the description and the images
                // Text(r
                //   'Images:', // Optional section title
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 18,
                //   ),
                // ),
                SizedBox(height: 10), // Add space before the images
                // Display images only if there are any
                if (imageUrls.isNotEmpty) ...[
                  GridView.builder(
                    shrinkWrap: true, // Prevent overflow
                    physics: NeverScrollableScrollPhysics(), // Disable scrolling
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of images in a row
                      crossAxisSpacing: 8.0, // Space between images horizontally
                      mainAxisSpacing: 8.0, // Space between images vertically
                    ),
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0), // Rounded corners for images
                        child: Image.network(
                          imageUrls[index],
                          fit: BoxFit.cover, // Cover the space in the grid cell
                        ),
                      );
                    },
                  ),
                ] else ...[
                  // Placeholder text when there are no images
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'No images available.',
                      style: TextStyle(fontStyle: FontStyle.italic), // Optional styling
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                
              ],
            ),
          ),
        ),
      );
    },
  );
 }
}
