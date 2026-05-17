<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Revenue | ParkPulse</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            darkMode: 'class'
        }
    </script>
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
    <!-- Chart.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="css/theme.css">
    <script>
        (function() {
            const isDark = localStorage.getItem('theme') === 'dark';
            if (isDark) document.documentElement.classList.add('dark');
        })();
    </script>
    <style>
        #sidebar { transition: width 0.25s cubic-bezier(0.4, 0, 0.2, 1); }
        .sidebar-item-text { transition: opacity 0.2s, max-width 0.25s; }
        .collapsed .sidebar-item-text { opacity: 0; max-width: 0; pointer-events: none; }
        .collapsed .logo-text { opacity: 0; transform: translateX(-8px); }
        .logo-text { transition: opacity 0.2s, transform 0.2s; }
    </style>
</head>
<body class="flex h-screen w-full overflow-hidden bg-gray-50 dark:bg-gray-900 text-gray-900 dark:text-white">

    <!-- Sidebar -->
    <aside id="sidebar" class="flex-shrink-0 flex flex-col border-r border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 h-full overflow-hidden" style="width: 220px;">
        <div class="flex items-center gap-3 px-4 py-4 border-b border-gray-200 dark:border-gray-700 min-w-0">
            <button id="sidebar-toggle" class="flex-shrink-0 p-1.5 rounded-lg transition hover:bg-gray-100 dark:hover:bg-gray-700 text-gray-500 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white">
                <i data-lucide="menu" size="20"></i>
            </button>
            <div class="logo-text flex items-center gap-2 min-w-0 overflow-hidden">
                <div class="flex-shrink-0 w-7 h-7 rounded-lg bg-blue-600 flex items-center justify-center">
                    <i data-lucide="activity" size="14" class="text-white"></i>
                </div>
                <span class="font-semibold text-sm whitespace-nowrap truncate">ParkPulse</span>
            </div>
        </div>
        <nav class="flex-1 px-2 py-4 flex flex-col gap-1">
            <a href="tickets" class="flex items-center gap-3 rounded-xl text-sm transition w-full text-left overflow-hidden text-gray-500 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-700 p-[10px_12px]">
                <span class="flex-shrink-0"><i data-lucide="ticket" size="18"></i></span>
                <span class="sidebar-item-text whitespace-nowrap overflow-hidden">Tickets</span>
            </a>
            <a href="revenue" class="flex items-center gap-3 rounded-xl text-sm transition w-full text-left overflow-hidden bg-blue-600 text-white p-[10px_12px]">
                <span class="flex-shrink-0"><i data-lucide="bar-chart-2" size="18"></i></span>
                <span class="sidebar-item-text whitespace-nowrap overflow-hidden">Revenue</span>
            </a>
        </nav>
        <div class="px-2 pb-4 flex flex-col gap-1 border-t border-gray-200 dark:border-gray-700 pt-3">
            <button onclick="toggleDarkMode()" class="flex items-center gap-3 rounded-xl text-sm transition w-full overflow-hidden bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-200 hover:bg-gray-200 dark:hover:bg-gray-600 p-[9px_12px]">
                <span class="flex-shrink-0 dark:hidden"><i data-lucide="moon" size="16"></i></span>
                <span class="flex-shrink-0 hidden dark:block"><i data-lucide="sun" size="16"></i></span>
                <span class="sidebar-item-text whitespace-nowrap overflow-hidden dark:hidden">Switch to Dark</span>
                <span class="sidebar-item-text whitespace-nowrap overflow-hidden hidden dark:block">Switch to Light</span>
            </button>
            <button class="flex items-center gap-3 rounded-xl text-sm transition w-full overflow-hidden text-gray-500 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-700 p-[9px_12px]">
                <span class="flex-shrink-0"><i data-lucide="log-out" size="16"></i></span>
                <span class="sidebar-item-text whitespace-nowrap overflow-hidden">Sign Out</span>
            </button>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 flex flex-col overflow-hidden">
        <div class="flex flex-col gap-6 p-6 w-full overflow-y-auto">
            <!-- Header -->
            <div>
                <h2 class="font-semibold text-xl">Revenue</h2>
                <p class="text-sm text-gray-500 dark:text-gray-400">Financial overview of your parking facility</p>
            </div>

            <!-- KPI cards -->
            <div class="grid grid-cols-2 lg:grid-cols-4 gap-4" id="kpi-grid">
                <!-- Cards injected by JS -->
            </div>

            <!-- Monthly area chart + pie chart -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-4">
                <div class="lg:col-span-2">
                    <div class="rounded-2xl border border-gray-100 dark:border-gray-700 bg-white dark:bg-gray-800 p-5">
                        <p class="text-sm font-semibold mb-4">Monthly Revenue (2026)</p>
                        <div style="height: 220px;">
                            <canvas id="monthlyChart"></canvas>
                        </div>
                    </div>
                </div>

                <div class="rounded-2xl border border-gray-100 dark:border-gray-700 bg-white dark:bg-gray-800 p-5">
                    <p class="text-sm font-semibold mb-4">Payment Method Split</p>
                    <div style="height: 160px; margin-bottom: 20px;">
                        <canvas id="paymentPieChart"></canvas>
                    </div>
                    <div class="flex flex-col gap-2 mt-1" id="payment-legend">
                        <!-- Legend injected by JS -->
                    </div>
                </div>
            </div>

            <!-- Daily bar chart + hourly line -->
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-4">
                <div class="rounded-2xl border border-gray-100 dark:border-gray-700 bg-white dark:bg-gray-800 p-5">
                    <p class="text-sm font-semibold mb-4">Daily Revenue — This Week</p>
                    <div style="height: 200px;">
                        <canvas id="dailyBarChart"></canvas>
                    </div>
                </div>

                <div class="rounded-2xl border border-gray-100 dark:border-gray-700 bg-white dark:bg-gray-800 p-5">
                    <p class="text-sm font-semibold mb-4">Revenue by Hour (Today)</p>
                    <div style="height: 200px;">
                        <canvas id="hourlyLineChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Revenue by vehicle type -->
            <div class="rounded-2xl border border-gray-100 dark:border-gray-700 bg-white dark:bg-gray-800 p-5">
                <p class="text-sm font-semibold mb-4">Revenue by Vehicle Type</p>
                <div style="height: 200px;">
                    <canvas id="vehicleTypeChart"></canvas>
                </div>
                <!-- Legend row -->
                <div class="flex flex-wrap gap-3 mt-4" id="vehicle-legend">
                    <!-- Legend injected by JS -->
                </div>
            </div>
        </div>
    </main>

    <!-- Scripts -->
    <script src="js/core.js"></script>
    <script src="js/revenue.js"></script>
    <script>lucide.createIcons();</script>
</body>
</html>
