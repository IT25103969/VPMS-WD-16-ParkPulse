<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report Details - ParkPulse</title>
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
            max-width: 900px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-header h2 {
            font-size: 20px;
        }

        .ticket-id {
            background: rgba(255,255,255,0.2);
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 14px;
        }

        .card-body {
            padding: 25px;
        }

        .info-row {
            display: flex;
            margin-bottom: 20px;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
        }

        .info-label {
            width: 150px;
            font-weight: 600;
            color: #555;
        }

        .info-value {
            flex: 1;
            color: #333;
        }

        .status-PENDING {
            background: #ffc107;
            color: #333;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .status-IN_PROGRESS {
            background: #17a2b8;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .status-RESOLVED {
            background: #28a745;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .status-CLOSED {
            background: #6c757d;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .priority-URGENT {
            background: #dc3545;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .priority-HIGH {
            background: #fd7e14;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .priority-MEDIUM {
            background: #ffc107;
            color: #333;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .priority-LOW {
            background: #28a745;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .admin-notes {
            background: #f8f9ff;
            padding: 20px;
            border-radius: 12px;
            margin-top: 20px;
        }

        .admin-notes h4 {
            color: #667eea;
            margin-bottom: 10px;
        }

        .btn-back {
            background: #6c757d;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
        }

        .btn-back:hover {
            background: #5a6268;
        }

        .timeline {
            margin-top: 20px;
        }

        .timeline-item {
            display: flex;
            margin-bottom: 15px;
        }

        .timeline-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
        }

        .timeline-content {
            flex: 1;
        }

        .timeline-title {
            font-weight: 600;
            color: #333;
        }

        .timeline-date {
            font-size: 12px;
            color: #888;
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
        <a href="my-reports.jsp">My Reports</a>
        <a href="submit-report.jsp">Report Issue</a>
        <a href="#">Logout</a>
    </div>
</div>

<div class="container">
    <div class="card">
        <div class="card-header">
            <h2>📄 Report Details</h2>
            <span class="ticket-id">Ticket #<%= request.getParameter("id") != null ? request.getParameter("id") : "12345" %></span>
        </div>
        <div class="card-body">
            <div class="info-row">
                <div class="info-label">Issue Type:</div>
                <div class="info-value">🚧 Broken Gate/Arm</div>
            </div>

            <div class="info-row">
                <div class="info-label">Description:</div>
                <div class="info-value">Gate number 3 is not opening since 10 AM. The arm is stuck in the down position and vehicles are unable to exit.</div>
            </div>

            <div class="info-row">
                <div class="info-label">Priority:</div>
                <div class="info-value"><span class="priority-URGENT">URGENT</span></div>
            </div>

            <div class="info-row">
                <div class="info-label">Status:</div>
                <div class="info-value"><span class="status-IN_PROGRESS">IN PROGRESS</span></div>
            </div>

            <div class="info-row">
                <div class="info-label">Reported On:</div>
                <div class="info-value">2026-05-16 10:30 AM</div>
            </div>

            <div class="info-row">
                <div class="info-label">Resolved On:</div>
                <div class="info-value">-</div>
            </div>

            <div class="info-row">
                <div class="info-label">Assigned To:</div>
                <div class="info-value">Admin #1234</div>
            </div>

            <div class="admin-notes">
                <h4>📝 Admin Notes</h4>
                <p>Maintenance team has been notified. Expected resolution by 2:00 PM.</p>
            </div>

            <div class="timeline">
                <h4>⏱️ Timeline</h4>
                <div class="timeline-item">
                    <div class="timeline-icon">📝</div>
                    <div class="timeline-content">
                        <div class="timeline-title">Report Submitted</div>
                        <div class="timeline-date">May 16, 2026 - 10:30 AM</div>
                    </div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-icon">👨‍🔧</div>
                    <div class="timeline-content">
                        <div class="timeline-title">Assigned to Technician</div>
                        <div class="timeline-date">May 16, 2026 - 10:45 AM</div>
                    </div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-icon">🔄</div>
                    <div class="timeline-content">
                        <div class="timeline-title">Status Updated: IN PROGRESS</div>
                        <div class="timeline-date">May 16, 2026 - 11:00 AM</div>
                    </div>
                </div>
            </div>

            <a href="my-reports.jsp" class="btn-back">← Back to My Reports</a>
        </div>
    </div>
</div>

<div class="footer">
    <p>© 2024 ParkPulse - Parking Management System</p>
</div>
</body>
</html>