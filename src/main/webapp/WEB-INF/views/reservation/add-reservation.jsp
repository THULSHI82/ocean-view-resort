<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.oceanviewresort.reservation.model.Room" %>

<%
  List<Room> rooms = (List<Room>) request.getAttribute("rooms");
%>

<h3>Add Reservation</h3>
<p style="color:#64748b;margin-top:6px;">Fill the form to create a new reservation.</p>

<% if (request.getAttribute("error") != null) { %>
<div style="padding:10px;border-radius:10px;background:#fee2e2;color:#991b1b;margin:14px 0;">
  <%= request.getAttribute("error") %>
</div>
<% } %>

<% if (request.getAttribute("success") != null) { %>
<div style="padding:10px;border-radius:10px;background:#d1fae5;color:#065f46;margin:14px 0;">
  <%= request.getAttribute("success") %>
</div>
<% } %>

<form method="post" action="${pageContext.request.contextPath}/reservation" style="margin-top:14px;display:grid;gap:14px;max-width:700px;">
  <div>
    <label style="display:block;font-size:12px;color:#64748b;margin-bottom:6px;">Customer Name</label>
    <input type="text" name="customerName" placeholder="e.g., John Perera" required
           style="width:100%;padding:12px;border-radius:12px;border:1px solid #e5e7eb;">
  </div>

  <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;">
    <div>
      <label style="display:block;font-size:12px;color:#64748b;margin-bottom:6px;">Phone</label>
      <input type="text" name="customerPhone" placeholder="e.g., 0771234567"
             style="width:100%;padding:12px;border-radius:12px;border:1px solid #e5e7eb;">
    </div>
    <div>
      <label style="display:block;font-size:12px;color:#64748b;margin-bottom:6px;">Email</label>
      <input type="email" name="customerEmail" placeholder="e.g., john@email.com"
             style="width:100%;padding:12px;border-radius:12px;border:1px solid #e5e7eb;">
    </div>
  </div>

  <div>
    <label style="display:block;font-size:12px;color:#64748b;margin-bottom:6px;">Select Room</label>
    <select name="roomId" required style="width:100%;padding:12px;border-radius:12px;border:1px solid #e5e7eb;">
      <option value="">-- Select a Room --</option>
      <% if (rooms != null) {
        for (Room r : rooms) { %>
      <option value="<%= r.getId() %>">
        Room <%= r.getRoomNumber() %> | <%= r.getRoomType() %> | LKR <%= r.getPrice() %>
      </option>
      <% } } %>
    </select>
  </div>

  <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;">
    <div>
      <label style="display:block;font-size:12px;color:#64748b;margin-bottom:6px;">Check-in</label>
      <input type="date" name="checkIn" required
             style="width:100%;padding:12px;border-radius:12px;border:1px solid #e5e7eb;">
    </div>
    <div>
      <label style="display:block;font-size:12px;color:#64748b;margin-bottom:6px;">Check-out</label>
      <input type="date" name="checkOut" required
             style="width:100%;padding:12px;border-radius:12px;border:1px solid #e5e7eb;">
    </div>
  </div>

  <button type="submit"
          style="padding:12px;border:none;border-radius:12px;background:#111827;color:#fff;font-weight:700;cursor:pointer;width:220px;">
    Create Reservation
  </button>
</form>