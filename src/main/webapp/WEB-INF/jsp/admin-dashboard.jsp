<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - ParkPulse</title>
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

        .sidebar {
            width: 260px;
            background: #16213e;
            color: white;
            position: fixed;
            height: 100%;
            padding: 20px;
        }

        .sidebar h2 {
            margin-bottom: 30px;
            font-size: 20px;
        }

        .sidebar nav a {
            display: block;
            color: #ccc;
            text-decoration: none;
            padding: 12px 15px;
            margin: 5px 0;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .sidebar nav a:hover {
            background: #0f3460;
            color: white;
        }

        .main-content {
            margin-left: 260px;
            padding: 20px;
        }

        .header {
            background: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .stats {
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

        .filters {
            background: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .filters select, .filters input {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
        }

        table {
            width: 100%;
            background: white;
            border-radius: 12px;
            overflow-x: auto;
            display: block;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background: #667eea;
            color: white;
        }

        .status-select, .priority-select {
            padding: 5px;
            border-radius: 6px;
            border: 1px solid #ddd;
        }

        .btn-update {
            background: #28a745;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-delete {
            background: #dc3545;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: white;
            padding: 30px;
            border-radius: 12px;
            width: 500px;
        }

        .modal-content textarea {
            width: 100%;
            padding: 10px;
            margin: 15px 0;
            border: 1px solid #ddd;
            border-radius: 6px;
            min-height: 100px;
        }

        .status-PENDING { color: #ffc107; font-weight: bold; }
        .status-IN_PROGRESS { color: #17a2b8; font-weight: bold; }
        .status-RESOLVED { color: #28a745; font-weight: bold; }
        .status-CLOSED { color: #6c757d; }

        .priority-URGENT { color: #dc3545; font-weight: bold; }
        .priority-HIGH { color: #fd7e14; font-weight: bold; }
        .priority-MEDIUM { color: #ffc107; }
        .priority-LOW { color: #28a745; }
    </style>
</head>
<body>
<div class="sidebar">
    <h2>🚗 ParkPulse Admin</h2>
    <nav>
        <a href="#">📊 Dashboard</a>
        <a href="#">📋 All Reports</a>
        <a href="#">👥 Users</a>
        <a href="#">⚙️ Settings</a>
        <a href="#">🚪 Logout</a>
    </nav>
</div>

<div class="main-content">
    <div class="header">
        <h1>📊 Problem Reports Dashboard</h1>
        <div>Admin: John Doe</div>
    </div>

    <div class="stats">
        <div class="stat-card">
            <div class="stat-number">24</div>
            <div class="stat-label">Total Reports</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">8</div>
            <div class="stat-label">Pending</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">12</div>
            <div class="stat-label">In Progress</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">4</div>
            <div class="stat-label">Resolved</div>
        </div>
    </div>

    <div class="filters">
        <select id="statusFilter">
            <option value="">All Status</option>
            <option value="PENDING">Pending</option>
            <option value="IN_PROGRESS">In Progress</option>
            <option value="RESOLVED">Resolved</option>
            <option value="CLOSED">Closed</option>
        </select>
        <select id="priorityFilter">
            <option value="">All Priority</option>
            <option value="URGENT">Urgent</option>
            <option value="HIGH">High</option>
            <option value="MEDIUM">Medium</option>
            <option value="LOW">Low</option>
        </select>
        <input type="text" id="searchInput" placeholder="Search by ID or User...">
        <button onclick="applyFilters()">Apply Filters</button>
    </div>

    <div style="overflow-x: auto;">
        <table id="reportsTable">
            <thead>
            <tr>
                <th>ID</th>
                <th>User</th>
                <th>Issue Type</th>
                <th>Priority</th>
                <th>Status</th>
                <th>Reported</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>#1001</td>
                <td>John Doe</td>
                <td>Broken Gate</td>
                <td class="priority-URGENT">URGENT</td>
                <td class="status-IN_PROGRESS">IN PROGRESS</td>
                <td>2026-05-16</td>
                <td>
                    <select class="status-select" onchange="updateStatus(1001, this.value)">
                        <option value="PENDING">Pending</option>
                        <option value="IN_PROGRESS" selected>In Progress</option>
                        <option value="RESOLVED">Resolved</option>
                        <option value="CLOSED">Closed</option>
                    </select>
                    <select class="priority-select" onchange="updatePriority(1001, this.value)">
                        <option value="URGENT" selected>Urgent</option>
                        <option value="HIGH">High</option>
                        <option value="MEDIUM">Medium</option>
                        <option value="LOW">Low</option>
                    </select>
                    <button class="btn-update" onclick="openNotesModal(1001)">Notes</button>
                    <button class="btn-delete" onclick="deleteReport(1001)">Delete</button>
                </td>
            </tr>
            <tr>
                <td>#1002</td>
                <td>Jane Smith</td>
                <td>Slot Blocked</td>
                <td class="priority-HIGH">HIGH</td>
                <td class="status-PENDING">PENDING</td>
                <td>2026-05-16</td>
                <td>
                    <select class="status-select" onchange="updateStatus(1002, this.value)">
                        <option value="PENDING" selected>Pending</option>
                        <option value="IN_PROGRESS">In Progress</option>
                        <option value="RESOLVED">Resolved</option>
                        <option value="CLOSED">Closed</option>
                    </select>
                    <select class="priority-select" onchange="updatePriority(1002, this.value)">
                        <option value="URGENT">Urgent</option>
                        <option value="HIGH" selected>High</option>
                        <option value="MEDIUM">Medium</option>
                        <option value="LOW">Low</option>
                    </select>
                    <button class="btn-update" onclick="openNotesModal(1002)">Notes</button>
                    <button class="btn-delete" onclick="deleteReport(1002)">Delete</button>
                </td>
            </tr>
            <tr>
                <td>#1003</td>
                <td>Mike Johnson</td>
                <td>Payment Error</td>
                <td class="priority-HIGH">HIGH</td>
                <td class="status-RESOLVED">RESOLVED</td>
                <td>2026-05-15</td>
                <td>
                    <select class="status-select" onchange="updateStatus(1003, this.value)">
                        <option value="PENDING">Pending</option>
                        <option value="IN_PROGRESS">In Progress</option>
                        <option value="RESOLVED" selected>Resolved</option>
                        <option value="CLOSED">Closed</option>
                    </select>
                    <select class="priority-select" onchange="updatePriority(1003, this.value)">
                        <option value="URGENT">Urgent</option>
                        <option value="HIGH" selected>High</option>
                        <option value="MEDIUM">Medium</option>
                        <option value="LOW">Low</option>
                    </select>
                    <button class="btn-update" onclick="openNotesModal(1003)">Notes</button>
                    <button class="btn-delete" onclick="deleteReport(1003)">Delete</button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<div id="notesModal" class="modal">
    <div class="modal-content">
        <h3>Add Admin Notes</h3>
        <textarea id="adminNotes" placeholder="Enter resolution notes..."></textarea>
        <button onclick="saveNotes()" style="background:#28a745; color:white; padding:10px 20px; border:none; border-radius:6px; cursor:pointer;">Save</button>
        <button onclick="closeModal()" style="background:#6c757d; color:white; padding:10px 20px; border:none; border-radius:6px; cursor:pointer;">Cancel</button>
    </div>
</div>

<script>
    let currentReportId = null;

    function updateStatus(id, status) {
        alert(`Report ${id} status updated to ${status}`);
    }

    function updatePriority(id, priority) {
        alert(`Report ${id} priority updated to ${priority}`);
    }

    function openNotesModal(id) {
        currentReportId = id;
        document.getElementById('notesModal').style.display = 'flex';
    }

    function saveNotes() {
        let notes = document.getElementById('adminNotes').value;
        alert(`Notes added to report ${currentReportId}: ${notes}`);
        closeModal();
    }

    function closeModal() {
        document.getElementById('notesModal').style.display = 'none';
        document.getElementById('adminNotes').value = '';
    }

    function deleteReport(id) {
        if(confirm(`Are you sure you want to delete report ${id}?`)) {
            alert(`Report ${id} deleted`);
        }
    }

    function applyFilters() {
        let status = document.getElementById('statusFilter').value;
        let priority = document.getElementById('priorityFilter').value;
        let search = document.getElementById('searchInput').value;
        alert(`Filters applied: Status=${status}, Priority=${priority}, Search=${search}`);
    }
</script>
</body>
</html>