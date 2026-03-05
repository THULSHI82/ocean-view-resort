<%@ page contentType="text/html;charset=UTF-8" %>

<h3>Generate Bill</h3>

<form method="get" action="${pageContext.request.contextPath}/billing">

  <label>Reservation ID</label>
  <input type="number" name="reservationId" required>

  <button type="submit">Generate Bill</button>

</form>

<%
  com.oceanviewresort.billing.model.Billing bill =
          (com.oceanviewresort.billing.model.Billing) request.getAttribute("bill");

  if (bill != null) {
%>

<hr>

<h3>Bill Details</h3>

<p>Customer: <%= bill.getCustomerName() %></p>
<p>Room: <%= bill.getRoomNumber() %></p>
<p>Nights: <%= bill.getNights() %></p>
<p>Price per night: LKR <%= bill.getPricePerNight() %></p>

<h2>Total: LKR <%= bill.getTotalAmount() %></h2>

<button onclick="window.print()">Print Bill</button>

<% } %>