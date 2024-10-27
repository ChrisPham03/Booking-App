import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:booking_app/Providers/service_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TechnicianBoard extends StatefulWidget {
  @override
  _TechnicianBoardState createState() => _TechnicianBoardState();
}

class _TechnicianBoardState extends State<TechnicianBoard> {
  List<Technician> _selectedTechnician = [];
  Map<Technician, bool> _technicianSelection = {};
  TextEditingController _bookingNoteController = TextEditingController();
  bool isOverlayVisible = false; // Overlay visibility state
 final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final technicianProvider = Provider.of<TechnicianProvider>(context);

    return Stack(
      children: [
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Booking Note",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
        
                 TextField(
                    controller: _bookingNoteController,
                    decoration: InputDecoration(
                      hintText: "Add any notes about the booking here",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 16.0),
                  ...technicianProvider.technicians.map((technician) {
                    return GestureDetector(
                      onTap: () {
                        technicianProvider.toggleTechnicianSelection(technician);
                      },
                       onLongPress: () {
                                      _showServiceDetailsDialog(technician,['https://media.allure.com/photos/63976f46edbdb19d32ef2be1/16:9/w_2240,c_limit/Anneke%20Knot%20Hard%20Gel%20Manicure.png','https://envi.in/wp-content/uploads/2021/11/manicures-scaled-1.jpg']); // Show full service details on long press
                                    },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              GestureDetector(
                                    onTap: () {
                                      _showServiceDetailsDialog(technician,['https://media.allure.com/photos/63976f46edbdb19d32ef2be1/16:9/w_2240,c_limit/Anneke%20Knot%20Hard%20Gel%20Manicure.png','https://envi.in/wp-content/uploads/2021/11/manicures-scaled-1.jpg']); // Show full service details on long press
                                    },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundImage: AssetImage(technician.imageUrl), // Adjust based on your image source
                                    ),
                                    SizedBox(width: 12.0),
                                    Text(
                                      technician.name,
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  technicianProvider.toggleTechnicianSelection(technician);
                                },
                                child: Container(
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: technicianProvider.technicianSelection[technician] == true
                                        ? Colors.grey[200]
                                        : Colors.white,
                                    border: Border.all(color: Colors.black, width: 0.5),
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
          ),
        ),
        if (isOverlayVisible)
          GestureDetector(
            onTap: () {
              setState(() {
                isOverlayVisible = false;
              });
            },
            child: Container(
              color: Colors.black.withOpacity(0.3),
              width: double.infinity,
              height: double.infinity,
            ),
          )
      ],
    );
  }

  void _toggleOverlay() {
    setState(() {
      isOverlayVisible = !isOverlayVisible;
    });
  }
@override
  void dispose() {
    _bookingNoteController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  List<Technician> _temporarySelectedTechnician = [];

  void _toggleServiceSelection(Technician technician) {
    setState(() {
      if (_temporarySelectedTechnician.contains(technician)) {
        _temporarySelectedTechnician.remove(technician);
      } else {
        _temporarySelectedTechnician.add(technician);
      }

      _technicianSelection[technician] = _temporarySelectedTechnician.contains(technician);
    });
    print('Temporary selected services: $_temporarySelectedTechnician');
  }

void _showServiceDetailsDialog(Technician technician, List<String> imageUrls) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20, // Adjust the radius as needed
              backgroundImage: AssetImage(technician.imageUrl), // Assuming the technician has an avatar URL
            ),
            SizedBox(width: 10),
            Text(
              technician.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.5,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                if (imageUrls.isNotEmpty) ...[
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          imageUrls[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'No images available.',
                      style: TextStyle(fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

}
