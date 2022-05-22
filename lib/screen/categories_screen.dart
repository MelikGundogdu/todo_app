import 'package:flutter/material.dart';
import 'package:to_do_app_android/screen/home_screen.dart';
import '../models/category.dart';
import '../services/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  var category;
  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();
  var _editcategoryNameController = TextEditingController();
  var _editcategoryDescriptionController = TextEditingController();

  var _category = Category();
  var _categoryService = CategoryService();

  List<Category> _categoryList = List<Category>.empty(growable: true);
  @override
  void initState(){
    super.initState();
    getAllCategories();
  }

  getAllCategories() async{
    var categories = await _categoryService.readCategories();


      categories.foreach((category){
        setState((){
          var categoryModel = Category();
          categoryModel.name = category['name'];
          categoryModel.id = category['id'];
          categoryModel.description = category['description'];
          _categoryList.add(categoryModel);
        });
      });

  }

  _editCategory(BuildContext context, categoryId) async{

    category = await _categoryService.readCategoryById(categoryId);

    setState((){
      _editcategoryNameController.text = category[0]['name'] ?? 'No name';
      _editcategoryDescriptionController.text = category[0]['description'] ?? 'No description';
    });
    _editFormDialog(context);
  }

  _showFormDialog(BuildContext){
    return showDialog(context: context,
    barrierDismissible: true,
    builder: (param){
      return AlertDialog(
        actions: <Widget>[
          FlatButton(
              color: Colors.red,
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel")
          ),
          FlatButton(

              color: Colors.blue,
              onPressed: () async{
                _category.name = _categoryNameController.text;
                _category.description = _categoryDescriptionController.text;

                var result = await _categoryService.saveCategory(_category);
                // print(result);

                if(result > 0){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>
                  CategoriesScreen()), (Route<dynamic> route) => false);
                }
              },
              child: Text("save")
          )
        ],
        title: Text("Categories Form"),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
              decoration: InputDecoration(
                hintText: "Write a category",
                labelText: "Category"
            ),
          controller: _categoryNameController,
          ),
        TextField(
          decoration: InputDecoration(
            hintText: "Write a description",
            labelText: "Description"
          ),
          controller: _categoryDescriptionController,
        ),
        ],
          ),
        ),
      );
    });
  }

  _editFormDialog(BuildContext){
    return showDialog(context: context,
        barrierDismissible: true,
        builder: (param){
          return AlertDialog(
            actions: <Widget>[
              FlatButton(onPressed: () => Navigator.pop(context),
                  child: Text("Cancel")
              ),
              FlatButton(
                  color: Colors.blue,
                  onPressed: () async{
                    _category.id = category[0].id;
                    _category.name = _editcategoryNameController.text;
                    _category.description = _editcategoryDescriptionController.text;

                    var result = await _categoryService.updateCategory(_category);
                    // print(result);

                    if(result > 0){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>
                          CategoriesScreen()), (Route<dynamic> route) => false);
                    }
                  },
                  child: Text("save")
              )
            ],
            title: Text("Categories Form"),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Write a category",
                        labelText: "Category"
                    ),
                    controller: _categoryNameController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Write a description",
                        labelText: "Description"
                    ),
                    controller: _categoryDescriptionController,
                  ),
                ],
              ),
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: RaisedButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomeScreen())
          ),
          elevation: 0.0,
          child: Icon(Icons.arrow_back,color: Colors.white,),
        ),
        title: Text("Categories"),
      ),
      body: ListView.builder(
          itemCount:_categoryList.length ,
          itemBuilder: (context,index){
            return Padding(padding: EdgeInsets.only(top: 8.0,left: 16.0,right: 16.0),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  leading: IconButton(icon: Icon(Icons.edit),
                  onPressed: (){
                    _editCategory(context, _categoryList[index].id);
                  }),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_categoryList[index].name.toString()),
                      IconButton(onPressed: (){}, icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
