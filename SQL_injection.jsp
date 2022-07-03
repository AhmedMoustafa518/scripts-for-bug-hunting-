private void unsubscribeUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  JSONObject json = new JSONObject();
  String email = request.getParameter("email");

  try {
    Connection db = DBHelper.getConnection();
    Statement stmt = db.createStatement();

    String sql = "SELECT email FROM user WHERE email = '" + email + "'";
    // SELECT email FROM user WHERE email = ''

    ResultSet results = stmt.executeQuery(sql);

    if (results.next()) {
      email = DbHelper.GetEmailColumn(results);
      DbHelper.UnsubscribeUser(email);
    }

    json.put("email", email);
    json.put("success", true);
  } catch (SQLException ex) {
    json.put("error", ex.getMessage());
    json.put("success", false);
  }

  response.setContentType("application/json");
  response.getWriter().println(json.toString());
}
