<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
    List<Map<String, Object>> reservations =
            (List<Map<String, Object>>) request.getAttribute("reservations");

    String q = (String) request.getAttribute("q");
    String from = (String) request.getAttribute("from");
    String to = (String) request.getAttribute("to");
%>

<style>
    .billBtn{
        padding:8px 10px;
        border-radius:10px;
        border:1px solid #0f172a;
        background:#0f172a;
        color:#fff;
        font-weight:700;
        text-decoration:none;
        font-size:12px;
    }

    .billBtn:hover{
        background:#1e293b;
    }

    .badge{
        display:inline-flex;align-items:center;gap:8px;
        padding:6px 10px;border-radius:999px;
        font-size:12px;font-weight:900;
        border:1px solid #e5e7eb;background:#fff;color:#111827;
    }
    .badge.paid{border-color:#a7f3d0;background:#d1fae5;color:#065f46;}
    .badge.pending{border-color:#fde68a;background:#fef3c7;color:#92400e;}
    .dot{width:8px;height:8px;border-radius:999px;background:currentColor;opacity:0.85;}

    .billBtn{
        padding:8px 10px;
        border-radius:10px;
        border:1px solid #0f172a;
        background:#0f172a;
        color:#fff;
        font-weight:800;
        text-decoration:none;
        font-size:12px;
        display:inline-flex;
        align-items:center;
        gap:8px;
    }
    .billBtn:hover{background:#1e293b;border-color:#1e293b;}

    .billBtn.disabled{
        background:#e5e7eb;
        border-color:#e5e7eb;
        color:#6b7280;
        cursor:not-allowed;
        pointer-events:none; /* makes it not clickable */
    }
</style>

<div style="display:flex;align-items:center;justify-content:space-between;">
    <div>
        <h3 style="margin:0;">View Reservations</h3>
        <p style="color:#64748b;margin:6px 0 0;">Search and manage existing bookings.</p>
    </div>
    <a href="${pageContext.request.contextPath}/reservation"
       style="text-decoration:none;padding:10px 12px;border-radius:12px;border:1px solid #e5e7eb;color:#111827;font-weight:700;">
        ➕ Add Reservation
    </a>
</div>

<form method="get" action="${pageContext.request.contextPath}/reservation"
      style="margin-top:14px;display:grid;grid-template-columns:2fr 1fr 1fr auto;gap:10px;align-items:end;">

    <input type="hidden" name="view" value="list"/>

    <div>
        <label style="display:block;font-size:12px;color:#64748b;margin-bottom:6px;">Search</label>
        <label>
            <input type="text" name="q" value="<%= q == null ? "" : q %>"
                   placeholder="Customer name / phone / room number"
                   style="width:100%;padding:12px;border-radius:12px;border:1px solid #e5e7eb;">
        </label>
    </div>

    <div>
        <label style="display:block;font-size:12px;color:#64748b;margin-bottom:6px;">From</label>
        <label>
            <input type="date" name="from" value="<%= from == null ? "" : from %>"
                   style="width:100%;padding:12px;border-radius:12px;border:1px solid #e5e7eb;">
        </label>
    </div>

    <div>
        <label style="display:block;font-size:12px;color:#64748b;margin-bottom:6px;">To</label>
        <label>
            <input type="date" name="to" value="<%= to == null ? "" : to %>"
                   style="width:100%;padding:12px;border-radius:12px;border:1px solid #e5e7eb;">
        </label>
    </div>

    <button type="submit"
            style="padding:12px 16px;border:none;border-radius:12px;background:#111827;color:#fff;font-weight:800;cursor:pointer;">
        Search
    </button>
</form>

<div style="margin-top:16px;border:1px solid #e5e7eb;border-radius:14px;overflow:hidden;background:#fff;">
    <table style="width:100%;border-collapse:collapse;">
        <thead style="background:#f8fafc;">
        <tr>
            <th style="text-align:left;padding:12px;font-size:12px;color:#64748b;">ID</th>
            <th style="text-align:left;padding:12px;font-size:12px;color:#64748b;">Customer</th>
            <th style="text-align:left;padding:12px;font-size:12px;color:#64748b;">Room</th>
            <th style="text-align:left;padding:12px;font-size:12px;color:#64748b;">Check-in</th>
            <th style="text-align:left;padding:12px;font-size:12px;color:#64748b;">Check-out</th>
            <th style="text-align:left;padding:12px;font-size:12px;color:#64748b;">Total</th>
            <th style="text-align:left;padding:12px;font-size:12px;color:#64748b;">Payment Method</th>
            <th style="text-align:left;padding:12px;font-size:12px;color:#64748b;">Payment Status</th>
            <th style="text-align:left;padding:12px;font-size:12px;color:#64748b;">Action</th>
            <th style="text-align:left;padding:12px;font-size:12px;color:#64748b;">Billing</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (reservations == null || reservations.isEmpty()) {
        %>
        <tr>
            <td colspan="10" style="padding:16px;color:#64748b;">No reservations found.</td>
        </tr>
        <%
        } else {
            for (Map<String, Object> r : reservations) {

            String payStatus = (String) r.get("payment_status");
            if (payStatus == null || payStatus.isBlank()) payStatus = "PENDING";
            boolean isPaid = "PAID".equalsIgnoreCase(payStatus);

            String payMethod = (String) r.get("payment_method");
            if (payMethod == null || payMethod.isBlank()) payMethod = "-";

        %>
        <tr style="border-top:1px solid #e5e7eb;">
            <td style="padding:12px;"><%= r.get("id") %></td>
            <td style="padding:12px;">
                <strong><%= r.get("customer_name") %></strong><br/>
                <span style="color:#64748b;font-size:12px;"><%= r.get("customer_phone") %></span>
            </td>
            <td style="padding:12px;">
                Room <strong><%= r.get("room_number") %></strong><br/>
                <span style="color:#64748b;font-size:12px;"><%= r.get("room_type") %></span>
            </td>
            <td style="padding:12px;"><%= r.get("check_in") %></td>
            <td style="padding:12px;"><%= r.get("check_out") %></td>
            <td style="padding:12px;">LKR <%= r.get("total_price") %></td>

            <td style="padding:12px;"><%= payMethod %></td>

            <td style="padding:12px;">
              <span class="badge <%= isPaid ? "paid" : "pending" %>">
                <span class="dot"></span>
                <%= isPaid ? "PAID" : "PENDING" %>
              </span>
            </td>


            <td style="padding:12px;">
                <form id="deleteForm-<%= r.get("id") %>"
                      method="post"
                      action="${pageContext.request.contextPath}/reservation"
                      style="margin:0;display:inline;">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="id" value="<%= r.get("id") %>"/>
                    <button type="button"
                            onclick="confirmDelete(<%= r.get("id") %>)"
                            style="padding:8px 10px;border-radius:10px;border:1px solid #fecaca;background:#fee2e2;color:#991b1b;font-weight:800;cursor:pointer;">
                        Delete
                    </button>
                </form>
            </td>

            <td style="padding:12px;">
                <% if (!isPaid) { %>
                <a href="${pageContext.request.contextPath}/billing?reservationId=<%= r.get("id") %>"
                   class="billBtn">
                    Generate Bill
                </a>
                <% } else { %>
                <a class="billBtn disabled" title="Bill already settled">
                    Paid
                </a>
                <% } %>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>

<script>
    function confirmDelete(reservationId){
        if(confirm("Are you sure you want to delete this reservation?")){
            document.getElementById("deleteForm-" + reservationId).submit();
        }
    }
</script>