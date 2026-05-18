<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analytics - ParkPulse</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="css/theme.css">
    <link rel="stylesheet" href="css/globals.css">
</head>
<body class="flex h-screen w-screen overflow-hidden">
    <!-- Sidebar -->
    <aside id="sidebar" class="flex flex-col h-full flex-shrink-0 transition-all duration-200 border-r" style="width: 230px; background: var(--sidebar); border-color: var(--border);">
        <div class="flex items-center flex-shrink-0 h-[58px] border-b px-3 gap-2" style="border-color: var(--border);">
            <button onclick="toggleSidebar()" class="flex items-center justify-center w-8.5 h-8.5 rounded-lg hover:bg-[var(--hover)] text-[var(--text-sub)] hover:text-[var(--text)] transition-colors">
                <i data-lucide="menu" style="width: 18px; height: 18px;"></i>
            </button>
            <div class="flex items-center gap-2 sidebar-logo-text">
                <div class="flex items-center justify-center w-[30px] h-[30px] rounded-xl bg-[#2563eb]">
                    <i data-lucide="activity" style="width: 15px; height: 15px; color: white;"></i>
                </div>
                <span class="font-bold text-lg text-[var(--text)] whitespace-nowrap">ParkPulse</span>
            </div>
        </div>
        
        <nav class="flex-1 overflow-y-auto py-3 px-2 flex flex-col gap-1">
            <a href="/staff" class="sidebar-nav-item flex items-center gap-2.5 p-2.5 rounded-xl text-sm text-[var(--text-sub)] hover:bg-[var(--hover)] hover:text-[var(--text)]">
                <i data-lucide="users" style="width: 17px; height: 17px;"></i>
                <span class="sidebar-label">Staff</span>
            </a>
        </nav>

        <div class="flex flex-col gap-1 px-2 py-3 border-t" style="border-color: var(--border);">
            <button onclick="toggleTheme()" class="sidebar-nav-item flex items-center gap-2.5 p-2.5 rounded-xl text-sm text-[var(--text-sub)]">
                <i data-lucide="sun" class="hidden dark:block" style="width: 17px; height: 17px;"></i>
                <i data-lucide="moon" class="block dark:hidden" style="width: 17px; height: 17px;"></i>
                <span class="sidebar-label dark:hidden">Dark Mode</span>
                <span class="sidebar-label hidden dark:inline">Light Mode</span>
            </button>
            <button class="sidebar-nav-item flex items-center gap-2.5 p-2.5 rounded-xl text-sm text-[var(--text-sub)]">
                <i data-lucide="log-out" style="width: 17px; height: 17px;"></i>
                <span class="sidebar-label">Sign Out</span>
            </button>
        </div>
    </aside>

    <div class="flex flex-col flex-1 overflow-hidden">
        <!-- Top bar -->
        <header class="flex items-center justify-between px-7 h-[58px] border-b flex-shrink-0" style="background: var(--topbar); border-color: var(--border);">
            <div class="flex items-center gap-2 text-[13px]">
                <span class="text-[var(--text-sub)]">ParkPulse</span>
                <span class="text-[var(--border-med)]">/</span>
                <span class="text-[var(--text)] font-medium">Performance Analytics</span>
            </div>
            <div class="flex items-center justify-center w-8 h-8 rounded-full bg-[#2563eb] text-white text-[12px] font-bold">
                AD
            </div>
        </header>

        <!-- Page content -->
        <main class="flex-1 overflow-hidden bg-[var(--bg)]">
            <div class="flex flex-col h-full overflow-y-auto p-7 md:p-8">
                <div class="mb-6">
                    <h1 class="text-2xl font-bold text-[var(--text)] m-0">Analytics</h1>
                    <p class="text-sm text-[var(--text-sub)] mt-1">Insights and performance metrics for your parking facility.</p>
                </div>

                <!-- KPI Cards -->
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
                    <div class="rounded-xl p-5 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                        <div class="flex items-center justify-center w-[38px] h-[38px] rounded-lg mb-3" style="background: #14532d;">
                            <i data-lucide="dollar-sign" style="width: 18px; height: 18px; color: #4ade80;"></i>
                        </div>
                        <p class="text-[13px] text-[var(--text-sub)] mb-1">Weekly Revenue</p>
                        <div class="flex items-end gap-2">
                            <p class="text-[22px] font-bold text-[var(--text)]">$1,770</p>
                            <span class="text-[12px] text-[#4ade80] mb-1">+12%</span>
                        </div>
                    </div>
                    <div class="rounded-xl p-5 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                        <div class="flex items-center justify-center w-[38px] h-[38px] rounded-lg mb-3" style="background: #1e3a8a;">
                            <i data-lucide="trending-up" style="width: 18px; height: 18px; color: #60a5fa;"></i>
                        </div>
                        <p class="text-[13px] text-[var(--text-sub)] mb-1">Monthly Revenue</p>
                        <div class="flex items-end gap-2">
                            <p class="text-[22px] font-bold text-[var(--text)]">$6,200</p>
                            <span class="text-[12px] text-[#4ade80] mb-1">+8%</span>
                        </div>
                    </div>
                    <div class="rounded-xl p-5 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                        <div class="flex items-center justify-center w-[38px] h-[38px] rounded-lg mb-3" style="background: #4c1d95;">
                            <i data-lucide="car" style="width: 18px; height: 18px; color: #c084fc;"></i>
                        </div>
                        <p class="text-[13px] text-[var(--text-sub)] mb-1">Total Vehicles</p>
                        <div class="flex items-end gap-2">
                            <p class="text-[22px] font-bold text-[var(--text)]">177</p>
                            <span class="text-[12px] text-[#4ade80] mb-1">+5%</span>
                        </div>
                    </div>
                    <div class="rounded-xl p-5 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                        <div class="flex items-center justify-center w-[38px] h-[38px] rounded-lg mb-3" style="background: #7c2d12;">
                            <i data-lucide="trending-down" style="width: 18px; height: 18px; color: #fb923c;"></i>
                        </div>
                        <p class="text-[13px] text-[var(--text-sub)] mb-1">Avg Daily Rev</p>
                        <div class="flex items-end gap-2">
                            <p class="text-[22px] font-bold text-[var(--text)]">$253</p>
                            <span class="text-[12px] text-[#f87171] mb-1">-3%</span>
                        </div>
                    </div>
                </div>

                <!-- Charts -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <div class="rounded-xl p-6 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                        <h3 class="font-bold text-[var(--text)] mb-6">Weekly Vehicles & Revenue</h3>
                        <div class="h-[220px]">
                            <canvas id="weeklyChart"></canvas>
                        </div>
                    </div>

                    <div class="rounded-xl p-6 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                        <h3 class="font-bold text-[var(--text)] mb-6">Monthly Revenue Trend</h3>
                        <div class="h-[220px]">
                            <canvas id="monthlyChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="js/theme.js"></script>
    <script src="js/sidebar.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const ctx1 = document.getElementById('weeklyChart').getContext('2d');
            new Chart(ctx1, {
                type: 'bar',
                data: {
                    labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                    datasets: [{
                        label: 'Vehicles',
                        data: [18, 22, 19, 26, 30, 34, 28],
                        backgroundColor: '#2563eb',
                        borderRadius: 4
                    }, {
                        label: 'Revenue ($)',
                        data: [180, 220, 190, 260, 300, 340, 280],
                        backgroundColor: '#7c3aed',
                        borderRadius: 4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: { legend: { labels: { color: '#8b95a8' } } },
                    scales: {
                        y: { grid: { color: 'rgba(255,255,255,0.05)' }, ticks: { color: '#8b95a8' } },
                        x: { grid: { display: false }, ticks: { color: '#8b95a8' } }
                    }
                }
            });

            const ctx2 = document.getElementById('monthlyChart').getContext('2d');
            new Chart(ctx2, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                    datasets: [{
                        label: 'Revenue ($)',
                        data: [4200, 3800, 5100, 4700, 5600, 6200],
                        borderColor: '#22c55e',
                        backgroundColor: 'rgba(34,197,94,0.1)',
                        fill: true,
                        tension: 0.4,
                        borderWidth: 2.5,
                        pointRadius: 4,
                        pointBackgroundColor: '#22c55e'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: { legend: { labels: { color: '#8b95a8' } } },
                    scales: {
                        y: { grid: { color: 'rgba(255,255,255,0.05)' }, ticks: { color: '#8b95a8' } },
                        x: { grid: { display: false }, ticks: { color: '#8b95a8' } }
                    }
                }
            });
        });
    </script>
    <script src="js/icons.js"></script>
</body>
</html>

