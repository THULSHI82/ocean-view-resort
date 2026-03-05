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

  /* Form layout improvements */
  .formWrap{
    width:100%;
    max-width:100%;
    margin-top:14px;
  }

  .formCard{
    width:100%;
    background:#fff;
    border:1px solid #e5e7eb;
    border-radius:16px;
    padding:18px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.05);
  }

  .formGrid{
    display:grid;
    gap:14px;
  }

  .twoCol{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:12px;
  }

  @media(max-width:900px){
    .twoCol{ grid-template-columns:1fr; }
  }

  .fieldLabel{
    display:block;
    font-size:12px;
    color:#64748b;
    margin-bottom:6px;
  }

  .fieldInput, .fieldSelect{
    width:100%;
    padding:12px;
    border-radius:12px;
    border:1px solid #e5e7eb;
    font-size:14px;
  }

  .primaryBtn{
    padding:12px 16px;
    border:none;
    border-radius:12px;
    background:#111827;
    color:#fff;
    font-weight:800;
    cursor:pointer;
  }

  .ghostBtn{
    padding:12px 16px;
    border-radius:12px;
    border:1px solid #e5e7eb;
    background:#fff;
    color:#111827;
    font-weight:800;
    text-decoration:none;
    display:inline-flex;
    align-items:center;
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

<div class="formWrap">
  <div class="formCard">
    <form method="post" action="${pageContext.request.contextPath}/reservation">
      <div class="formGrid">

        <div>
          <label class="fieldLabel">Customer Name</label>
          <label>
            <input class="fieldInput" type="text" name="customerName" placeholder="e.g., Customer Name" required>
          </label>
        </div>

        <div class="twoCol">
          <div>
            <label class="fieldLabel">Phone</label>
            <label>
              <input class="fieldInput" type="text" name="customerPhone" placeholder="e.g., 0771234567">
            </label>
          </div>
          <div>
            <label class="fieldLabel">Email</label>
            <label>
              <input class="fieldInput" type="email" name="customerEmail" placeholder="e.g., john@email.com">
            </label>
          </div>
        </div>

        <div>
          <label class="fieldLabel">Select Room</label>
          <label>
            <select class="fieldSelect" name="roomId" required>
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

        <div class="twoCol">
          <div>
            <label class="fieldLabel">Check-in</label>
            <label>
              <input class="fieldInput" type="date" name="checkIn" required>
            </label>
          </div>
          <div>
            <label class="fieldLabel">Check-out</label>
            <label>
              <input class="fieldInput" type="date" name="checkOut" required>
            </label>
          </div>
        </div>

        <div style="display:flex;justify-content:flex-start;gap:10px;flex-wrap:wrap;">
          <button class="primaryBtn" type="submit">Create Reservation</button>

          <a class="ghostBtn" href="${pageContext.request.contextPath}/reservation?view=list">
            View Reservations
          </a>
        </div>

      </div>
    </form>
  </div>
</div>

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