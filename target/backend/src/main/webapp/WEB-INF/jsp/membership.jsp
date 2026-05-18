<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Membership - ParkPulse</title>
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
                <span class="text-[var(--text)] font-medium">Membership Management</span>
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
                        <h1 class="text-2xl font-bold text-[var(--text)] m-0">Membership</h1>
                        <p class="text-sm text-[var(--text-sub)] mt-1">Manage membership plans and subscribers.</p>
                    </div>
                    <button class="flex items-center gap-2 px-4 py-2 rounded-lg bg-[#2563eb] text-white text-sm font-medium hover:bg-[#1d4ed8] transition-colors">
                        <i data-lucide="plus-circle" style="width: 16px; height: 16px;"></i>
                        New Member
                    </button>
                </div>

                <!-- Plans -->
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                    <!-- Basic -->
                    <div class="rounded-xl p-5 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none relative">
                        <div class="flex items-center gap-3 mb-4">
                            <div class="flex items-center justify-center rounded-lg w-9 h-9" style="background: #1e3a8a;">
                                <i data-lucide="star" style="width: 16px; height: 16px; color: #60a5fa;"></i>
                            </div>
                            <div>
                                <p class="text-[var(--text)] font-bold">Basic</p>
                                <p class="text-[var(--text-sub)] text-xs">24 members</p>
                            </div>
                        </div>
                        <p class="text-[#2563eb] text-[22px] font-bold mb-3">$30/mo</p>
                        <ul class="space-y-1.5">
                            <li class="flex items-center gap-2">
                                <div class="w-1.5 h-1.5 rounded-full bg-[#2563eb]"></div>
                                <span class="text-[13px] text-[var(--text-sub)]">10 entries/month</span>
                            </li>
                            <li class="flex items-center gap-2">
                                <div class="w-1.5 h-1.5 rounded-full bg-[#2563eb]"></div>
                                <span class="text-[13px] text-[var(--text-sub)]">Standard slots</span>
                            </li>
                            <li class="flex items-center gap-2">
                                <div class="w-1.5 h-1.5 rounded-full bg-[#2563eb]"></div>
                                <span class="text-[13px] text-[var(--text-sub)]">Email support</span>
                            </li>
                        </ul>
                    </div>
                    <!-- Pro -->
                    <div class="rounded-xl p-5 bg-[var(--card)] border border-[#2563eb] shadow-md dark:shadow-none relative">
                        <span class="absolute top-3 right-3 bg-[#7c3aed] text-white text-[10px] px-2 py-0.5 rounded-full font-bold">POPULAR</span>
                        <div class="flex items-center gap-3 mb-4">
                            <div class="flex items-center justify-center rounded-lg w-9 h-9" style="background: #4c1d95;">
                                <i data-lucide="shield" style="width: 16px; height: 16px; color: #c084fc;"></i>
                            </div>
                            <div>
                                <p class="text-[var(--text)] font-bold">Pro</p>
                                <p class="text-[var(--text-sub)] text-xs">12 members</p>
                            </div>
                        </div>
                        <p class="text-[#2563eb] text-[22px] font-bold mb-3">$60/mo</p>
                        <ul class="space-y-1.5">
                            <li class="flex items-center gap-2">
                                <div class="w-1.5 h-1.5 rounded-full bg-[#2563eb]"></div>
                                <span class="text-[13px] text-[var(--text-sub)]">Unlimited entries</span>
                            </li>
                            <li class="flex items-center gap-2">
                                <div class="w-1.5 h-1.5 rounded-full bg-[#2563eb]"></div>
                                <span class="text-[13px] text-[var(--text-sub)]">Reserved slots</span>
                            </li>
                            <li class="flex items-center gap-2">
                                <div class="w-1.5 h-1.5 rounded-full bg-[#2563eb]"></div>
                                <span class="text-[13px] text-[var(--text-sub)]">Priority support</span>
                            </li>
                            <li class="flex items-center gap-2">
                                <div class="w-1.5 h-1.5 rounded-full bg-[#2563eb]"></div>
                                <span class="text-[13px] text-[var(--text-sub)]">Analytics</span>
                            </li>
                        </ul>
                    </div>
                    <!-- Enterprise -->
                    <div class="rounded-xl p-5 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none relative">
                        <div class="flex items-center gap-3 mb-4">
                            <div class="flex items-center justify-center rounded-lg w-9 h-9" style="background: #14532d;">
                                <i data-lucide="zap" style="width: 16px; height: 16px; color: #4ade80;"></i>
                            </div>
                            <div>
                                <p class="text-[var(--text)] font-bold">Enterprise</p>
                                <p class="text-[var(--text-sub)] text-xs">5 members</p>
                            </div>
                        </div>
                        <p class="text-[#2563eb] text-[22px] font-bold mb-3">$120/mo</p>
                        <ul class="space-y-1.5">
                            <li class="flex items-center gap-2">
                                <div class="w-1.5 h-1.5 rounded-full bg-[#2563eb]"></div>
                                <span class="text-[13px] text-[var(--text-sub)]">Unlimited entries</span>
                            </li>
                            <li class="flex items-center gap-2">
                                <div class="w-1.5 h-1.5 rounded-full bg-[#2563eb]"></div>
                                <span class="text-[13px] text-[var(--text-sub)]">Premium slots</span>
                            </li>
                            <li class="flex items-center gap-2">
                                <div class="w-1.5 h-1.5 rounded-full bg-[#2563eb]"></div>
                                <span class="text-[13px] text-[var(--text-sub)]">24/7 support</span>
                            </li>
                            <li class="flex items-center gap-2">
                                <div class="w-1.5 h-1.5 rounded-full bg-[#2563eb]"></div>
                                <span class="text-[13px] text-[var(--text-sub)]">Full analytics</span>
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Members Table -->
                <div class="rounded-xl bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none overflow-hidden">
                    <div class="px-5 py-4 border-b border-[var(--border)]">
                        <h3 class="font-bold text-[var(--text)] m-0">Active Members</h3>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full text-left border-collapse">
                            <thead>
                                <tr class="bg-black/5 dark:bg-white/5">
                                    <th class="px-5 py-3 text-[11px] font-bold text-[var(--text-sub)] uppercase tracking-wider">Member</th>
                                    <th class="px-5 py-3 text-[11px] font-bold text-[var(--text-sub)] uppercase tracking-wider">Plan</th>
                                    <th class="px-5 py-3 text-[11px] font-bold text-[var(--text-sub)] uppercase tracking-wider">License Plate</th>
                                    <th class="px-5 py-3 text-[11px] font-bold text-[var(--text-sub)] uppercase tracking-wider">Expiry</th>
                                    <th class="px-5 py-3 text-[11px] font-bold text-[var(--text-sub)] uppercase tracking-wider">Status</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-[var(--border)]">
                                <tr>
                                    <td class="px-5 py-4">
                                        <div class="flex items-center gap-3">
                                            <div class="flex items-center justify-center rounded-full w-8 h-8 bg-[#2563eb] text-white text-[11px] font-bold">JC</div>
                                            <span class="text-sm font-medium text-[var(--text)]">James Carter</span>
                                        </div>
                                    </td>
                                    <td class="px-5 py-4 text-[13px] text-[var(--text-sub)] font-medium">Pro</td>
                                    <td class="px-5 py-4">
                                        <span class="px-2 py-1 rounded bg-black/5 dark:bg-white/5 border border-[var(--border)] text-[var(--text-sub)] text-xs font-mono">ABC-1234</span>
                                    </td>
                                    <td class="px-5 py-4 text-[13px] text-[var(--text-sub)] font-medium">2025-12-31</td>
                                    <td class="px-5 py-4">
                                        <span class="px-2.5 py-0.5 rounded-full text-xs font-bold bg-green-500/15 text-green-500">Active</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="px-5 py-4">
                                        <div class="flex items-center gap-3">
                                            <div class="flex items-center justify-center rounded-full w-8 h-8 bg-[#2563eb] text-white text-[11px] font-bold">SM</div>
                                            <span class="text-sm font-medium text-[var(--text)]">Sarah Mitchell</span>
                                        </div>
                                    </td>
                                    <td class="px-5 py-4 text-[13px] text-[var(--text-sub)] font-medium">Basic</td>
                                    <td class="px-5 py-4">
                                        <span class="px-2 py-1 rounded bg-black/5 dark:bg-white/5 border border-[var(--border)] text-[var(--text-sub)] text-xs font-mono">XYZ-5678</span>
                                    </td>
                                    <td class="px-5 py-4 text-[13px] text-[var(--text-sub)] font-medium">2025-08-15</td>
                                    <td class="px-5 py-4">
                                        <span class="px-2.5 py-0.5 rounded-full text-xs font-bold bg-green-500/15 text-green-500">Active</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="px-5 py-4">
                                        <div class="flex items-center gap-3">
                                            <div class="flex items-center justify-center rounded-full w-8 h-8 bg-[#2563eb] text-white text-[11px] font-bold">RC</div>
                                            <span class="text-sm font-medium text-[var(--text)]">Robert Chen</span>
                                        </div>
                                    </td>
                                    <td class="px-5 py-4 text-[13px] text-[var(--text-sub)] font-medium">Enterprise</td>
                                    <td class="px-5 py-4">
                                        <span class="px-2 py-1 rounded bg-black/5 dark:bg-white/5 border border-[var(--border)] text-[var(--text-sub)] text-xs font-mono">DEF-9012</span>
                                    </td>
                                    <td class="px-5 py-4 text-[13px] text-[var(--text-sub)] font-medium">2026-01-01</td>
                                    <td class="px-5 py-4">
                                        <span class="px-2.5 py-0.5 rounded-full text-xs font-bold bg-green-500/15 text-green-500">Active</span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="js/theme.js"></script>
    <script src="js/sidebar.js"></script>
    <script src="js/icons.js"></script>
</body>
</html>

