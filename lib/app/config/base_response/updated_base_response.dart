class UpdatedBaseResponse<T> {
  bool success;
  T? data;
  String? message;

  // Constructor for BaseResponse
  UpdatedBaseResponse({required this.success, this.data, this.message});

  // Static method to create a success response
  static UpdatedBaseResponse<T> fromSuccess<T>(T data) {
    return UpdatedBaseResponse<T>(
      success: true,
      data: data,
      message: null,
    );
  }

  // Static method to create an error response
  static UpdatedBaseResponse<T> fromError<T>(String message) {
    return UpdatedBaseResponse<T>(
      success: false,
      data: null,
      message: message,
    );
  }
}
