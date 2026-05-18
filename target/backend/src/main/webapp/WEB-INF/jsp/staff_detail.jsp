<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Details - ParkPulse</title>
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
                <a href="/staff" class="text-[var(--text-sub)] hover:text-[var(--text)] transition-colors">Staff Management</a>
                <span class="text-[var(--border-med)]">/</span>
                <span class="text-[var(--text)] font-medium">Staff Member Detail</span>
            </div>
            <div class="flex items-center justify-center w-8 h-8 rounded-full bg-[#2563eb] text-white text-[12px] font-bold">
                AD
            </div>
        </header>

        <!-- Page content -->
        <main class="flex-1 overflow-hidden bg-[var(--bg)]">
            <div class="flex flex-col h-full overflow-y-auto p-7 md:p-8">
                <!-- Back button -->
                <button onclick="window.location.href='/staff'" class="flex items-center gap-2 mb-6 text-sm text-[var(--text-sub)] hover:text-[var(--text)] transition-colors">
                    <i data-lucide="arrow-left" style="width: 16px; height: 16px;"></i>
                    Back to Staff List
                </button>

                <!-- Profile Header Card -->
                <div class="rounded-xl p-6 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none mb-6">
                    <div class="flex flex-col md:flex-row items-center gap-6">
                        <div id="detail-avatar" class="flex items-center justify-center rounded-full w-[100px] h-[100px] text-white text-3xl font-bold overflow-hidden shadow-lg border-4 border-white dark:border-white/10"></div>
                        <div class="flex-1 text-center md:text-left">
                            <div class="flex flex-col md:flex-row md:items-center gap-2 md:gap-4 mb-1">
                                <h1 id="detail-name" class="text-2xl font-bold text-[var(--text)] m-0"></h1>
                                <span id="detail-status" class="px-3 py-1 rounded-full text-xs font-bold self-center md:self-auto"></span>
                            </div>
                            <p id="detail-role" class="text-[var(--text-sub)] text-lg"></p>
                        </div>
                        <div class="flex items-center gap-3" id="main-actions">
                            <button id="edit-btn" class="flex items-center gap-2 px-5 py-2.5 rounded-xl bg-[#2563eb] text-white font-semibold shadow-lg shadow-blue-500/20 hover:bg-[#1d4ed8] transition-all transform hover:-translate-y-0.5">
                                <i data-lucide="pencil" style="width: 16px; height: 16px;"></i>
                                Edit Member
                            </button>
                            <button id="delete-btn" class="flex items-center justify-center w-11 h-11 rounded-xl bg-red-500/10 text-red-600 border border-red-500/20 hover:bg-red-500/20 transition-colors">
                                <i data-lucide="trash-2" style="width: 18px; height: 18px;"></i>
                            </button>
                        </div>
                        <div class="flex items-center gap-3 hidden" id="delete-actions">
                            <span class="text-sm text-red-600 font-medium mr-2">Confirm permanent deletion?</span>
                            <button id="confirm-delete-btn" class="px-5 py-2 rounded-lg bg-red-600 text-white text-sm font-semibold hover:bg-red-700 transition-colors shadow-lg shadow-red-500/20">
                                Delete Now
                            </button>
                            <button id="cancel-delete-btn" class="px-5 py-2 rounded-lg bg-[var(--hover)] text-[var(--text)] text-sm font-semibold transition-colors">
                                Cancel
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Details Grid -->
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                    <!-- Left column -->
                    <div class="lg:col-span-2 flex flex-col gap-6">
                        <!-- Contact Info -->
                        <div class="rounded-xl bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none overflow-hidden">
                            <div class="px-6 py-4 border-b border-[var(--border)] flex items-center gap-2">
                                <i data-lucide="contact" style="width: 18px; height: 18px; color: #2563eb;"></i>
                                <h3 class="font-bold text-[var(--text)]">Contact & Information</h3>
                            </div>
                            <div class="p-6 grid grid-cols-1 sm:grid-cols-2 gap-y-6 gap-x-12">
                                <div>
                                    <p class="text-xs font-bold text-[var(--text-sub)] uppercase tracking-wider mb-2 flex items-center gap-1.5">
                                        <i data-lucide="mail" style="width: 12px; height: 12px;"></i> Email Address
                                    </p>
                                    <p id="info-email" class="text-[var(--text)] font-medium break-all"></p>
                                </div>
                                <div>
                                    <p class="text-xs font-bold text-[var(--text-sub)] uppercase tracking-wider mb-2 flex items-center gap-1.5">
                                        <i data-lucide="phone" style="width: 12px; height: 12px;"></i> Phone Number
                                    </p>
                                    <p id="info-phone" class="text-[var(--text)] font-medium"></p>
                                </div>
                                <div>
                                    <p class="text-xs font-bold text-[var(--text-sub)] uppercase tracking-wider mb-2 flex items-center gap-1.5">
                                        <i data-lucide="clock" style="width: 12px; height: 12px;"></i> Shift Timing
                                    </p>
                                    <p id="info-shift" class="text-[var(--text)] font-medium"></p>
                                </div>
                                <div>
                                    <p class="text-xs font-bold text-[var(--text-sub)] uppercase tracking-wider mb-2 flex items-center gap-1.5">
                                        <i data-lucide="calendar" style="width: 12px; height: 12px;"></i> Join Date
                                    </p>
                                    <p id="info-join-date" class="text-[var(--text)] font-medium"></p>
                                </div>
                                <div class="sm:col-span-2">
                                    <p class="text-xs font-bold text-[var(--text-sub)] uppercase tracking-wider mb-2 flex items-center gap-1.5">
                                        <i data-lucide="map-pin" style="width: 12px; height: 12px;"></i> Residential Address
                                    </p>
                                    <p id="info-address" class="text-[var(--text)] font-medium"></p>
                                </div>
                            </div>
                        </div>

                        <!-- Vehicle Details -->
                        <div class="rounded-xl bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none overflow-hidden">
                            <div class="px-6 py-4 border-b border-[var(--border)] flex items-center gap-2">
                                <i data-lucide="car" style="width: 18px; height: 18px; color: #2563eb;"></i>
                                <h3 class="font-bold text-[var(--text)]">Vehicle Information</h3>
                            </div>
                            <div class="p-6 grid grid-cols-1 sm:grid-cols-2 gap-y-6 gap-x-12">
                                <div>
                                    <p class="text-xs font-bold text-[var(--text-sub)] uppercase tracking-wider mb-2">Vehicle Number</p>
                                    <p id="info-vehicle-number" class="text-[var(--text)] font-medium bg-[var(--hover)] px-3 py-1.5 rounded-lg border border-[var(--border)] inline-block min-w-[120px]"></p>
                                </div>
                                <div>
                                    <p class="text-xs font-bold text-[var(--text-sub)] uppercase tracking-wider mb-2">Vehicle Type</p>
                                    <div class="flex items-center gap-2">
                                        <div class="w-8 h-8 rounded-full bg-blue-500/10 flex items-center justify-center text-blue-500">
                                            <i data-lucide="car-front" style="width: 14px; height: 14px;"></i>
                                        </div>
                                        <p id="info-vehicle-type" class="text-[var(--text)] font-medium"></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right column -->
                    <div class="flex flex-col gap-6">
                        <!-- Account Status -->
                        <div class="rounded-xl bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none overflow-hidden">
                            <div class="px-6 py-4 border-b border-[var(--border)]">
                                <h3 class="font-bold text-[var(--text)]">System Account</h3>
                            </div>
                            <div class="p-6">
                                <div class="mb-4">
                                    <p class="text-xs font-bold text-[var(--text-sub)] uppercase tracking-wider mb-2">Username</p>
                                    <p id="info-username" class="text-[var(--text)] font-bold text-sm bg-black/5 dark:bg-white/5 px-3 py-2 rounded-lg border border-dashed border-[var(--border-med)]"></p>
                                </div>
                                <div class="p-4 rounded-xl bg-blue-500/5 border border-blue-500/10">
                                    <div class="flex items-center gap-2 text-blue-500 mb-2">
                                        <i data-lucide="shield-check" style="width: 16px; height: 16px;"></i>
                                        <span class="text-xs font-bold uppercase">Permissions</span>
                                    </div>
                                    <p class="text-[11px] text-[var(--text-sub)]">Access limited based on the assigned role. All actions are logged within the system.</p>
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
    <script src="js/staff-data.js"></script>
    <script src="js/staff-detail-ui.js"></script>
    <script src="js/icons.js"></script>
</body>
</html>

