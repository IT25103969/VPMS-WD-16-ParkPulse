// ─── Revenue Page Logic ──────────────────────────────────────────────────────

let charts = {};
let allTickets = [];

// ─── Initialization ──────────────────────────────────────────────────────────

window.addEventListener('DOMContentLoaded', async () => {
    await refreshData();
});

window.addEventListener('themechange', () => {
    updateChartColors();
});

async function refreshData() {
    allTickets = await getTickets();
    const finishedTickets = allTickets.filter(t => t.status === 'finished');
    
    renderKPIs(finishedTickets);
    initCharts(finishedTickets);
}

// ─── Rendering ───────────────────────────────────────────────────────────────

function renderKPIs(tickets) {
    const totalRevenue = tickets.reduce((s, t) => s + (Number(t.amount) || 0), 0);
    
    const now = new Date();
    const startOfMonth = new Date(now.getFullYear(), now.getMonth(), 1);
    const startOfWeek = new Date(now);
    startOfWeek.setDate(now.getDate() - now.getDay());
    
    const monthRevenue = tickets
        .filter(t => t.exitTime && new Date(t.exitTime) >= startOfMonth)
        .reduce((s, t) => s + (Number(t.amount) || 0), 0);
        
    const weekRevenue = tickets
        .filter(t => t.exitTime && new Date(t.exitTime) >= startOfWeek)
        .reduce((s, t) => s + (Number(t.amount) || 0), 0);
        
    const avgPerTicket = tickets.length > 0 ? totalRevenue / tickets.length : 0;

    const kpis = [
        { label: "Total Revenue (YTD)", value: `රු ${totalRevenue.toLocaleString()}`, change: "+0%", positive: true, icon: "banknote" },
        { label: "This Month", value: `රු ${monthRevenue.toLocaleString()}`, change: "+0%", positive: true, icon: "trending-up" },
        { label: "This Week", value: `රු ${weekRevenue.toLocaleString()}`, change: "+0%", positive: true, icon: "car" },
        { label: "Avg per Ticket", value: `රු ${avgPerTicket.toFixed(2)}`, change: "+0%", positive: true, icon: "credit-card" }
    ];

    const grid = document.getElementById('kpi-grid');
    grid.innerHTML = '';
    kpis.forEach(k => {
        const div = document.createElement('div');
        div.className = 'rounded-2xl border border-gray-100 dark:border-gray-700 bg-white dark:bg-gray-800 p-5';
        div.innerHTML = `
            <div class="flex items-start justify-between mb-3">
                <span class="text-xs text-gray-500 dark:text-gray-400">${k.label}</span>
                <span class="text-blue-400 opacity-70"><i data-lucide="${k.icon}" size="18"></i></span>
            </div>
            <p class="text-2xl font-semibold mb-2">${k.value}</p>
            <div class="flex items-center gap-1">
                <i data-lucide="${k.positive ? 'trending-up' : 'trending-down'}" size="12" class="${k.positive ? 'text-emerald-400' : 'text-red-400'}"></i>
                <span class="text-xs font-medium ${k.positive ? 'text-emerald-400' : 'text-red-400'}">${k.change}</span>
                <span class="text-xs text-gray-500 dark:text-gray-400">vs last period</span>
            </div>
        `;
        grid.appendChild(div);
    });
    lucide.createIcons();
}

// ─── Charts ──────────────────────────────────────────────────────────────────

function getChartColors() {
    const isDark = document.documentElement.classList.contains('dark');
    return {
        grid: isDark ? 'rgba(255,255,255,0.1)' : 'rgba(0,0,0,0.05)',
        text: isDark ? '#717182' : '#717182',
        primary: '#3b82f6',
        secondary: '#a78bfa',
        area: 'rgba(59, 130, 246, 0.1)'
    };
}

function initCharts(tickets) {
    const colors = getChartColors();
    
    // Process Data for Charts
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    const monthlyData = months.map((m, i) => ({
        month: m,
        revenue: tickets
            .filter(t => t.exitTime && new Date(t.exitTime).getMonth() === i)
            .reduce((s, t) => s + (Number(t.amount) || 0), 0)
    }));

    const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    const dailyData = days.map((d, i) => ({
        day: d,
        revenue: tickets
            .filter(t => t.exitTime && new Date(t.exitTime).getDay() === i)
            .reduce((s, t) => s + (Number(t.amount) || 0), 0)
    }));

    const methods = ["Cash", "Card", "Mobile"];
    const methodColors = ["#10b981", "#3b82f6", "#f59e0b"];
    const totalRev = tickets.reduce((s, t) => s + (Number(t.amount) || 0), 0);
    const paymentData = methods.map((m, i) => {
        const rev = tickets
            .filter(t => t.paymentMethod === m)
            .reduce((s, t) => s + (Number(t.amount) || 0), 0);
        return {
            name: m,
            value: totalRev > 0 ? Math.round((rev / totalRev) * 100) : 0,
            color: methodColors[i]
        };
    });

    const vehicleTypes = ["Car", "SUV", "Motorcycle", "Truck", "Van"];
    const vColors = ["#3b82f6", "#8b5cf6", "#10b981", "#f59e0b", "#ef4444"];
    const vehicleData = vehicleTypes.map((v, i) => {
        const tks = tickets.filter(t => t.vehicleType === v);
        return {
            type: v,
            revenue: tks.reduce((s, t) => s + (Number(t.amount) || 0), 0),
            count: tks.length,
            color: vColors[i]
        };
    });

    const hourlyLabels = ["6am", "7am", "8am", "9am", "10am", "11am", "12pm", "1pm", "2pm", "3pm", "4pm", "5pm", "6pm", "7pm", "8pm"];
    const hourlyData = hourlyLabels.map((h, i) => {
        const hour = i + 6; // starts from 6am
        return {
            hour: h,
            revenue: tickets
                .filter(t => t.exitTime && new Date(t.exitTime).getHours() === hour)
                .reduce((s, t) => s + (Number(t.amount) || 0), 0)
        };
    });

    // Destroy existing charts if any
    Object.values(charts).forEach(c => c.destroy());

    Chart.defaults.color = colors.text;
    Chart.defaults.font.family = 'ui-sans-serif, system-ui';

    // 1. Monthly Revenue Area Chart
    charts.monthly = new Chart(document.getElementById('monthlyChart'), {
        type: 'line',
        data: {
            labels: monthlyData.map(m => m.month),
            datasets: [{
                label: 'Monthly Revenue',
                data: monthlyData.map(m => m.revenue),
                borderColor: colors.primary,
                backgroundColor: colors.area,
                fill: true,
                tension: 0.4,
                pointRadius: 0,
                pointHoverRadius: 4,
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                x: { grid: { display: false }, border: { display: false } },
                y: { 
                    grid: { color: colors.grid }, 
                    border: { display: false },
                    ticks: { callback: (v) => `Rs ${v.toLocaleString()}` }
                }
            }
        }
    });

    // 2. Payment Method Pie Chart
    charts.payment = new Chart(document.getElementById('paymentPieChart'), {
        type: 'doughnut',
        data: {
            labels: paymentData.map(p => p.name),
            datasets: [{
                data: paymentData.map(p => p.value),
                backgroundColor: paymentData.map(p => p.color),
                borderWidth: 0,
                hoverOffset: 4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: '65%',
            plugins: { legend: { display: false } }
        }
    });
    renderPaymentLegend(paymentData);

    // 3. Daily Revenue Bar Chart
    charts.daily = new Chart(document.getElementById('dailyBarChart'), {
        type: 'bar',
        data: {
            labels: dailyData.map(d => d.day),
            datasets: [{
                label: 'Daily Revenue',
                data: dailyData.map(d => d.revenue),
                backgroundColor: colors.primary,
                borderRadius: 6,
                barThickness: 28
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                x: { grid: { display: false }, border: { display: false } },
                y: { 
                    grid: { color: colors.grid }, 
                    border: { display: false },
                    ticks: { callback: (v) => `Rs ${v.toLocaleString()}` }
                }
            }
        }
    });

    // 4. Hourly Revenue Line Chart
    charts.hourly = new Chart(document.getElementById('hourlyLineChart'), {
        type: 'line',
        data: {
            labels: hourlyData.map(h => h.hour),
            datasets: [{
                label: 'Hourly Revenue',
                data: hourlyData.map(h => h.revenue),
                borderColor: colors.secondary,
                borderWidth: 2,
                tension: 0.4,
                pointRadius: 0,
                pointHoverRadius: 4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                x: { grid: { display: false }, border: { display: false }, ticks: { autoSkip: true, maxTicksLimit: 8 } },
                y: { 
                    grid: { color: colors.grid }, 
                    border: { display: false },
                    ticks: { callback: (v) => `Rs ${v.toLocaleString()}` }
                }
            }
        }
    });

    // 5. Vehicle Type Bar Chart (Horizontal)
    charts.vehicle = new Chart(document.getElementById('vehicleTypeChart'), {
        type: 'bar',
        data: {
            labels: vehicleData.map(v => v.type),
            datasets: [{
                label: 'Vehicle Revenue',
                data: vehicleData.map(v => v.revenue),
                backgroundColor: vehicleData.map(v => v.color),
                borderRadius: 6,
                indexAxis: 'y',
                barThickness: 18
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                y: { grid: { display: false }, border: { display: false } },
                x: { 
                    grid: { color: colors.grid }, 
                    border: { display: false },
                    ticks: { callback: (v) => `Rs ${v.toLocaleString()}` }
                }
            }
        }
    });
    renderVehicleLegend(vehicleData);
}

function renderPaymentLegend(paymentData) {
    const legend = document.getElementById('payment-legend');
    legend.innerHTML = '';
    paymentData.forEach(p => {
        const icon = p.name === "Cash" ? "banknote" : p.name === "Card" ? "credit-card" : "smartphone";
        const div = document.createElement('div');
        div.className = 'flex items-center justify-between text-xs';
        div.innerHTML = `
            <div class="flex items-center gap-2">
                <span class="w-2.5 h-2.5 rounded-full flex-shrink-0" style="background: ${p.color}"></span>
                <span class="text-gray-500 dark:text-gray-400">
                    <i data-lucide="${icon}" size="11" class="inline mr-0.5"></i> ${p.name}
                </span>
            </div>
            <span class="font-medium">${p.value}%</span>
        `;
        legend.appendChild(div);
    });
    lucide.createIcons();
}

function renderVehicleLegend(vehicleData) {
    const legend = document.getElementById('vehicle-legend');
    legend.innerHTML = '';
    vehicleData.forEach(v => {
        const div = document.createElement('div');
        div.className = 'flex items-center gap-1.5 text-xs';
        div.innerHTML = `
            <span class="w-2.5 h-2.5 rounded-full" style="background: ${v.color}"></span>
            <span class="text-gray-500 dark:text-gray-400">${v.type}</span>
            <span class="font-medium">රු ${v.revenue.toLocaleString()}</span>
            <span class="text-gray-500 dark:text-gray-400">(${v.count} tickets)</span>
        `;
        legend.appendChild(div);
    });
}

function updateChartColors() {
    const colors = getChartColors();
    Object.values(charts).forEach(chart => {
        if (chart.options.scales && chart.options.scales.x && chart.options.scales.x.grid) {
            chart.options.scales.x.grid.color = colors.grid;
        }
        if (chart.options.scales && chart.options.scales.y && chart.options.scales.y.grid) {
            chart.options.scales.y.grid.color = colors.grid;
        }
        chart.update();
    });
}
