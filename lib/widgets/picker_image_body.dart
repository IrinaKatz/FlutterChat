import 'package:flutter/material.dart';
import 'package:my_first_project/repo/image_repository.dart';


class PickerImageBody extends StatelessWidget {

  final ImageRepository _imageRepo = ImageRepository();
  final Function(String) onImageSelected;

  PickerImageBody({super.key, required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))
      ),
      child: FutureBuilder<List<dynamic>>(                 // http data fetcher&image builder
          future: _imageRepo.getNetworkImages(),
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if(snapshot.hasData) {
              return GridView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        onImageSelected(snapshot.data![index].previewURL);
                      },
                        child: Image.network(snapshot.data![index].previewURL));
                  },
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    maxCrossAxisExtent: MediaQuery.of(context).size.width*0.5
                  ),
                  itemCount: snapshot.data!.length);

            } else if (snapshot.hasError){
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text('This is the error: ${snapshot.error}'),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
