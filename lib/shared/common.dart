 class CommonMethod{

   static Map<String, String>  createHeader(String jwt) {
     Map<String, String> headers = {
       'Content-Type': 'application/json',
       'Accept': 'application/json',
       'Authorization': 'Bearer ' + jwt,
     };
     return headers;
   }

}