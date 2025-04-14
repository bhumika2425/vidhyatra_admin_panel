class ApiEndpoints{
  static const baseUrl = 'http://192.168.100.245:3001';
  static const login = '${baseUrl}/api/adminLoginRoutes/admin/login';

  //events
  static const postEvents = "${baseUrl}/api/eventCalender/postEvents";
  static const getEvents = "${baseUrl}/api/eventCalender/getEvents";

  // get professors
  static const getProfessors= "${baseUrl}/api/auth/teachers";

  // get students
  static const getStudents= "${baseUrl}/api/auth/students";

}