<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Submit Report - ParkPulse</title>
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
            max-width: 650px;
            margin: 0 auto;
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
            font-size: 14px;
        }

        .form-container {
            padding: 30px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
            font-size: 14px;
        }

        label .required {
            color: #dc3545;
        }

        textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s;
            font-family: inherit;
            min-height: 120px;
            resize: vertical;
        }

        textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102,126,234,0.1);
        }

        .issue-types {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
        }

        .issue-card {
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            padding: 15px 10px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
        }

        .issue-card:hover {
            border-color: #667eea;
            background: #f0f0ff;
            transform: translateY(-2px);
        }

        .issue-card.selected {
            border-color: #667eea;
            background: linear-gradient(135deg, #667eea20 0%, #764ba220 100%);
        }

        .issue-card input {
            display: none;
        }

        .issue-icon {
            font-size: 32px;
            margin-bottom: 8px;
        }

        .issue-name {
            font-size: 13px;
            font-weight: 500;
            color: #555;
        }

        .priority-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: bold;
            margin-top: 8px;
        }

        .priority-auto {
            background: #e9ecef;
            color: #666;
        }

        .btn-submit {
            width: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 14px;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102,126,234,0.4);
        }

        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            padding: 14px 18px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav-links {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .nav-link {
            color: #667eea;
            text-decoration: none;
            font-size: 14px;
        }

        .nav-link:hover {
            text-decoration: underline;
        }

        .info-text {
            font-size: 12px;
            color: #888;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>🚨 Report an Issue</h1>
        <p>Help us improve your parking experience</p>
    </div>

    <div class="form-container">
        <div class="alert-info">
            <span>ℹ️</span>
            <span>Priority is automatically assigned based on issue type and description.</span>
        </div>

        <form id="reportForm" action="#" method="POST">
            <div class="form-group">
                <label>Select Issue Type <span class="required">*</span></label>
                <div class="issue-types" id="issueTypes">
                    <div class="issue-card" onclick="selectIssue(this, 'BROKEN_GATE')">
                        <div class="issue-icon">🚧</div>
                        <div class="issue-name">Broken Gate/Arm</div>
                        <div class="priority-badge priority-auto">Auto: URGENT</div>
                    </div>
                    <div class="issue-card" onclick="selectIssue(this, 'SLOT_BLOCKED')">
                        <div class="issue-icon">🚗</div>
                        <div class="issue-name">Slot Blocked</div>
                        <div class="priority-badge priority-auto">Auto: HIGH</div>
                    </div>
                    <div class="issue-card" onclick="selectIssue(this, 'PAYMENT_ERROR')">
                        <div class="issue-icon">💰</div>
                        <div class="issue-name">Payment Error</div>
                        <div class="priority-badge priority-auto">Auto: HIGH</div>
                    </div>
                    <div class="issue-card" onclick="selectIssue(this, 'LIGHT_FAILURE')">
                        <div class="issue-icon">💡</div>
                        <div class="issue-name">Light Failure</div>
                        <div class="priority-badge priority-auto">Auto: MEDIUM</div>
                    </div>
                    <div class="issue-card" onclick="selectIssue(this, 'OTHER')">
                        <div class="issue-icon">📝</div>
                        <div class="issue-name">Other</div>
                        <div class="priority-badge priority-auto">Auto: LOW</div>
                    </div>
                </div>
                <input type="hidden" name="issueType" id="issueType">
            </div>

            <div class="form-group">
                <label for="description">Description <span class="required">*</span></label>
                <textarea id="description" name="description"
                          placeholder="Please describe the issue in detail... (e.g., Gate number 3 is not opening since 10 AM, Slot A12 is blocked)"
                          required></textarea>
                <div class="info-text">💡 Tip: Include specific details like gate/slot numbers, time, or location for faster resolution.</div>
            </div>

            <button type="submit" class="btn-submit">📤 Submit Report</button>
        </form>

        <div class="nav-links">
            <a href="my-reports.jsp" class="nav-link">← My Reports</a>
            <a href="#" class="nav-link">Track Status →</a>
        </div>
    </div>
</div>

<script>
    function selectIssue(card, value) {
        document.querySelectorAll('.issue-card').forEach(c => c.classList.remove('selected'));
        card.classList.add('selected');
        document.getElementById('issueType').value = value;
    }

    document.getElementById('reportForm').addEventListener('submit', function(e) {
        const issueType = document.getElementById('issueType').value;
        const description = document.getElementById('description').value.trim();

        if (!issueType) {
            e.preventDefault();
            alert('Please select an issue type');
            return false;
        }

        if (!description) {
            e.preventDefault();
            alert('Please enter a description');
            return false;
        }

        return true;
    });
</script>
</body>
</html>