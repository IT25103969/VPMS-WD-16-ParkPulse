<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Parking Management - Dashboard</title>
    <style>
        :root {
            --primary: #2c3e50;
            --secondary: #34495e;
            --accent: #3498db;
            --success: #27ae60;
            --light: #ecf0f1;
            --text: #333;
        }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; display: flex; margin: 0; height: 100vh; background: #f8f9fa; color: var(--text); }
        
        /* Sidebar */
        .sidebar { width: 260px; background: var(--primary); color: white; display: flex; flex-direction: column; box-shadow: 2px 0 5px rgba(0,0,0,0.1); }
        .sidebar-header { padding: 30px 20px; text-align: center; border-bottom: 1px solid var(--secondary); }
        .sidebar-header h2 { margin: 0; font-size: 1.5rem; letter-spacing: 1px; }
        .sidebar-nav { flex-grow: 1; padding: 20px 0; }
        .sidebar-nav a { display: block; padding: 15px 25px; color: #bdc3c7; text-decoration: none; transition: 0.3s; border-left: 4px solid transparent; }
        .sidebar-nav a:hover, .sidebar-nav a.active { background: var(--secondary); color: white; border-left-color: var(--accent); }
        
        /* Main Content */
        .main-content { flex-grow: 1; display: flex; flex-direction: column; overflow: hidden; }
        .top-bar { height: 70px; background: white; display: flex; align-items: center; padding: 0 40px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .top-bar h1 { margin: 0; font-size: 1.2rem; color: var(--secondary); }
        
        .content-area { padding: 30px 40px; overflow-y: auto; }
        
        /* Stats Cards */
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: white; padding: 20px; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.02); border: 1px solid #eee; }
        .stat-card .label { color: #888; font-size: 0.9rem; margin-bottom: 5px; }
        .stat-card .value { font-size: 1.8rem; font-weight: bold; color: var(--primary); }
        
        /* Forms & Tables */
        .card { background: white; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); padding: 25px; margin-bottom: 30px; }
        .card-title { margin-top: 0; margin-bottom: 20px; font-size: 1.1rem; border-bottom: 2px solid #f0f0f0; padding-bottom: 10px; }
        
        .form-group { display: flex; gap: 10px; }
        input[type="text"] { flex-grow: 1; padding: 12px 15px; border: 1px solid #ddd; border-radius: 6px; outline: none; }
        input[type="text"]:focus { border-color: var(--accent); }
        
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 15px; background: #fdfdfd; border-bottom: 2px solid #eee; color: #666; font-weight: 600; }
        td { padding: 15px; border-bottom: 1px solid #eee; }
        
        .btn { padding: 10px 20px; border: none; border-radius: 6px; cursor: pointer; font-weight: 600; transition: 0.2s; }
        .btn-primary { background: var(--accent); color: white; }
        .btn-primary:hover { background: #2980b9; }
        .btn-success { background: var(--success); color: white; }
        .btn-success:hover { background: #219150; }
        
        .badge { padding: 4px 8px; border-radius: 4px; font-size: 0.8rem; font-weight: bold; background: #e1f5fe; color: #01579b; }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <h2>PARK-IT</h2>
        </div>
        <div class="sidebar-nav">
            <a href="/" class="active">Dashboard</a>
            <a href="/management">Ticket Management</a>
        </div>
    </div>
    
    <div class="main-content">
        <div class="top-bar">
            <h1>Parking Overview</h1>
        </div>
        
        <div class="content-area">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="label">Total Capacity</div>
                    <div class="value">100</div>
                </div>
                <div class="stat-card">
                    <div class="label">Occupied</div>
                    <div class="value">${activeTickets.size()}</div>
                </div>
                <div class="stat-card">
                    <div class="label">Available</div>
                    <div class="value">${100 - activeTickets.size()}</div>
                </div>
            </div>

            <div class="card">
                <h3 class="card-title">Entry Gate: Check-In Vehicle</h3>
                <form action="/check-in" method="post" class="form-group">
                    <input type="text" name="licensePlate" placeholder="Vehicle License Plate (e.g. ABC-1234)" required>
                    <button type="submit" class="btn btn-primary">Generate Ticket</button>
                </form>
            </div>

            <div class="card">
                <h3 class="card-title">Currently Parked Vehicles</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Ticket ID</th>
                            <th>License Plate</th>
                            <th>Entry Time</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${activeTickets}" var="ticket">
                            <tr>
                                <td>#${ticket.id}</td>
                                <td><strong>${ticket.licensePlate}</strong></td>
                                <td><fmt:formatDate value="${java.util.Date.from(ticket.entryTime.atZone(java.time.ZoneId.systemDefault()).toInstant())}" pattern="MMM dd, HH:mm" /></td>
                                <td><span class="badge">ACTIVE</span></td>
                                <td>
                                    <form action="/check-out" method="post" style="margin:0;">
                                        <input type="hidden" name="id" value="${ticket.id}">
                                        <button type="submit" class="btn btn-success">Check-Out & Pay</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty activeTickets}">
                            <tr>
                                <td colspan="5" style="text-align: center; color: #999; padding: 30px;">No vehicles currently parked.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
