<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Management - ParkPulse</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link rel="stylesheet" href="css/theme.css">
    <link rel="stylesheet" href="css/globals.css">
    <style>
        .sidebar-nav-item:hover { background: var(--hover); color: var(--text); }
        .tab-btn:hover { background: var(--hover); }
        .staff-card:hover { border-color: rgba(37,99,235,0.4) !important; box-shadow: 0 2px 8px rgba(37,99,235,0.1); }
        .dark .staff-card:hover { box-shadow: none; }
    </style>
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
            <a href="/staff" class="sidebar-nav-item flex items-center gap-2.5 p-2.5 rounded-xl text-sm font-semibold bg-[#2563eb] text-white">
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
                <span class="text-[var(--text)] font-medium">Staff Management</span>
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
                        <h1 class="text-2xl font-bold text-[var(--text)] m-0">Staff Management</h1>
                        <p class="text-sm text-[var(--text-sub)] mt-0.5">Manage your parking facility staff members.</p>
                    </div>
                    <button onclick="window.location.href='/staff_form'" class="flex items-center gap-2 px-4 py-2 rounded-lg bg-[#2563eb] text-white text-sm font-medium hover:bg-[#1d4ed8] transition-colors">
                        <i data-lucide="plus-circle" style="width: 16px; height: 16px;"></i>
                        Add Staff
                    </button>
                </div>

                <!-- Stats Cards -->
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
                    <div class="rounded-xl p-5 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                        <div class="flex items-center justify-center w-[38px] h-[38px] rounded-lg mb-3 bg-[var(--stat-blue)]">
                            <i data-lucide="users" style="width: 18px; height: 18px; color: #2563eb;"></i>
                        </div>
                        <p class="text-[13px] text-[var(--text-sub)] mb-1">Total Staff</p>
                        <p id="stat-total" class="text-[22px] font-bold text-[var(--text)]">0</p>
                    </div>
                    <div class="rounded-xl p-5 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                        <div class="flex items-center justify-center w-[38px] h-[38px] rounded-lg mb-3 bg-[var(--stat-green)]">
                            <i data-lucide="user-check" style="width: 18px; height: 18px; color: #16a34a;"></i>
                        </div>
                        <p class="text-[13px] text-[var(--text-sub)] mb-1">Active Now</p>
                        <p id="stat-active" class="text-[22px] font-bold text-[var(--text)]">0</p>
                    </div>
                    <div class="rounded-xl p-5 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                        <div class="flex items-center justify-center w-[38px] h-[38px] rounded-lg mb-3 bg-[var(--stat-orange)]">
                            <i data-lucide="user-x" style="width: 18px; height: 18px; color: #ea580c;"></i>
                        </div>
                        <p class="text-[13px] text-[var(--text-sub)] mb-1">Off Duty</p>
                        <p id="stat-offduty" class="text-[22px] font-bold text-[var(--text)]">0</p>
                    </div>
                    <div class="rounded-xl p-5 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                        <div class="flex items-center justify-center w-[38px] h-[38px] rounded-lg mb-3 bg-[var(--stat-purple)]">
                            <i data-lucide="clock" style="width: 18px; height: 18px; color: #7c3aed;"></i>
                        </div>
                        <p class="text-[13px] text-[var(--text-sub)] mb-1">Avg Shift Hrs</p>
                        <p class="text-[22px] font-bold text-[var(--text)]">8h</p>
                    </div>
                </div>

                <!-- Staff List Panel -->
                <div class="rounded-xl bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none overflow-hidden flex-1 flex flex-col">
                    <div class="flex items-center justify-between px-5 py-4 border-b border-[var(--border)] flex-shrink-0">
                        <div class="flex items-center gap-3">
                            <h3 class="font-bold text-[var(--text)] m-0">Staff List</h3>
                            <div class="flex items-center gap-1 bg-black/5 dark:bg-white/5 rounded-lg p-0.5">
                                <button onclick="setTab('all')" data-tab="all" class="tab-btn px-2.5 py-1 rounded-md text-[12px] transition-colors bg-[#2563eb] text-white font-semibold">All</button>
                                <button onclick="setTab('active')" data-tab="active" class="tab-btn px-2.5 py-1 rounded-md text-[12px] transition-colors text-[var(--text-sub)]">Active</button>
                                <button onclick="setTab('offduty')" data-tab="offduty" class="tab-btn px-2.5 py-1 rounded-md text-[12px] transition-colors text-[var(--text-sub)]">Off Duty</button>
                            </div>
                        </div>
                        <div class="flex items-center gap-2 px-3 py-2 rounded-lg bg-[var(--input-bg)] border border-[var(--border-med)]">
                            <i data-lucide="search" style="width: 13px; height: 13px; color: var(--text-sub);"></i>
                            <input id="staff-search" type="text" placeholder="Search staff..." class="bg-transparent border-none outline-none text-[var(--text)] text-[13px] w-36">
                        </div>
                    </div>

                    <div class="p-4 overflow-y-auto flex-1">
                        <div id="staff-grid" class="grid gap-3 grid-cols-[repeat(auto-fill,minmax(220px,1fr))]">
                            <!-- JS Inject -->
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="js/theme.js"></script>
    <script src="js/sidebar.js"></script>
    <script src="js/staff-data.js"></script>
    <script src="js/staff-ui.js"></script>
    <script src="js/icons.js"></script>
</body>
</html>

