import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:trishaheed/model/blog.dart';
import 'package:trishaheed/repository/blog_repo.dart';
import 'package:trishaheed/services/BaseApi.dart';
import 'package:trishaheed/utilities/Error.dart';
import 'package:trishaheed/utilities/api_routes.dart';
import 'blog_repo_test.mocks.dart';

@GenerateNiceMocks([MockSpec<BaseApi>()])
void main() {
  final jsonString = {
    "current_page": 1,
    "data": [
      {
        "post_id": 5,
        "user_id": 1,
        "title": "Constructors and Destructors in CPP",
        "body":
            "[{\"insert\":\"Constructors \",\"attributes\":{\"bold\":true}},{\"insert\":\" are called while creating objects of a class in object oriented programming. Constructors actually assign values to the properties of the class and make them concrete objects from mere template. In CPP, Constructors have same name as class name, they are also called special function as their name is same as class and doesn't return other value. Below is the syntax of a constructor in CPP.\\n\u003Cclass-name\u003E (parameters_list){\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"//initialization code\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"}\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"After looking at the syntax let's analyze the \"},{\"insert\":\"characteristics of constructors in CPP\",\"attributes\":{\"background\":\"#FFFFFFFF\",\"color\":\"#FFE57373\"}},{\"insert\":\".\",\"attributes\":{\"background\":\"#FFFFFFFF\"}},{\"insert\":\"\\nThe name of the constructor is the same as its class name.\"},{\"insert\":\"\\n\",\"attributes\":{\"list\":\"ordered\"}},{\"insert\":\"Constructors are mostly declared in the public section of the class though they can be declared in the private section of the class.\"},{\"insert\":\"\\n\",\"attributes\":{\"list\":\"ordered\"}},{\"insert\":\"Constructors do not return values; hence they do not have a return type.\"},{\"insert\":\"\\n\",\"attributes\":{\"list\":\"ordered\"}},{\"insert\":\"A constructor gets called automatically when we create the object of the class.\"},{\"insert\":\"\\n\",\"attributes\":{\"list\":\"ordered\"}},{\"insert\":\"\\n\"},{\"insert\":\"Types of Constructors\",\"attributes\":{\"bold\":true}},{\"insert\":\"\\n\"},{\"insert\":\"Default Constructors\",\"attributes\":{\"bold\":true}},{\"insert\":\"\\n\",\"attributes\":{\"list\":\"ordered\"}},{\"insert\":\"Parameterized Constructors\",\"attributes\":{\"bold\":true}},{\"insert\":\"\\n\",\"attributes\":{\"list\":\"ordered\"}},{\"insert\":\"Copy Constructors\",\"attributes\":{\"bold\":true}},{\"insert\":\"\\n\",\"attributes\":{\"list\":\"ordered\"}},{\"insert\":\"\\n\"},{\"insert\":\"Default Constructor\",\"attributes\":{\"bold\":true}},{\"insert\":\"\\nA default constructor is a constructor that doesn’t take any argument. It has no parameters. It is also called a zero-argument constructor.If we do not define any constructor for a class, compiler automatically creates a default constructor.\\n\"},{\"insert\":\"Syntax of Default Constructor\",\"attributes\":{\"bold\":true}},{\"insert\":\"\\nclassName() {\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    // body_of_constructor\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"}\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"Example of Default Constructor:\",\"attributes\":{\"bold\":true}},{\"insert\":\"\\nclass Student {\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"public:\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    string name;\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    int age;\"},{\"insert\":\"\\n\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    // Default Constructor\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    Student() {\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"        name = \\\"Unknown\\\";\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"        age = 0;\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"        cout \u003C\u003C \\\"Default Constructor called: \\\" \u003C\u003C name \u003C\u003C \\\" (\\\" \u003C\u003C age \u003C\u003C \\\")\\\" \u003C\u003C endl;\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    }\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"};\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"int main() {\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    Student s1;  // Default constructor will be called here\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    return 0;\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"}\"},{\"insert\":\"\\n\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"Parameterized Constructor\",\"attributes\":{\"bold\":true}},{\"insert\":\"\\nIt is a type of  constructor that takes parameters to initialize the object with specific values. To create a parameterized constructor, simply add parameters to it the way you would to any other function. When you define the constructor’s body, use the parameters to initialize the object.\\n\"},{\"insert\":\"Syntax of Parameterized Constructor\",\"attributes\":{\"bold\":true}},{\"insert\":\"\\nclassName (parameters...) {\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"      // body\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"}\"},{\"insert\":\"\\n\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"Example of Parameterized Constructor:\",\"attributes\":{\"bold\":true}},{\"insert\":\"\\n\\n#include \u003Ciostream\u003E\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"using namespace std;\"},{\"insert\":\"\\n\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"class Student {\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"public:\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    string name;\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    int age;\"},{\"insert\":\"\\n\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    // Parameterized Constructor\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    Student(string studentName, int studentAge) {\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"        name = studentName;\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"        age = studentAge;\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"        cout \u003C\u003C \\\"Parameterized Constructor called: \\\" \u003C\u003C name \u003C\u003C \\\" (\\\" \u003C\u003C age \u003C\u003C \\\")\\\" \u003C\u003C endl;\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    }\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"};\"},{\"insert\":\"\\n\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"int main() {\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    Student s2(\\\"Alice\\\", 20);  // Parameterized constructor will be called here\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    return 0;\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"}\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"\\n\"},{\"insert\":\"Copy Constructor\",\"attributes\":{\"bold\":true}},{\"insert\":\"\\nA copy constructor is a member function that initializes an object using another object of the same class.Just like the default constructor, the C++ compiler also provides an implicit copy constructor if the explicit copy constructor definition is not present.\\nClassName (ClassName &obj)\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"{\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"  // body_containing_logic\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"}\",\"attributes\":{\"bold\":true}},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"Example of Copy Constructor:\",\"attributes\":{\"bold\":true}},{\"insert\":\"\\n\\n#include \u003Ciostream\u003E\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"using namespace std;\"},{\"insert\":\"\\n\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"class Student {\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"public:\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    string name;\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    int age;\"},{\"insert\":\"\\n\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    // Parameterized Constructor\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    Student(string studentName, int studentAge) {\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"        name = studentName;\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"        age = studentAge;\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    }\"},{\"insert\":\"\\n\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    // Copy Constructor\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    Student(const Student &studentObj) {\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"        name = studentObj.name;\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"        age = studentObj.age;\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"        cout \u003C\u003C \\\"Copy Constructor called: \\\" \u003C\u003C name \u003C\u003C \\\" (\\\" \u003C\u003C age \u003C\u003C \\\")\\\" \u003C\u003C endl;\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    }\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"};\"},{\"insert\":\"\\n\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"int main() {\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    Student s3(\\\"Bob\\\", 22);     // Parameterized constructor will be called here\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    Student s4 = s3;           // Copy constructor will be called here\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    return 0;\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"}\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"Destructors in CPP\",\"attributes\":{\"bold\":true}},{\"insert\":\"\\nDestructor is an instance member function that is invoked automatically whenever an object is going to be destroyed which means a destructor is the last function that is going to be called before an object is destroyed.\\n\"},{\"insert\":\"Syntax for destructor\",\"attributes\":{\"bold\":true}},{\"insert\":\"\\n\\n~ \u003Cclass-name\u003E() {\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    // some instructions\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"}\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"We can destructor in our above student class as below to free up the memory take dynamically. (Example)\\n // Destructor\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    ~Student() {\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"        delete[] name;  // Free dynamically allocated memory for name\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"        cout \u003C\u003C \\\"Destructor called: \\\" \u003C\u003C name \u003C\u003C \\\" (\\\" \u003C\u003C age \u003C\u003C \\\")\\\" \u003C\u003C endl;\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"    }\"},{\"insert\":\"\\n\",\"attributes\":{\"code-block\":true}},{\"insert\":\"\\nYou can define this destructor at the end of the class. It will be called automatically we do not need to explicitly call it from the main method.\\nBelow are some characteristics of destructors:\\nA destructor is also a special member function like a constructor. Destructor destroys the class objects created by the constructor. \"},{\"insert\":\"\\n\",\"attributes\":{\"list\":\"ordered\"}},{\"insert\":\"Destructor has the same name as their class name preceded by a tilde (~) symbol.\"},{\"insert\":\"\\n\",\"attributes\":{\"list\":\"ordered\"}},{\"insert\":\"It is not possible to define more than one destructor.\"},{\"insert\":\"\\n\",\"attributes\":{\"list\":\"ordered\"}},{\"insert\":\"The destructor is only one way to destroy the object created by the constructor. Hence, destructor cannot be overloaded.\"},{\"insert\":\"\\n\",\"attributes\":{\"list\":\"ordered\"}},{\"insert\":\"In conclusion, Constructors are called to while creating an object of a class while destructor are called implicitly at the end of the program execution to free up the memory used by the program. There are differnt types of constructors with various use cases and we can use them as we need it.\"},{\"insert\":\"\\n\",\"attributes\":{\"blockquote\":true}},{\"insert\":\"\\n\\n\"}]",
        "slugs": [
          {"id": "2", "name": "Technology"},
          {"id": "6", "name": "Learning"}
        ],
        "cover_image":
            "http://api.trishaheed.edu.np/public/storage/posts/kI1SWKdSpIABYzmjwXqEjeatYjVWIyME6opAJxcZ.png",
        "updated_at": "2024-10-25T03:45:33.000000Z"
      }
    ],
    "first_page_url": "https://api.trishaheed.edu.np/api/posts?page=1",
    "from": 1,
    "last_page": 1,
    "last_page_url": "https://api.trishaheed.edu.np/api/posts?page=1",
    "links": [
      {"url": null, "label": "&laquo; Previous", "active": false},
      {
        "url": "https://api.trishaheed.edu.np/api/posts?page=1",
        "label": "1",
        "active": true
      },
      {"url": null, "label": "Next &raquo;", "active": false}
    ],
    "next_page_url": null,
    "path": "https://api.trishaheed.edu.np/api/posts",
    "per_page": 3,
    "prev_page_url": null,
    "to": 1,
    "total": 1
  };
  late MockBaseApi mockBaseApi;
  late BlogApi blogApiService;
  setUp(() {
    mockBaseApi = MockBaseApi();
    blogApiService = BlogApi(mockBaseApi);
  });

  test(
    "returns blogs  response on success",
    () async {
      //arrange
      when(mockBaseApi.get(ApiRoutes.posts, {'page': 1})).thenAnswer(
        (_) async => Left(
          Response(
            data: jsonString,
            requestOptions: RequestOptions(path: ApiRoutes.posts),
          ),
        ),
      );
      //act
      final result = await blogApiService.getBlogList();
      //assert
      expect(result, equals(isInstanceOf<BlogWrapper>()));
    },
  );
  test(
    "returns error message on failure",
    () async {
      //arrangement
      when(mockBaseApi.get(ApiRoutes.posts, {'page': 1})).thenAnswer(
        (_) async => Right(
          Failure("Failure Response(An Exception Occured)", FailureType.LOCAL, 404),
        ),
      );
      //act
      final result = await blogApiService.getBlogList();
      //assert
      expect(
        result,
        null,
      );
    },
  );
}
