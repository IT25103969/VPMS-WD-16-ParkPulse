<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Reports - ParkPulse</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            min-height: 100vh;
        }

        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar h1 {
            font-size: 24px;
        }

        .nav-links {
            display: flex;
            gap: 20px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 8px;
        }

        .nav-links a:hover {
            background: rgba(255,255,255,0.2);
        }

        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .header-actions h2 {
            color: #333;
        }

        .btn-new {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            display: inline-block;
        }

        .btn-new:hover {
            transform: translateY(-2px);
        }

        .stats {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            flex: 1;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .stat-number {
            font-size: 32px;
            font-weight: bold;
            color: #667eea;
        }

        .stat-label {
            color: #666;
            margin-top: 5px;
        }

        table {
            width: 100%;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background: #667eea;
            color: white;
        }

        tr:hover {
            background: #f8f9ff;
        }

        .status-PENDING {
            background: #ffc107;
            color: #333;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .status-IN_PROGRESS {
            background: #17a2b8;
            color: white;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .status-RESOLVED {
            background: #28a745;
            color: white;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .status-CLOSED {
            background: #6c757d;
            color: white;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .priority-URGENT {
            background: #dc3545;
            color: white;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .priority-HIGH {
            background: #fd7e14;
            color: white;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .priority-MEDIUM {
            background: #ffc107;
            color: #333;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .priority-LOW {
            background: #28a745;
            color: white;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .view-link {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }

        .view-link:hover {
            text-decoration: underline;
        }

        .empty-state {
            text-align: center;
            padding: 60px;
            background: white;
            border-radius: 12px;
        }

        .empty-state p {
            color: #666;
            margin-bottom: 20px;
        }

        .footer {
            text-align: center;
            padding: 20px;
            color: #666;
            margin-top: 40px;
        }
    </style>
</head>
<body>
<div class="navbar">
    <h1>🚗 ParkPulse</h1>
    <div class="nav-links">
        <a href="#">Dashboard</a>
        <a href="my-reports.jsp">My Reports</a>
        <a href="submit-report.jsp">Report Issue</a>
        <a href="#">Logout</a>
    </div>
</div>

<div class="container">
    <div class="header-actions">
        <h2>📋 My Support Tickets</h2>
        <a href="submit-report.jsp" class="btn-new">+ Report New Issue</a>
    </div>

    <div class="stats">
        <div class="stat-card">
            <div class="stat-number" id="totalCount">0</div>
            <div class="stat-label">Total Reports</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="pendingCount">0</div>
            <div class="stat-label">Pending</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="resolvedCount">0</div>
            <div class="stat-label">Resolved</div>
        </div>
    </div>

    <div class="empty-state">
        <p>📭 You haven't submitted any reports yet.</p>
        <a href="submit-report.jsp" class="btn-new">Submit Your First Report</a>
    </div>
</div>

<div class="footer">
    <p>© 2024 ParkPulse - Parking Management System</p>
</div>

<script>
    // This will be replaced with actual data from backend later
    const sampleReports = [
        { status: 'PENDING', priority: 'HIGH' },
        { status: 'RESOLVED', priority: 'LOW' }
    ];

    if (sampleReports.length > 0) {
        document.getElementById('totalCount').innerText = sampleReports.length;
        const pending = sampleReports.filter(r => r.status === 'PENDING').length;
        const resolved = sampleReports.filter(r => r.status === 'RESOLVED' || r.status === 'CLOSED').length;
        document.getElementById('pendingCount').innerText = pending;
        document.getElementById('resolvedCount').innerText = resolved;
    }
</script>
</body>
</html>