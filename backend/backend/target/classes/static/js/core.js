// ─── Shared Logic & Mock Data ────────────────────────────────────────────────

// Initial mock data from React App
const initialTickets = [
  {
    id: "TKT-001",
    vehiclePlate: "AB 123 CD",
    ownerName: "John Doe",
    slot: "A3",
    entryTime: "2026-05-14T08:30:00",
    exitTime: null,
    amount: 20,
    status: "ongoing",
    vehicleType: "Car",
    paymentMethod: "Cash",
  },
  {
    id: "TKT-002",
    vehiclePlate: "XY 456 ZA",
    ownerName: "Jane Smith",
    slot: "B7",
    entryTime: "2026-05-14T09:00:00",
    exitTime: null,
    amount: 30,
    status: "ongoing",
    vehicleType: "SUV",
    paymentMethod: "Card",
  },
  {
    id: "TKT-003",
    vehiclePlate: "GH 789 IJ",
    ownerName: "Michael Brown",
    slot: "A15",
    entryTime: "2026-05-14T07:00:00",
    exitTime: "2026-05-14T10:00:00",
    amount: 30,
    status: "finished",
    vehicleType: "Motorcycle",
    paymentMethod: "Cash",
  },
  {
    id: "TKT-004",
    vehiclePlate: "KL 321 MN",
    ownerName: "Sara Wilson",
    slot: "C2",
    entryTime: "2026-05-14T06:00:00",
    exitTime: "2026-05-14T09:30:00",
    amount: 35,
    status: "finished",
    vehicleType: "Car",
    paymentMethod: "Card",
  },
  {
    id: "TKT-005",
    vehiclePlate: "OP 654 QR",
    ownerName: "David Lee",
    slot: "A22",
    entryTime: "2026-05-14T10:15:00",
    exitTime: null,
    amount: 20,
    status: "ongoing",
    vehicleType: "Car",
    paymentMethod: "Cash",
  },
  {
    id: "TKT-006",
    vehiclePlate: "ST 987 UV",
    ownerName: "Emily Clark",
    slot: "B12",
    entryTime: "2026-05-13T14:00:00",
    exitTime: "2026-05-13T17:45:00",
    amount: 40,
    status: "finished",
    vehicleType: "Truck",
    paymentMethod: "Card",
  },
];

// ─── API Integration ────────────────────────────────────────────────────────

const API_BASE_URL = 'http://localhost:8080/api/tickets';

async function getTickets(params = {}) {
  try {
    const query = new URLSearchParams();
    Object.keys(params).forEach(key => {
      if (params[key] != null && params[key] !== '') {
        query.append(key, params[key]);
      }
    });

    const url = query.toString() ? `${API_BASE_URL}?${query.toString()}` : API_BASE_URL;
    const response = await fetch(url);
    if (!response.ok) throw new Error('Failed to fetch tickets');
    return await response.json();
  } catch (error) {
    console.error('Error fetching tickets:', error);
    return [];
  }
}

async function saveTicket(ticket) {
  try {
    const response = await fetch(`${API_BASE_URL}/${ticket.id}`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(ticket)
    });
    if (!response.ok) throw new Error('Failed to save ticket');
    return await response.json();
  } catch (error) {
    console.error('Error saving ticket:', error);
  }
}

async function deleteTicket(id) {
  try {
    const response = await fetch(`${API_BASE_URL}/${id}`, {
      method: 'DELETE'
    });
    if (!response.ok) throw new Error('Failed to delete ticket');
  } catch (error) {
    console.error('Error deleting ticket:', error);
  }
}

async function checkoutTicket(id, method) {
  try {
    const response = await fetch(`${API_BASE_URL}/${id}/checkout?paymentMethod=${method}`, {
      method: 'POST'
    });
    if (!response.ok) throw new Error('Failed to checkout ticket');
    return await response.json();
  } catch (error) {
    console.error('Error during checkout:', error);
  }
}

// ─── Dark Mode Logic ─────────────────────────────────────────────────────────

function initDarkMode() {
  const isDark = localStorage.getItem('theme') === 'dark';
  if (isDark) {
    document.documentElement.classList.add('dark');
  } else {
    document.documentElement.classList.remove('dark');
  }
}

function toggleDarkMode() {
  const isDark = document.documentElement.classList.toggle('dark');
  localStorage.setItem('theme', isDark ? 'dark' : 'light');
  // Trigger theme change event for charts or other components
  window.dispatchEvent(new Event('themechange'));
}

// ─── Sidebar Logic ──────────────────────────────────────────────────────────

function initSidebar() {
  const sidebar = document.getElementById('sidebar');
  const toggleBtn = document.getElementById('sidebar-toggle');
  const expanded = localStorage.getItem('sidebar-expanded') !== 'false';
  
  if (sidebar) {
    if (expanded) {
      sidebar.classList.remove('collapsed');
      sidebar.style.width = '220px';
    } else {
      sidebar.classList.add('collapsed');
      sidebar.style.width = '64px';
    }
  }

  if (toggleBtn) {
    toggleBtn.addEventListener('click', () => {
      const isCollapsed = sidebar.classList.toggle('collapsed');
      sidebar.style.width = isCollapsed ? '64px' : '220px';
      localStorage.setItem('sidebar-expanded', !isCollapsed);
    });
  }
}

// ─── Printing Logic ──────────────────────────────────────────────────────────

function fmt(iso) {
  return new Date(iso).toLocaleString("en-US", {
    weekday: "short", month: "short", day: "numeric",
    hour: "2-digit", minute: "2-digit",
  });
}

function duration(entry, exit) {
  const ms = (exit ? new Date(exit).getTime() : Date.now()) - new Date(entry).getTime();
  const h = Math.floor(ms / 3600000);
  const m = Math.floor((ms % 3600000) / 60000);
  return `${h}h ${m}m`;
}

const HOURLY_RATE = 10;

function printTicket(ticket, total) {
  const isFinished = ticket.status === "finished";
  const hours = isFinished && ticket.exitTime
    ? Math.ceil((new Date(ticket.exitTime).getTime() - new Date(ticket.entryTime).getTime()) / 3600000) || 1
    : null;
  const displayTotal = total != null
    ? total
    : isFinished && hours != null
      ? hours * HOURLY_RATE
      : null;

  const html = `<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8"/>
  <title>Ticket ${ticket.id}</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: 'Courier New', monospace;
      background: #fff;
      color: #111;
      display: flex;
      justify-content: center;
      padding: 32px 0;
    }
    .receipt {
      width: 320px;
      border: 1px dashed #ccc;
      border-radius: 12px;
      overflow: hidden;
    }
    .header {
      background: #1d4ed8;
      color: #fff;
      text-align: center;
      padding: 20px 16px 14px;
    }
    .header h1 { font-size: 20px; letter-spacing: 2px; margin-bottom: 4px; }
    .header p  { font-size: 11px; opacity: 0.8; }
    .badge {
      display: inline-block;
      margin-top: 10px;
      padding: 3px 12px;
      border-radius: 999px;
      font-size: 11px;
      font-weight: bold;
      letter-spacing: 1px;
      background: ${isFinished ? "#059669" : "#d97706"};
    }
    .divider {
      border: none;
      border-top: 1px dashed #ccc;
      margin: 0;
    }
    .section { padding: 14px 20px; }
    .row {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      margin-bottom: 10px;
      font-size: 12px;
    }
    .row:last-child { margin-bottom: 0; }
    .label { color: #666; }
    .value { font-weight: bold; text-align: right; max-width: 60%; }
    .total-box {
      background: #f0fdf4;
      border: 1px solid #bbf7d0;
      border-radius: 8px;
      margin: 0 16px 16px;
      padding: 12px 16px;
      text-align: center;
    }
    .total-label { font-size: 11px; color: #666; margin-bottom: 4px; }
    .total-amt   { font-size: 26px; font-weight: bold; color: #059669; }
    .footer {
      text-align: center;
      padding: 12px 16px 18px;
      font-size: 10px;
      color: #999;
    }
    .footer strong { color: #555; font-size: 11px; }
    @media print {
      body { padding: 0; }
      .receipt { border: none; width: 100%; border-radius: 0; }
    }
  </style>
</head>
<body>
<div class="receipt">
  <div class="header">
    <h1>ParkPulse</h1>
    <p>Parking Receipt</p>
    <span class="badge">${ticket.status.toUpperCase()}</span>
  </div>

  <hr class="divider"/>

  <div class="section">
    <div class="row"><span class="label">Ticket ID</span><span class="value">${ticket.id}</span></div>
    <div class="row"><span class="label">Owner</span><span class="value">${ticket.ownerName}</span></div>
    <div class="row"><span class="label">Vehicle</span><span class="value">${ticket.vehiclePlate}</span></div>
    <div class="row"><span class="label">Type</span><span class="value">${ticket.vehicleType}</span></div>
    <div class="row"><span class="label">Slot</span><span class="value">${ticket.slot}</span></div>
  </div>

  <hr class="divider"/>

  <div class="section">
    <div class="row"><span class="label">Entry</span><span class="value">${fmt(ticket.entryTime)}</span></div>
    ${ticket.exitTime ? `<div class="row"><span class="label">Exit</span><span class="value">${fmt(ticket.exitTime)}</span></div>` : ""}
    <div class="row"><span class="label">Duration</span><span class="value">${duration(ticket.entryTime, ticket.exitTime)}</span></div>
    <div class="row"><span class="label">Rate</span><span class="value">රු ${HOURLY_RATE}/hr</span></div>
    ${isFinished ? `<div class="row"><span class="label">Payment</span><span class="value">${ticket.paymentMethod}</span></div>` : ""}
  </div>

  ${displayTotal != null ? `
  <hr class="divider"/>
  <div class="total-box">
    <div class="total-label">${isFinished ? "Total Paid" : "Estimated Total"}</div>
    <div class="total-amt">රු ${displayTotal.toFixed(2)}</div>
  </div>
  ` : ""}

  <div class="footer">
    <strong>Thank you for using ParkPulse!</strong><br/>
    Printed on ${new Date().toLocaleString()}<br/>
    Keep this receipt for your records.
  </div>
</div>
<script>window.onload = () => { window.print(); window.onafterprint = () => window.close(); }</script>
</body>
</html>`;

  const w = window.open("", "_blank", "width=400,height=640");
  if (w) { w.document.write(html); w.document.close(); }
}

// ─── Initialize ──────────────────────────────────────────────────────────────

initDarkMode();
window.addEventListener('DOMContentLoaded', initSidebar);
