<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Track Status - ParkPulse</title>
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
            max-width: 800px;
            margin: 50px auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .header h1 {
            font-size: 28px;
            margin-bottom: 10px;
        }

        .header p {
            opacity: 0.9;
        }

        .track-container {
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

        .search-box input:focus {
            outline: none;
            border-color: #667eea;
        }

        .search-box button {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 0 25px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
        }

        .result-card {
            background: #f8f9ff;
            border-radius: 16px;
            padding: 25px;
            margin-top: 20px;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
        }

        .status-PENDING {
            background: #ffc107;
            color: #333;
        }

        .status-IN_PROGRESS {
            background: #17a2b8;
            color: white;
        }

        .status-RESOLVED {
            background: #28a745;
            color: white;
        }

        .status-CLOSED {
            background: #6c757d;
            color: white;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin: 20px 0;
        }

        .info-item {
            background: white;
            padding: 15px;
            border-radius: 12px;
        }

        .info-label {
            font-size: 12px;
            color: #888;
            margin-bottom: 5px;
        }

        .info-value {
            font-size: 16px;
            font-weight: 600;
            color: #333;
        }

        .progress-bar {
            background: #e0e0e0;
            border-radius: 10px;
            height: 8px;
            margin: 20px 0;
        }

        .progress-fill {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
            height: 100%;
            width: 0%;
        }

        .not-found {
            text-align: center;
            padding: 40px;
            color: #888;
        }

        .btn-back {
            display: inline-block;
            margin-top: 20px;
            color: #667eea;
            text-decoration: none;
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
        <h1>🔍 Track Report Status</h1>
        <p>Enter your ticket ID to check the current status</p>
    </div>

    <div class="track-container">
        <div class="search-box">
            <input type="text" id="ticketId" placeholder="Enter Ticket ID (e.g., 12345)" value="<%= request.getParameter("id") != null ? request.getParameter("id") : "" %>">
            <button onclick="trackReport()">Track</button>
        </div>

        <div id="result">
            <% if (request.getParameter("id") != null) { %>
            <div class="result-card">
                <h3>Ticket #<%= request.getParameter("id") %></h3>

                <div class="progress-bar">
                    <div class="progress-fill" style="width: 60%"></div>
                </div>

                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-label">Issue Type</div>
                        <div class="info-value">🚧 Broken Gate/Arm</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Status</div>
                        <div class="info-value"><span class="status-badge status-IN_PROGRESS">IN PROGRESS</span></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Priority</div>
                        <div class="info-value">URGENT</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Reported On</div>
                        <div class="info-value">May 16, 2026</div>
                    </div>
                </div>

                <p><strong>Latest Update:</strong> Maintenance team has been dispatched to your location. Estimated resolution time: 1 hour.</p>
            </div>
            <% } else { %>
            <div class="not-found">
                <p>📋 Enter a ticket ID above to check your report status</p>
            </div>
            <% } %>
        </div>

        <a href="submit-report.jsp" class="btn-back">← Submit New Report</a>
    </div>
</div>

<div class="footer">
    <p>© 2024 ParkPulse - Parking Management System</p>
</div>

<script>
    function trackReport() {
        var ticketId = document.getElementById('ticketId').value;
        if (ticketId.trim() === '') {
            alert('Please enter a Ticket ID');
            return;
        }
        window.location.href = 'track-status.jsp?id=' + ticketId;
    }
</script>
</body>
</html>