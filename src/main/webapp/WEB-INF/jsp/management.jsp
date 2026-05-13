<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket Management - History</title>
    <style>
        :root {
            --primary: #2c3e50;
            --secondary: #34495e;
            --accent: #3498db;
            --success: #27ae60;
            --warning: #f39c12;
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
        
        .card { background: white; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); padding: 25px; }
        .card-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 2px solid #f0f0f0; padding-bottom: 15px; }
        .card-title { margin: 0; font-size: 1.1rem; }
        
        .hint { font-size: 0.85rem; color: #7f8c8d; background: #fdf9e1; padding: 8px 12px; border-radius: 4px; border-left: 4px solid var(--warning); }
        
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th { text-align: left; padding: 15px; background: #fdfdfd; border-bottom: 2px solid #eee; color: #666; font-weight: 600; }
        td { padding: 15px; border-bottom: 1px solid #eee; }
        
        /* Inline Editing */
        .editable { 
            position: relative;
            cursor: pointer;
            transition: 0.2s;
            border-radius: 4px;
        }
        .editable:hover { background: #f0f7ff; color: var(--accent); }
        .editable::after {
            content: '✎';
            position: absolute;
            right: 10px;
            opacity: 0;
            font-size: 0.8rem;
        }
        .editable:hover::after { opacity: 0.5; }
        
        .editing { 
            background: white !important; 
            border: 2px solid var(--accent) !important; 
            outline: none; 
            box-shadow: 0 0 8px rgba(52, 152, 219, 0.2);
            color: var(--text) !important;
        }
        
        .badge-success { padding: 4px 8px; border-radius: 4px; font-size: 0.8rem; font-weight: bold; background: #e8f5e9; color: #2e7d32; }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <h2>PARK-IT</h2>
        </div>
        <div class="sidebar-nav">
            <a href="/">Dashboard</a>
            <a href="/management" class="active">Ticket Management</a>
        </div>
    </div>
    
    <div class="main-content">
        <div class="top-bar">
            <h1>Transaction History</h1>
        </div>
        
        <div class="content-area">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Completed Tickets</h3>
                    <div class="hint">Click values to edit. Changes save on Enter or Blur.</div>
                </div>
                
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>License Plate</th>
                            <th>Entry Time</th>
                            <th>Exit Time</th>
                            <th>Amount Paid</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${checkedOutTickets}" var="ticket">
                            <tr data-id="${ticket.id}">
                                <td>#${ticket.id}</td>
                                <td class="editable" data-field="licensePlate"><strong>${ticket.licensePlate}</strong></td>
                                <td><fmt:formatDate value="${java.util.Date.from(ticket.entryTime.atZone(java.time.ZoneId.systemDefault()).toInstant())}" pattern="MMM dd, HH:mm" /></td>
                                <td><fmt:formatDate value="${java.util.Date.from(ticket.exitTime.atZone(java.time.ZoneId.systemDefault()).toInstant())}" pattern="MMM dd, HH:mm" /></td>
                                <td class="editable" data-field="amount">${ticket.amount}</td>
                                <td><span class="badge-success">PAID</span></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty checkedOutTickets}">
                            <tr>
                                <td colspan="6" style="text-align: center; color: #999; padding: 30px;">No completed transactions found.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        document.querySelectorAll('.editable').forEach(cell => {
            cell.addEventListener('click', function() {
                if (this.classList.contains('editing')) return;

                const originalValue = this.innerText.trim();
                this.classList.add('editing');
                this.contentEditable = true;
                this.focus();

                const save = () => {
                    this.classList.remove('editing');
                    this.contentEditable = false;
                    const newValue = this.innerText.trim();

                    if (newValue !== originalValue) {
                        const row = this.closest('tr');
                        const id = row.getAttribute('data-id');
                        const licensePlate = row.querySelector('[data-field="licensePlate"]').innerText.trim();
                        const amount = row.querySelector('[data-field="amount"]').innerText.trim();

                        const params = new URLSearchParams();
                        params.append('id', id);
                        params.append('licensePlate', licensePlate);
                        params.append('amount', amount);

                        fetch('/update-ticket', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                            body: params
                        }).then(response => response.text())
                          .then(result => {
                              if (result !== 'Success') {
                                  alert('Error saving changes. Reverting...');
                                  this.innerText = originalValue;
                              }
                          }).catch(err => {
                              alert('Network error. Reverting...');
                              this.innerText = originalValue;
                          });
                    }
                };

                this.addEventListener('keydown', function(e) {
                    if (e.key === 'Enter') {
                        e.preventDefault();
                        this.blur();
                    }
                    if (e.key === 'Escape') {
                        this.innerText = originalValue;
                        this.blur();
                    }
                });

                this.addEventListener('blur', save, { once: true });
            });
        });
    </script>
</body>
</html>
