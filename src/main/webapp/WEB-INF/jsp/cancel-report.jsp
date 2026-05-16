<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cancel Report - ParkPulse</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 700px;
            margin: 50px auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .header h1 {
            font-size: 28px;
            margin-bottom: 10px;
        }

        .cancel-container {
            padding: 30px;
        }

        .search-box {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
        }

        .search-box input {
            flex: 1;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            font-size: 16px;
        }

        .search-box button {
            background: #6c757d;
            color: white;
            border: none;
            padding: 0 25px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
        }

        .report-card {
            background: #f8f9ff;
            border-radius: 16px;
            padding: 25px;
            margin-top: 20px;
        }

        .warning-box {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
        }

        .btn-cancel {
            background: #dc3545;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
        }

        .btn-cancel:hover {
            background: #c82333;
        }

        .btn-back {
            display: inline-block;
            margin-top: 20px;
            color: #667eea;
            text-decoration: none;
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

        .status-CANCELLED {
            background: #6c757d;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .info-row {
            display: flex;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .info-label {
            width: 120px;
            font-weight: 600;
            color: #555;
        }

        .info-value {
            flex: 1;
            color: #333;
        }

        .success-box {
            background: #d4edda;
            border-left: 4px solid #28a745;
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
            text-align: center;
        }

        .footer {
            text-align: center;
            padding: 20px;
            color: #888;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>🗑️ Cancel Report</h1>
        <p>Cancel a pending report (only PENDING status can be cancelled)</p>
    </div>

    <div class="cancel-container">
        <div class="search-box">
            <input type="text" id="ticketId" placeholder="Enter Ticket ID to cancel" value="<%= request.getParameter("id") != null ? request.getParameter("id") : "" %>">
            <button onclick="searchReport()">Search</button>
        </div>

        <div id="result">
            <% if (request.getParameter("id") != null && request.getParameter("cancelled") == null) { %>
            <div class="report-card">
                <h3>Ticket #<%= request.getParameter("id") %></h3>

                <div class="info-row">
                    <div class="info-label">Issue Type:</div>
                    <div class="info-value">🚧 Broken Gate/Arm</div>
                </div>
                <div class="info-row">
                    <div class="info-label">Description:</div>
                    <div class="info-value">Gate number 3 is not opening</div>
                </div>
                <div class="info-row">
                    <div class="info-label">Status:</div>
                    <div class="info-value"><span class="status-PENDING">PENDING</span></div>
                </div>
                <div class="info-row">
                    <div class="info-label">Reported On:</div>
                    <div class="info-value">May 16, 2026 - 10:30 AM</div>
                </div>

                <div class="warning-box">
                    ⚠️ <strong>Warning:</strong> This action cannot be undone. The report will be permanently cancelled.
                </div>

                <button class="btn-cancel" onclick="confirmCancel(<%= request.getParameter("id") %>)">Confirm Cancellation</button>
            </div>
            <% } else if (request.getParameter("cancelled") != null) { %>
            <div class="report-card">
                <div class="success-box">
                    ✅ <strong>Report #<%= request.getParameter("id") %> has been cancelled successfully!</strong>
                </div>
                <a href="my-reports.jsp" class="btn-back">← Back to My Reports</a>
            </div>
            <% } else { %>
            <div class="report-card">
                <p style="text-align: center; color: #888;">🔍 Enter a Ticket ID above to cancel a report</p>
                <p style="text-align: center; color: #888; font-size: 12px; margin-top: 10px;">Note: Only reports with PENDING status can be cancelled</p>
            </div>
            <% } %>
        </div>

        <a href="my-reports.jsp" class="btn-back">← Back to My Reports</a>
    </div>
</div>

<div class="footer">
    <p>© 2024 ParkPulse - Parking Management System</p>
</div>

<script>
    function searchReport() {
        var ticketId = document.getElementById('ticketId').value;
        if (ticketId.trim() === '') {
            alert('Please enter a Ticket ID');
            return;
        }
        window.location.href = 'cancel-report.jsp?id=' + ticketId;
    }

    function confirmCancel(id) {
        if (confirm('Are you sure you want to cancel this report? This action cannot be undone.')) {
            window.location.href = 'cancel-report.jsp?id=' + id + '&cancelled=true';
        }
    }
</script>
</body>
</html>