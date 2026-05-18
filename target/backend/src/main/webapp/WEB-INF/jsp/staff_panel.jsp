<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Panel - ParkPulse</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link rel="stylesheet" href="css/theme.css">
    <link rel="stylesheet" href="css/globals.css">
    <style>
        .staff-panel-card:hover { background: rgba(255,255,255,0.06) !important; }
    </style>
</head>
<body class="bg-[#1a1f2e] h-screen w-screen flex items-center justify-center">
    <!-- Staff Panel (Standalone mockup) -->
    <div id="staff-panel" class="flex flex-col h-full flex-shrink-0 w-[260px] bg-[#161b27] border-r border-white/5">
        <!-- Header -->
        <div class="flex items-center justify-between px-4 py-4 flex-shrink-0 border-b border-white/5">
            <div>
                <div class="flex items-center gap-2">
                    <i data-lucide="users" style="width: 15px; height: 15px; color: #60a5fa;"></i>
                    <span class="text-white font-bold text-[15px]">Staff</span>
                </div>
                <p id="panel-stats" class="text-[#8b95a8] text-[11px] mt-0.5">0 active · 0 total</p>
            </div>
            <button onclick="window.location.href='/staff'" class="text-[#8b95a8] p-1 hover:text-white transition-colors">
                <i data-lucide="x" style="width: 16px; height: 16px;"></i>
            </button>
        </div>

        <!-- Search -->
        <div class="px-3 pt-3 pb-2 flex-shrink-0">
            <div class="flex items-center gap-2 px-3 py-2 rounded-lg bg-white/5 border border-white/10">
                <i data-lucide="search" style="width: 13px; height: 13px; color: #8b95a8;"></i>
                <input id="panel-search" type="text" placeholder="Search staff..." class="bg-transparent border-none outline-none text-white text-[13px] w-full">
            </div>
        </div>

        <!-- Filter tabs -->
        <div class="px-3 pb-3 flex-shrink-0">
            <div class="flex bg-white/5 rounded-lg p-0.5 gap-0.5">
                <button onclick="setPanelFilter('all')" data-filter="all" class="panel-filter-btn flex-1 py-1 rounded-md text-[11px] font-bold bg-[#2563eb] text-white">All</button>
                <button onclick="setPanelFilter('active')" data-filter="active" class="panel-filter-btn flex-1 py-1 rounded-md text-[11px] text-[#8b95a8]">Active</button>
                <button onclick="setPanelFilter('offduty')" data-filter="offduty" class="panel-filter-btn flex-1 py-1 rounded-md text-[11px] text-[#8b95a8]">Off Duty</button>
            </div>
        </div>

        <!-- Staff list -->
        <div id="panel-list" class="flex-1 overflow-y-auto px-2 space-y-1 pb-2">
            <!-- JS Inject -->
        </div>

        <!-- Add Staff button -->
        <div class="px-3 py-3 flex-shrink-0 border-t border-white/5">
            <button onclick="window.location.href='/staff_form'" class="flex items-center justify-center gap-2 w-full py-2.5 rounded-xl bg-[#2563eb] text-white text-[13px] font-bold hover:bg-[#1d4ed8] transition-colors">
                <i data-lucide="plus-circle" style="width: 14px; height: 14px;"></i>
                Add Staff Member
            </button>
        </div>
    </div>

    <script src="js/staff-data.js"></script>
    <script>
        let panelFilter = 'all';
        let panelSearch = '';

        const COLOR_PALETTE = ["#2563eb", "#7c3aed", "#0891b2", "#059669", "#d97706", "#dc2626", "#db2777"];
        function getAvatarColor(id) { return COLOR_PALETTE[id % COLOR_PALETTE.length]; }
        function getInitials(name) { return name.split(" ").map((n) => n[0]).join("").toUpperCase().slice(0, 2); }

        function renderPanel() {
            const list = getStaffList();
            const container = document.getElementById('panel-list');
            
            const filtered = list.filter(s => {
                const matchSearch = s.name.toLowerCase().includes(panelSearch.toLowerCase()) || s.role.toLowerCase().includes(panelSearch.toLowerCase());
                const matchFilter = panelFilter === 'all' || (panelFilter === 'active' && s.status === 'Active') || (panelFilter === 'offduty' && s.status === 'Off Duty');
                return matchSearch && matchFilter;
            });

            document.getElementById('panel-stats').innerText = `${list.filter(s => s.status === 'Active').length} active · ${list.length} total`;

            if (filtered.length === 0) {
                container.innerHTML = `<div class="flex flex-col items-center justify-center py-12"><i data-lucide="users" style="width: 28px; height: 28px; color: #8b95a8; opacity: 0.4; margin-bottom: 8px;"></i><p class="text-[#8b95a8] text-[13px]">No results found</p></div>`;
            } else {
                container.innerHTML = filtered.map(staff => `
                    <div class="rounded-xl p-3 bg-white/5 border border-white/5 cursor-pointer transition-all staff-panel-card" onclick="window.location.href='/staff_detail?id=${staff.id}'">
                        <div class="flex items-center gap-2.5 mb-2">
                            <div class="flex items-center justify-center rounded-full w-[34px] h-[34px] text-[12px] text-white font-bold" style="background: ${getAvatarColor(staff.id)}">${getInitials(staff.name)}</div>
                            <div class="flex-1 min-w-0">
                                <p class="text-white text-[13px] font-bold truncate">${staff.name}</p>
                                <p class="text-[#8b95a8] text-[11px]">${staff.role}</p>
                            </div>
                            <div class="w-2 h-2 rounded-full" style="background: ${staff.status === 'Active' ? '#22c55e' : '#6b7280'}; box-shadow: ${staff.status === 'Active' ? '0 0 6px #22c55e' : 'none'};"></div>
                        </div>
                        <div class="flex items-center justify-between">
                            <span class="text-[10px] text-[#8b95a8] bg-white/5 px-2 py-0.5 rounded">${staff.shift.split('(')[0].trim()}</span>
                            <span class="text-[10px] font-bold px-2 py-0.5 rounded-full ${staff.status === 'Active' ? 'bg-green-500/10 text-green-500' : 'bg-gray-500/10 text-gray-400'}">${staff.status}</span>
                        </div>
                    </div>
                `).join('');
            }
            lucide.createIcons();
        }

        function setPanelFilter(f) {
            panelFilter = f;
            document.querySelectorAll('.panel-filter-btn').forEach(btn => {
                if (btn.dataset.filter === f) {
                    btn.classList.add('bg-[#2563eb]', 'text-white', 'font-bold');
                    btn.classList.remove('text-[#8b95a8]');
                } else {
                    btn.classList.remove('bg-[#2563eb]', 'text-white', 'font-bold');
                    btn.classList.add('text-[#8b95a8]');
                }
            });
            renderPanel();
        }

        document.addEventListener('DOMContentLoaded', () => {
            document.getElementById('panel-search').oninput = (e) => {
                panelSearch = e.target.value;
                renderPanel();
            };
            renderPanel();
        });
    </script>
    <script src="js/icons.js"></script>
</body>
</html>

