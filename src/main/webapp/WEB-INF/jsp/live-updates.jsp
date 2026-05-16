<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Live Updates - ParkPulse</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #1a1a2e;
            min-height: 100vh;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .live-badge {
            background: #dc3545;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 14px;
            animation: pulse 1.5s infinite;
        }

        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.6; }
            100% { opacity: 1; }
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            text-align: center;
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-number {
            font-size: 36px;
            font-weight: bold;
        }

        .recent-updates {
            background: white;
            border-radius: 12px;
            padding: 20px;
        }

        .recent-updates h3 {
            margin-bottom: 20px;
            color: #333;
        }

        .update-item {
            display: flex;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid #eee;
            animation: slideIn 0.5s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .update-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-right: 15px;
        }

        .update-icon.PENDING { background: #fff3cd; }
        .update-icon.IN_PROGRESS { background: #d1ecf1; }
        .update-icon.RESOLVED { background: #d4edda; }

        .update-content {
            flex: 1;
        }

        .update-title {
            font-weight: 600;
            color: #333;
        }

        .update-time {
            font-size: 12px;
            color: #888;
        }

        .notification-toast {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: #28a745;
            color: white;
            padding: 15px 20px;
            border-radius: 8px;
            animation: slideUp 0.5s ease;
            z-index: 1000;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .footer {
            text-align: center;
            padding: 20px;
            color: #888;
            margin-top: 30px;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: bold;
        }

        .status-PENDING { background: #ffc107; color: #333; }
        .status-IN_PROGRESS { background: #17a2b8; color: white; }
        .status-RESOLVED { background: #28a745; color: white; }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>📡 Live Updates</h1>
        <div class="live-badge">● LIVE</div>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-number" id="totalReports">0</div>
            <div>Total Reports</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="pendingReports" style="color: #ffc107;">0</div>
            <div>Pending</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="inProgressReports" style="color: #17a2b8;">0</div>
            <div>In Progress</div>
        </div>
        <div class="stat-card">
            <div class="stat-number" id="resolvedReports" style="color: #28a745;">0</div>
            <div>Resolved</div>
        </div>
    </div>

    <div class="recent-updates">
        <h3>🔄 Recent Status Updates</h3>
        <div id="updatesList"></div>
    </div>
</div>

<div class="footer">
    <p>© 2024 ParkPulse - Live updates refresh automatically every 5 seconds</p>
</div>

<script>
    let updateCount = 0;

    function getRandomStatus() {
        const statuses = ['PENDING', 'IN_PROGRESS', 'RESOLVED'];
        return statuses[Math.floor(Math.random() * statuses.length)];
    }

    function getRandomIcon(status) {
        switch(status) {
            case 'PENDING': return '⏳';
            case 'IN_PROGRESS': return '🔄';
            case 'RESOLVED': return '✅';
            default: return '📝';
        }
    }

    function getRandomTitle(status, id) {
        switch(status) {
            case 'PENDING': return `Report #${id} is now PENDING`;
            case 'IN_PROGRESS': return `Report #${id} is now IN PROGRESS`;
            case 'RESOLVED': return `Report #${id} has been RESOLVED`;
            default: return `Report #${id} status updated`;
        }
    }

    function addUpdate() {
        updateCount++;
        const reportId = 1000 + Math.floor(Math.random() * 100);
        const status = getRandomStatus();
        const icon = getRandomIcon(status);
        const title = getRandomTitle(status, reportId);
        const time = new Date().toLocaleTimeString();

        const updateDiv = document.createElement('div');
        updateDiv.className = 'update-item';
        updateDiv.innerHTML = `
                <div class="update-icon ${status}">
                    <span>${icon}</span>
                </div>
                <div class="update-content">
                    <div class="update-title">${title}</div>
                    <div class="update-time">${time}</div>
                </div>
            `;

        const updatesList = document.getElementById('updatesList');
        updatesList.insertBefore(updateDiv, updatesList.firstChild);

        while (updatesList.children.length > 10) {
            updatesList.removeChild(updatesList.lastChild);
        }

        updateStats();
        showNotification(title);
    }

    function updateStats() {
        const total = 24 + Math.floor(Math.random() * 5);
        const pending = 8 + Math.floor(Math.random() * 3);
        const inProgress = 12 + Math.floor(Math.random() * 3);
        const resolved = 4 + Math.floor(Math.random() * 2);

        document.getElementById('totalReports').innerText = total;
        document.getElementById('pendingReports').innerText = pending;
        document.getElementById('inProgressReports').innerText = inProgress;
        document.getElementById('resolvedReports').innerText = resolved;
    }

    function showNotification(message) {
        const toast = document.createElement('div');
        toast.className = 'notification-toast';
        toast.innerHTML = `
                🔔 ${message}
            `;
        document.body.appendChild(toast);

        setTimeout(() => {
            toast.remove();
        }, 3000);
    }

    setInterval(addUpdate, 5000);

    for(let i = 0; i < 5; i++) {
        setTimeout(() => addUpdate(), i * 1000);
    }

    updateStats();
</script>
</body>
</html>