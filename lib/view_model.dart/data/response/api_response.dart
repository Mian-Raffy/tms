// import 'package:todo_app/data/response/status.dart';

// class ApiResponse<T> {
//   Status? status;
//   T? data;
//   String? message;

//   ApiResponse(this.status, this.data, this.message);

//   ApiResponse.loading()
//       : status = Status.Loading,
//         data = null,
//         message = null;

//   ApiResponse.completed(this.data)
//       : status = Status.Completed,
//         message = null;

//   ApiResponse.error(this.message)
//       : status = Status.Error,
//         data = null;

//   @override
//   String toString() {
//     return 'Status: $status \nMessage: $message \nData: $data';
//   }
// }
