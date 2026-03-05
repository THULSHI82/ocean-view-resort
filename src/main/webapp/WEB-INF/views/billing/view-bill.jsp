<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.oceanviewresort.billing.model.Billing" %>

<style>
  /* Layout */
  .billWrap{max-width:980px;}
  .billHeader{display:flex;align-items:flex-start;justify-content:space-between;gap:14px;margin-bottom:14px;}
  .billHeader h3{margin:0;font-size:18px;}
  .billHeader p{margin:6px 0 0;color:#64748b;font-size:13px;}

  .billCard{background:#fff;border:1px solid #e5e7eb;border-radius:16px;box-shadow:0 10px 25px rgba(0,0,0,0.06);padding:18px;}
  .billForm{display:grid;grid-template-columns:1fr auto;gap:12px;align-items:end;margin-top:12px;}
  .billLabel{display:block;font-size:12px;color:#64748b;margin-bottom:6px;}
  .billInput{width:100%;padding:12px;border-radius:12px;border:1px solid #e5e7eb;font-size:14px;}
  .btnPrimary{padding:12px 16px;border:none;border-radius:12px;background:#111827;color:#fff;font-weight:800;cursor:pointer;}
  .btnGhost{padding:10px 12px;border-radius:12px;border:1px solid #e5e7eb;background:#fff;color:#111827;font-weight:800;cursor:pointer;}

  .alert{padding:10px;border-radius:12px;margin-top:12px;font-size:13px;}
  .alert.error{background:#fee2e2;color:#991b1b;border:1px solid #fecaca;}
  .alert.success{background:#d1fae5;color:#065f46;border:1px solid #a7f3d0;}

  /* Invoice */
  .invoice{margin-top:16px;}
  .invTop{display:flex;justify-content:space-between;gap:16px;flex-wrap:wrap;padding-bottom:12px;border-bottom:1px dashed #e5e7eb;}
  .invBrand{font-weight:900;font-size:16px;}
  .invMeta{color:#64748b;font-size:12px;line-height:1.6;}
  .invGrid{display:grid;grid-template-columns:1fr 1fr;gap:12px;margin-top:12px;}
  .invBox{border:1px solid #e5e7eb;border-radius:14px;padding:12px;background:#fff;}
  .invBox .k{color:#64748b;font-size:12px;margin-bottom:4px;}
  .invBox .v{font-weight:800;}
  .invTable{width:100%;border-collapse:collapse;margin-top:12px;border:1px solid #e5e7eb;border-radius:14px;overflow:hidden;}
  .invTable th{background:#f8fafc;text-align:left;padding:12px;font-size:12px;color:#64748b;}
  .invTable td{padding:12px;border-top:1px solid #e5e7eb;}
  .invTotal{margin-top:12px;display:flex;justify-content:flex-end;}
  .totals{width:360px;border:1px solid #e5e7eb;border-radius:14px;padding:12px;background:#fff;}
  .row{display:flex;justify-content:space-between;margin:8px 0;color:#0f172a;}
  .row.muted{color:#64748b;}
  .row.grand{font-size:16px;font-weight:900;border-top:1px solid #e5e7eb;padding-top:10px;margin-top:10px;}
  .invActions{margin-top:14px;display:flex;gap:10px;flex-wrap:wrap;}

  /* Status badge */
  .badge{
    display:inline-flex;align-items:center;gap:8px;
    padding:6px 10px;border-radius:999px;
    font-size:12px;font-weight:900;
    border:1px solid #e5e7eb;background:#fff;color:#111827;
  }
  .badge.paid{border-color:#a7f3d0;background:#d1fae5;color:#065f46;}
  .badge.pending{border-color:#fde68a;background:#fef3c7;color:#92400e;}
  .dot{width:8px;height:8px;border-radius:999px;background:currentColor;opacity:0.85;}

  /* Payment */
  .payBox{
    margin-top:16px;
    border:1px dashed #e5e7eb;
    border-radius:14px;
    padding:14px;
    background:#fff;
    display:flex;
    justify-content:space-between;
    gap:12px;
    flex-wrap:wrap;
    align-items:center;
  }
  .payLeft{min-width:260px;}
  .payTitle{margin:0;font-weight:900;}
  .paySub{margin:6px 0 0;color:#64748b;font-size:12px;}
  .payOptions{display:flex;gap:14px;align-items:center;flex-wrap:wrap;margin-top:10px;}
  .radio{
    display:inline-flex;gap:8px;align-items:center;
    padding:10px 12px;border-radius:12px;
    border:1px solid #e5e7eb;background:#fff;
    cursor:pointer;font-weight:800;font-size:13px;color:#111827;
  }
  .radio input{accent-color:#111827;}
  .payRight{display:flex;gap:10px;align-items:center;flex-wrap:wrap;}

  /* PRINT: show ONLY invoice */
  @media print{
    body *{visibility:hidden !important;}
    #printArea, #printArea *{visibility:visible !important;}
    #printArea{
      position:absolute;
      left:0; top:0;
      width:100%;
      margin:0;
    }
    .invActions, .payBox, .alert{display:none !important;}
    .billCard{box-shadow:none !important;border:none !important;}
  }
</style>

<div class="billWrap">
  <div class="billHeader">
    <div>
      <h3>Billing</h3>
      <p>Generate a printable invoice using the Reservation ID.</p>
    </div>
  </div>

  <div class="billCard">
    <form class="billForm" method="get" action="${pageContext.request.contextPath}/billing">
      <div>
        <label class="billLabel">Reservation ID</label>
        <label>
          <input class="billInput" type="number" name="reservationId" placeholder="e.g., 12" required>
        </label>
      </div>
      <button class="btnPrimary" type="submit">Generate Bill</button>
    </form>

    <%
      String error = (String) request.getAttribute("error");
      if (error != null) {
    %>
    <div class="alert error"><%= error %></div>
    <% } %>

    <%
      String success = (String) request.getAttribute("success");
      if (success != null) {
    %>
    <div class="alert success"><%= success %></div>
    <% } %>

    <%
      Billing bill = (Billing) request.getAttribute("bill");
      if (bill != null) {
        String status = bill.getPaymentStatus();
        if (status == null || status.isBlank()) status = "PENDING";
        boolean paid = "PAID".equalsIgnoreCase(status);
    %>

    <!-- PRINT ONLY AREA START -->
    <div id="printArea" class="invoice">

      <div class="invTop">
        <div>
          <div class="invBrand">Ocean View Resort</div>
          <div class="invMeta">
            Galle, Sri Lanka<br/>
            Tel: +94 77 000 0000<br/>
          </div>
        </div>

        <div class="invMeta" style="text-align:right;">
          <div style="display:flex;justify-content:flex-end;gap:10px;align-items:center;flex-wrap:wrap;">
            <strong>Invoice</strong>

            <span class="badge <%= paid ? "paid" : "pending" %>">
              <span class="dot"></span>
              <%= paid ? "PAID" : "PENDING" %>
            </span>
          </div>

          <div style="margin-top:6px;">Reservation ID: <strong><%= bill.getReservationId() %></strong></div>
        </div>
      </div>

      <div class="invGrid">
        <div class="invBox">
          <div class="k">Billed To</div>
          <div class="v"><%= bill.getCustomerName() %></div>
        </div>
        <div class="invBox">
          <div class="k">Room</div>
          <div class="v">Room <%= bill.getRoomNumber() %></div>
        </div>

        <div class="invBox">
          <div class="k">Check-in</div>
          <div class="v"><%= bill.getCheckInDate() %></div>
        </div>
        <div class="invBox">
          <div class="k">Check-out</div>
          <div class="v"><%= bill.getCheckOutDate() %></div>
        </div>
      </div>

      <table class="invTable">
        <thead>
        <tr>
          <th>Description</th>
          <th>Nights</th>
          <th>Rate (LKR)</th>
          <th>Amount (LKR)</th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td>Accommodation</td>
          <td><%= bill.getNights() %></td>
          <td><%= bill.getPricePerNight() %></td>
          <td><%= bill.getSubTotal() %></td>
        </tr>
        </tbody>
      </table>

      <div class="invTotal">
        <div class="totals">
          <div class="row muted">
            <span>Sub Total</span>
            <span>LKR <%= bill.getSubTotal() %></span>
          </div>
          <div class="row muted">
            <span>Service Charge (10%)</span>
            <span>LKR <%= bill.getServiceCharge() %></span>
          </div>
          <div class="row muted">
            <span>Tax (2%)</span>
            <span>LKR <%= bill.getTax() %></span>
          </div>
          <div class="row grand">
            <span>Grand Total</span>
            <span>LKR <%= bill.getGrandTotal() %></span>
          </div>
        </div>
      </div>

      <div class="invMeta" style="margin-top:10px;">
        Thank you for choosing Ocean View Resort.
      </div>
    </div>
    <!-- PRINT ONLY AREA END -->

    <!-- PAYMENT SETTLEMENT (NOT PRINTED) -->
    <div class="payBox">
      <div class="payLeft">
        <p class="payTitle">Settle Payment</p>
        <p class="paySub">
          Choose payment method and confirm settlement for this reservation.
        </p>

        <% if (paid) { %>
        <div class="alert success" style="margin-top:10px;">
          Bill already settled using <strong><%= bill.getPaymentMethod() == null ? "-" : bill.getPaymentMethod() %></strong>.
        </div>
        <% } else { %>
        <form method="post" action="${pageContext.request.contextPath}/billing" style="margin-top:10px;">
          <input type="hidden" name="reservationId" value="<%= bill.getReservationId() %>"/>

          <div class="payOptions">
            <label class="radio">
              <input type="radio" name="paymentMethod" value="CASH" required> Cash
            </label>
            <label class="radio">
              <input type="radio" name="paymentMethod" value="CARD"> Card
            </label>
          </div>

          <div class="payRight" style="margin-top:12px;">
            <button class="btnPrimary" type="submit">Settle Bill</button>
            <a class="btnGhost" href="${pageContext.request.contextPath}/billing?reservationId=<%= bill.getReservationId() %>"
               style="text-decoration:none;display:inline-flex;align-items:center;">Refresh</a>
          </div>
        </form>
        <% } %>
      </div>
    </div>

    <div class="invActions">
      <button class="btnPrimary" type="button" onclick="window.print()">Print Invoice</button>
      <a class="btnGhost" href="${pageContext.request.contextPath}/billing"
         style="text-decoration:none;display:inline-flex;align-items:center;">Clear</a>
    </div>

    <% } %>
  </div>
</div>