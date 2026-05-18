<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Settings - ParkPulse</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link rel="stylesheet" href="css/theme.css">
    <link rel="stylesheet" href="css/globals.css">
    <style>
        .switch { width: 44px; height: 24px; border-radius: 12px; position: relative; transition: background 0.2s; cursor: pointer; border: none; }
        .switch-thumb { position: absolute; top: 3px; left: 3px; width: 18px; height: 18px; border-radius: 50%; background: #fff; transition: left 0.2s; }
        .switch.active { background: #2563eb !important; }
        .switch.active .switch-thumb { left: 23px; }
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
                <span class="text-[var(--text)] font-medium">System Settings</span>
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
                        <h1 class="text-2xl font-bold text-[var(--text)] m-0">Settings</h1>
                        <p class="text-sm text-[var(--text-sub)] mt-1">Configure your parking facility preferences.</p>
                    </div>
                    <button id="save-btn" onclick="handleSave()" class="flex items-center gap-2 px-4 py-2 rounded-lg bg-[#2563eb] text-white text-sm font-medium hover:bg-[#1d4ed8] transition-all">
                        <i data-lucide="save" style="width: 16px; height: 16px;"></i>
                        <span id="save-text">Save Changes</span>
                    </button>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Facility Info -->
                    <div class="rounded-xl p-6 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                        <div class="flex items-center gap-3 mb-6">
                            <div class="flex items-center justify-center rounded-lg w-9 h-9" style="background: #1e3a8a;">
                                <i data-lucide="building-2" style="width: 16px; height: 16px; color: #60a5fa;"></i>
                            </div>
                            <h3 class="font-bold text-[var(--text)] m-0">Facility Info</h3>
                        </div>
                        <div class="space-y-4">
                            <div>
                                <label class="block text-[11px] font-bold text-[var(--text-sub)] uppercase tracking-wider mb-2">Facility Name</label>
                                <input type="text" value="ParkPulse Main Lot" class="w-full px-4 py-2 rounded-lg bg-black/5 dark:bg-white/5 border border-[var(--border)] text-[var(--text)] text-sm outline-none focus:border-[#2563eb] transition-all">
                            </div>
                            <div>
                                <label class="block text-[11px] font-bold text-[var(--text-sub)] uppercase tracking-wider mb-2">Address</label>
                                <input type="text" value="123 Parking Ave, City, ST 00000" class="w-full px-4 py-2 rounded-lg bg-black/5 dark:bg-white/5 border border-[var(--border)] text-[var(--text)] text-sm outline-none focus:border-[#2563eb] transition-all">
                            </div>
                            <div>
                                <label class="block text-[11px] font-bold text-[var(--text-sub)] uppercase tracking-wider mb-2">Contact Email</label>
                                <input type="email" value="admin@parkpulse.com" class="w-full px-4 py-2 rounded-lg bg-black/5 dark:bg-white/5 border border-[var(--border)] text-[var(--text)] text-sm outline-none focus:border-[#2563eb] transition-all">
                            </div>
                        </div>
                    </div>

                    <!-- Pricing -->
                    <div class="rounded-xl p-6 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                        <div class="flex items-center gap-3 mb-6">
                            <div class="flex items-center justify-center rounded-lg w-9 h-9" style="background: #14532d;">
                                <i data-lucide="dollar-sign" style="width: 16px; height: 16px; color: #4ade80;"></i>
                            </div>
                            <h3 class="font-bold text-[var(--text)] m-0">Pricing</h3>
                        </div>
                        <div class="space-y-4">
                            <div>
                                <label class="block text-[11px] font-bold text-[var(--text-sub)] uppercase tracking-wider mb-2">Hourly Rate ($)</label>
                                <input type="number" value="10" class="w-full px-4 py-2 rounded-lg bg-black/5 dark:bg-white/5 border border-[var(--border)] text-[var(--text)] text-sm outline-none focus:border-[#2563eb] transition-all">
                            </div>
                            <div>
                                <label class="block text-[11px] font-bold text-[var(--text-sub)] uppercase tracking-wider mb-2">Daily Rate ($)</label>
                                <input type="number" value="20" class="w-full px-4 py-2 rounded-lg bg-black/5 dark:bg-white/5 border border-[var(--border)] text-[var(--text)] text-sm outline-none focus:border-[#2563eb] transition-all">
                            </div>
                            <div>
                                <label class="block text-[11px] font-bold text-[var(--text-sub)] uppercase tracking-wider mb-2">Monthly Pass ($)</label>
                                <input type="number" value="150" class="w-full px-4 py-2 rounded-lg bg-black/5 dark:bg-white/5 border border-[var(--border)] text-[var(--text)] text-sm outline-none focus:border-[#2563eb] transition-all">
                            </div>
                        </div>
                    </div>

                    <!-- Notifications -->
                    <div class="rounded-xl p-6 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                        <div class="flex items-center gap-3 mb-6">
                            <div class="flex items-center justify-center rounded-lg w-9 h-9" style="background: #4c1d95;">
                                <i data-lucide="bell" style="width: 16px; height: 16px; color: #c084fc;"></i>
                            </div>
                            <h3 class="font-bold text-[var(--text)] m-0">Notifications</h3>
                        </div>
                        <div class="space-y-6">
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-sm font-medium text-[var(--text)]">Email Notifications</p>
                                    <p class="text-xs text-[var(--text-sub)]">Get alerts via email for new entries</p>
                                </div>
                                <button onclick="this.classList.toggle('active')" class="switch active bg-black/15 dark:bg-white/15">
                                    <div class="switch-thumb"></div>
                                </button>
                            </div>
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="text-sm font-medium text-[var(--text)]">Auto-Assign Slots</p>
                                    <p class="text-xs text-[var(--text-sub)]">Automatically assign available slots</p>
                                </div>
                                <button onclick="this.classList.toggle('active')" class="switch active bg-black/15 dark:bg-white/15">
                                    <div class="switch-thumb"></div>
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Slot Config -->
                    <div class="rounded-xl p-6 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                        <div class="flex items-center gap-3 mb-6">
                            <div class="flex items-center justify-center rounded-lg w-9 h-9" style="background: #7c2d12;">
                                <i data-lucide="parking-square" style="width: 16px; height: 16px; color: #fb923c;"></i>
                            </div>
                            <h3 class="font-bold text-[var(--text)] m-0">Slot Configuration</h3>
                        </div>
                        <div class="space-y-4">
                            <div>
                                <label class="block text-[11px] font-bold text-[var(--text-sub)] uppercase tracking-wider mb-2">Total Slots</label>
                                <input type="number" value="34" class="w-full px-4 py-2 rounded-lg bg-black/5 dark:bg-white/5 border border-[var(--border)] text-[var(--text)] text-sm outline-none focus:border-[#2563eb] transition-all">
                            </div>
                            <div>
                                <label class="block text-[11px] font-bold text-[var(--text-sub)] uppercase tracking-wider mb-2">Reserved Slots</label>
                                <input type="number" value="4" class="w-full px-4 py-2 rounded-lg bg-black/5 dark:bg-white/5 border border-[var(--border)] text-[var(--text)] text-sm outline-none focus:border-[#2563eb] transition-all">
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
        function handleSave() {
            const btn = document.getElementById('save-btn');
            const text = document.getElementById('save-text');
            const oldBg = btn.style.background;
            
            btn.style.background = '#22c55e';
            text.innerText = 'Saved!';
            
            setTimeout(() => {
                btn.style.background = '#2563eb';
                text.innerText = 'Save Changes';
            }, 2000);
        }
    </script>
    <script src="js/icons.js"></script>
</body>
</html>

