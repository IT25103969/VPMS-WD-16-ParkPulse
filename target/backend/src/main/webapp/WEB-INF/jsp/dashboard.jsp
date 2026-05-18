<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - ParkPulse</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
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
                <span class="text-[var(--text)] font-medium">Overview Dashboard</span>
            </div>
            <div class="flex items-center justify-center w-8 h-8 rounded-full bg-[#2563eb] text-white text-[12px] font-bold">
                AD
            </div>
        </header>

        <!-- Page content -->
        <main class="flex-1 overflow-hidden bg-[var(--bg)]">
            <div class="flex flex-col h-full overflow-y-auto p-7 md:p-8">
                <!-- Header -->
                <div class="flex items-start justify-between mb-6">
                    <div>
                        <h1 class="text-2xl font-bold text-[var(--text)] m-0">Overview Dashboard</h1>
                        <p class="text-sm text-[var(--text-sub)] mt-1">Manage your parking facility with ease.</p>
                    </div>
                    <button class="flex items-center gap-2 px-4 py-2 rounded-lg bg-[#2563eb] text-white text-sm font-medium hover:bg-[#1d4ed8] transition-colors">
                        <i data-lucide="plus-circle" style="width: 16px; height: 16px;"></i>
                        New Entry
                    </button>
                </div>

                <!-- Stats Cards -->
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
                    <div class="rounded-xl p-5 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                        <div class="flex items-center justify-center w-[38px] h-[38px] rounded-lg mb-3" style="background: #1e3a8a;">
                            <i data-lucide="parking-square" style="width: 18px; height: 18px; color: #60a5fa;"></i>
                        </div>
                        <p class="text-[13px] text-[var(--text-sub)] mb-1">Total Slots</p>
                        <p class="text-[22px] font-bold text-[var(--text)]">34</p>
                    </div>
                    <div class="rounded-xl p-5 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                        <div class="flex items-center justify-center w-[38px] h-[38px] rounded-lg mb-3" style="background: #7c2d12;">
                            <i data-lucide="users" style="width: 18px; height: 18px; color: #fb923c;"></i>
                        </div>
                        <p class="text-[13px] text-[var(--text-sub)] mb-1">Occupied</p>
                        <p class="text-[22px] font-bold text-[var(--text)]">0 / 34</p>
                    </div>
                    <div class="rounded-xl p-5 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                        <div class="flex items-center justify-center w-[38px] h-[38px] rounded-lg mb-3" style="background: #14532d;">
                            <i data-lucide="dollar-sign" style="width: 18px; height: 18px; color: #4ade80;"></i>
                        </div>
                        <p class="text-[13px] text-[var(--text-sub)] mb-1">Daily Revenue</p>
                        <p class="text-[22px] font-bold text-[var(--text)]">$20.00</p>
                    </div>
                    <div class="rounded-xl p-5 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                        <div class="flex items-center justify-center w-[38px] h-[38px] rounded-lg mb-3" style="background: #4c1d95;">
                            <i data-lucide="clock" style="width: 18px; height: 18px; color: #c084fc;"></i>
                        </div>
                        <p class="text-[13px] text-[var(--text-sub)] mb-1">Hourly Rate</p>
                        <p class="text-[22px] font-bold text-[var(--text)]">$10.00</p>
                    </div>
                </div>

                <!-- Bottom Row -->
                <div class="grid grid-cols-1 lg:grid-cols-[1fr_340px] gap-6">
                    <!-- Live Parking Map -->
                    <div class="rounded-xl p-6 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                        <h3 class="font-bold text-[var(--text)] mb-4">Live Parking Map</h3>
                        <div id="parking-map" class="flex flex-wrap gap-2">
                            <!-- JS Inject -->
                        </div>
                        <div class="flex items-center gap-4 mt-6">
                            <div class="flex items-center gap-1.5">
                                <div class="w-3 h-3 rounded bg-[#22c55e]"></div>
                                <span class="text-xs text-[var(--text-sub)]">Available</span>
                            </div>
                            <div class="flex items-center gap-1.5">
                                <div class="w-3 h-3 rounded bg-[#ef4444]"></div>
                                <span class="text-xs text-[var(--text-sub)]">Occupied</span>
                            </div>
                        </div>
                    </div>

                    <!-- Live Entry Feed -->
                    <div class="rounded-xl p-6 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none flex flex-col">
                        <h3 class="font-bold text-[var(--text)] mb-4">Live Entry Feed</h3>
                        <div class="flex items-center justify-center rounded-lg bg-black/5 dark:bg-white/5 h-[120px] text-sm text-[var(--text-sub)]">
                            No active sessions
                        </div>
                        <div class="mt-6">
                            <p class="text-xs font-bold text-[var(--text-sub)] uppercase tracking-wider mb-3">Recent Activity</p>
                            <div class="space-y-3">
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center gap-2">
                                        <div class="w-2 h-2 rounded-full bg-[#22c55e]"></div>
                                        <span class="text-sm text-[var(--text)]">Slot A5</span>
                                    </div>
                                    <div class="flex items-center gap-2">
                                        <span class="text-[11px] font-medium px-1.5 py-0.5 rounded bg-green-500/15 text-green-500">Entry</span>
                                        <span class="text-xs text-[var(--text-sub)]">09:15 AM</span>
                                    </div>
                                </div>
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center gap-2">
                                        <div class="w-2 h-2 rounded-full bg-[#ef4444]"></div>
                                        <span class="text-sm text-[var(--text)]">Slot A12</span>
                                    </div>
                                    <div class="flex items-center gap-2">
                                        <span class="text-[11px] font-medium px-1.5 py-0.5 rounded bg-red-500/15 text-red-500">Exit</span>
                                        <span class="text-xs text-[var(--text-sub)]">08:42 AM</span>
                                    </div>
                                </div>
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center gap-2">
                                        <div class="w-2 h-2 rounded-full bg-[#22c55e]"></div>
                                        <span class="text-sm text-[var(--text)]">Slot A3</span>
                                    </div>
                                    <div class="flex items-center gap-2">
                                        <span class="text-[11px] font-medium px-1.5 py-0.5 rounded bg-green-500/15 text-green-500">Entry</span>
                                        <span class="text-xs text-[var(--text-sub)]">08:10 AM</span>
                                    </div>
                                </div>
                            </div>
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
            const map = document.getElementById('parking-map');
            for (let i = 1; i <= 34; i++) {
                const slot = document.createElement('div');
                slot.className = 'flex items-center justify-center rounded-lg cursor-pointer transition-all hover:opacity-80 w-[52px] h-[36px] bg-[#22c55e] text-white text-[12px] font-bold';
                slot.innerText = 'A' + i;
                map.appendChild(slot);
            }
        });
    </script>
    <script src="js/icons.js"></script>
</body>
</html>

