<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.oceanviewresort.reservation.model.Room" %>

<%
  List<Room> rooms = (List<Room>) request.getAttribute("rooms");
%>

<h3>Add Reservation</h3>
<p style="color:#64748b;margin-top:6px;">Fill the form to create a new reservation.</p>

<style>
  .flash{
    padding:10px;
    border-radius:10px;
    margin:14px 0;
    font-size:13px;
    transition: opacity .6s ease, transform .6s ease;
  }
  .flash.success{
    background:#d1fae5;
    color:#065f46;
  }
  .flash.error{
    background:#fee2e2;
    color:#991b1b;
  }
  .flash.hide{
    opacity:0;
    transform: translateY(-6px);
  }
</style>

<% if (request.getAttribute("error") != null) { %>
<div id="flashMsg" class="flash error">
  <%= request.getAttribute("error") %>
</div>
<% } %>

<% if (request.getAttribute("success") != null) { %>
<div id="flashMsg" class="flash success">
  <%= request.getAttribute("success") %>
</div>
<% } %>

<form method="post" action="${pageContext.request.contextPath}/reservation" style="margin-top:14px;display:grid;gap:14px;max-width:700px;">
  <div>
    <label style="display:block;font-size:12px;color:#64748b;margin-bottom:6px;">Customer Name</label>
    <label>
      <input type="text" name="customerName" placeholder="e.g., Customer Name" required
             style="width:100%;padding:12px;border-radius:12px;border:1px solid #e5e7eb;">
    </label>
  </div>

  <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;">
    <div>
      <label style="display:block;font-size:12px;color:#64748b;margin-bottom:6px;">Phone</label>
      <label>
        <input type="text" name="customerPhone" placeholder="e.g., 0771234567"
               style="width:100%;padding:12px;border-radius:12px;border:1px solid #e5e7eb;">
      </label>
    </div>
    <div>
      <label style="display:block;font-size:12px;color:#64748b;margin-bottom:6px;">Email</label>
      <label>
        <input type="email" name="customerEmail" placeholder="e.g., john@email.com"
               style="width:100%;padding:12px;border-radius:12px;border:1px solid #e5e7eb;">
      </label>
    </div>
  </div>

  <div>
    <label style="display:block;font-size:12px;color:#64748b;margin-bottom:6px;">Select Room</label>
    <label>
      <select name="roomId" required style="width:100%;padding:12px;border-radius:12px;border:1px solid #e5e7eb;">
        <option value="">-- Select a Room --</option>
        <% if (rooms != null) {
          for (Room r : rooms) { %>
        <option value="<%= r.getId() %>">
          Room <%= r.getRoomNumber() %> | <%= r.getRoomType() %> | LKR <%= r.getPrice() %>
        </option>
        <% } } %>
      </select>
    </label>
  </div>

  <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;">
    <div>
      <label style="display:block;font-size:12px;color:#64748b;margin-bottom:6px;">Check-in</label>
      <label>
        <input type="date" name="checkIn" required
               style="width:100%;padding:12px;border-radius:12px;border:1px solid #e5e7eb;">
      </label>
    </div>
    <div>
      <label style="display:block;font-size:12px;color:#64748b;margin-bottom:6px;">Check-out</label>
      <label>
        <input type="date" name="checkOut" required
               style="width:100%;padding:12px;border-radius:12px;border:1px solid #e5e7eb;">
      </label>
    </div>
  </div>

  <button type="submit"
          style="padding:12px;border:none;border-radius:12px;background:#111827;color:#fff;font-weight:700;cursor:pointer;width:220px;">
    Create Reservation
  </button>
</form>

<script>
  (function(){
    const msg = document.getElementById("flashMsg");
    if(!msg) return;

    setTimeout(() => {
      msg.classList.add("hide");
    }, 2500);

    setTimeout(() => {
      msg.remove();
    }, 3200);
  })();
</script>