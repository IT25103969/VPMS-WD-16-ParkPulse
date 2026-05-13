// Mock Data
const growthData = [
    { month: "Nov", total: 42, active: 36, inactive: 6 },
    { month: "Dec", total: 48, active: 41, inactive: 7 },
    { month: "Jan", total: 54, active: 46, inactive: 8 },
    { month: "Feb", total: 61, active: 52, inactive: 9 },
    { month: "Mar", total: 68, active: 58, inactive: 10 },
    { month: "Apr", total: 74, active: 63, inactive: 11 },
    { month: "May", total: 80, active: 68, inactive: 12 },
];

const planData = [
    { name: "Monthly", value: 38, color: "#4ade80" },
    { name: "Quarterly", value: 27, color: "#2dd4bf" },
    { name: "Annual", value: 35, color: "#86efac" },
];

const retentionData = [
    { month: "Nov", rate: 82 },
    { month: "Dec", rate: 85 },
    { month: "Jan", rate: 87 },
    { month: "Feb", rate: 84 },
    { month: "Mar", rate: 89 },
    { month: "Apr", rate: 91 },
    { month: "May", rate: 93 },
];

const revenueData = [
    { month: "Nov", revenue: 3240 },
    { month: "Dec", revenue: 3780 },
    { month: "Jan", revenue: 4120 },
    { month: "Feb", revenue: 4560 },
    { month: "Mar", revenue: 4890 },
    { month: "Apr", revenue: 5230 },
    { month: "May", revenue: 5780 },
];

let range = "6M";
const rangeSlice = { "6M": 7, "3M": 4, "1M": 2 };

// Chart Instances
let growthChart, planChart, retentionChart, revenueChart;

function init() {
    initCharts();
    setupRangeSelector();
}

function initCharts() {
    const isDark = document.body.classList.contains('dark');
    const textColor = isDark ? '#f0fdf4' : '#0f172a';
    const gridColor = isDark ? 'rgba(74,222,128,0.05)' : 'rgba(0,0,0,0.05)';

    // Growth Chart
    const growthCtx = document.getElementById('growthChart').getContext('2d');
    growthChart = new Chart(growthCtx, {
        type: 'line',
        data: {
            labels: growthData.map(d => d.month),
            datasets: [
                {
                    label: 'Total',
                    data: growthData.map(d => d.total),
                    borderColor: '#22c55e',
                    backgroundColor: 'rgba(34,197,94,0.1)',
                    fill: true,
                    tension: 0.4
                },
                {
                    label: 'Active',
                    data: growthData.map(d => d.active),
                    borderColor: '#4ade80',
                    backgroundColor: 'rgba(74,222,128,0.1)',
                    fill: true,
                    tension: 0.4
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                x: { grid: { display: false }, ticks: { color: textColor, font: { size: 10 } } },
                y: { grid: { color: gridColor }, ticks: { color: textColor, font: { size: 10 } } }
            }
        }
    });

    // Plan Chart
    const planCtx = document.getElementById('planChart').getContext('2d');
    planChart = new Chart(planCtx, {
        type: 'doughnut',
        data: {
            labels: planData.map(d => d.name),
            datasets: [{
                data: planData.map(d => d.value),
                backgroundColor: planData.map(d => d.color),
                borderWidth: 0
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: '70%',
            plugins: { legend: { display: false } }
        }
    });

    renderPlanLegend();

    // Retention Chart
    const retentionCtx = document.getElementById('retentionChart').getContext('2d');
    retentionChart = new Chart(retentionCtx, {
        type: 'bar',
        data: {
            labels: retentionData.map(d => d.month),
            datasets: [{
                label: 'Retention %',
                data: retentionData.map(d => d.rate),
                backgroundColor: '#16a34a',
                borderRadius: 6
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                x: { grid: { display: false }, ticks: { color: textColor, font: { size: 10 } } },
                y: { min: 70, max: 100, grid: { color: gridColor }, ticks: { color: textColor, font: { size: 10 } } }
            }
        }
    });

    // Revenue Chart
    const revenueCtx = document.getElementById('revenueChart').getContext('2d');
    revenueChart = new Chart(revenueCtx, {
        type: 'line',
        data: {
            labels: revenueData.map(d => d.month),
            datasets: [{
                label: 'Revenue',
                data: revenueData.map(d => d.revenue),
                borderColor: '#f59e0b',
                backgroundColor: 'rgba(245,158,11,0.1)',
                fill: true,
                tension: 0.4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                x: { grid: { display: false }, ticks: { color: textColor, font: { size: 10 } } },
                y: { grid: { color: gridColor }, ticks: { color: textColor, font: { size: 10 }, callback: v => '$' + v/1000 + 'K' } }
            }
        }
    });
}

function renderPlanLegend() {
    const legend = document.getElementById('plan-legend');
    legend.innerHTML = planData.map(p => `
        <div class="flex items-center justify-between">
            <div class="flex items-center gap-2">
                <span class="w-2.5 h-2.5 rounded-full" style="background: ${p.color}"></span>
                <span class="text-xs text-sidebar-foreground/60">${p.name}</span>
            </div>
            <span class="text-xs font-semibold text-foreground">${p.value}%</span>
        </div>
    `).join('');
}

function setupRangeSelector() {
    document.querySelectorAll('.range-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.range-btn').forEach(b => {
                b.classList.remove('active', 'bg-gradient-to-br', 'from-green-600', 'to-green-500', 'text-white', 'shadow-md', 'shadow-green-500/20');
                b.classList.add('text-sidebar-foreground/60', 'hover:text-green-500');
            });
            btn.classList.add('active', 'bg-gradient-to-br', 'from-green-600', 'to-green-500', 'text-white', 'shadow-md', 'shadow-green-500/20');
            btn.classList.remove('text-sidebar-foreground/60', 'hover:text-green-500');
            
            updateRange(btn.getAttribute('data-range'));
        });
    });
}

function updateRange(newRange) {
    range = newRange;
    const slice = rangeSlice[range];
    
    growthChart.data.labels = growthData.slice(-slice).map(d => d.month);
    growthChart.data.datasets[0].data = growthData.slice(-slice).map(d => d.total);
    growthChart.data.datasets[1].data = growthData.slice(-slice).map(d => d.active);
    growthChart.update();

    retentionChart.data.labels = retentionData.slice(-slice).map(d => d.month);
    retentionChart.data.datasets[0].data = retentionData.slice(-slice).map(d => d.rate);
    retentionChart.update();

    revenueChart.data.labels = revenueData.slice(-slice).map(d => d.month);
    revenueChart.data.datasets[0].data = revenueData.slice(-slice).map(d => d.revenue);
    revenueChart.update();
}

// Start
init();
