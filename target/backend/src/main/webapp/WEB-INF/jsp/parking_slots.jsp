<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Parking Slots - ParkPulse</title>
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
                <span class="text(--border-med)]">/</span>
                <span class="text-[var(--text)] font-medium">Parking Slots</span>
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
                        <h1 class="text-2xl font-bold text-[var(--text)] m-0">Parking Slots</h1>
                        <p class="text-sm text-[var(--text-sub)] mt-1">View and manage individual parking spaces.</p>
                    </div>
                    <div class="flex items-center gap-4">
                        <div class="flex items-center gap-1.5">
                            <div class="w-2.5 h-2.5 rounded-full bg-[#22c55e]"></div>
                            <span id="available-count" class="text-[13px] text-[var(--text-sub)]">Available (31)</span>
                        </div>
                        <div class="flex items-center gap-1.5">
                            <div class="w-2.5 h-2.5 rounded-full bg-[#ef4444]"></div>
                            <span id="occupied-count" class="text-[13px] text-[var(--text-sub)]">Occupied (3)</span>
                        </div>
                    </div>
                </div>

                <div class="rounded-xl p-6 bg-[var(--card)] border border-[var(--border)] shadow-sm dark:shadow-none">
                    <h3 class="font-bold text-[var(--text)] mb-5">All Parking Slots — Click to toggle</h3>
                    <div id="parking-grid" class="flex flex-wrap gap-3">
                        <!-- JS Inject -->
                    </div>
                    <p class="text-[12px] text-[var(--text-sub)] mt-6">
                        Click any slot to mark it as occupied or available.
                    </p>
                </div>
            </div>
        </main>
    </div>

    <script src="js/theme.js"></script>
    <script src="js/sidebar.js"></script>
    <script>
        let occupied = ["A3", "A7", "A15"];
        const TOTAL_SLOTS = 34;

        function updateUI() {
            const grid = document.getElementById('parking-grid');
            grid.innerHTML = '';
            
            for (let i = 1; i <= TOTAL_SLOTS; i++) {
                const slotId = 'A' + i;
                const isOccupied = occupied.includes(slotId);
                
                const btn = document.createElement('button');
                btn.className = `flex flex-col items-center justify-center rounded-xl transition-all hover:opacity-90 w-16 h-14 border-none cursor-pointer text-white text-[13px] font-bold gap-0.5`;
                btn.style.background = isOccupied ? '#ef4444' : '#22c55e';
                btn.onclick = () => toggleSlot(slotId);
                
                btn.innerHTML = `
                    <i data-lucide="${isOccupied ? 'car' : 'check-circle'}" style="width: 14px; height: 14px;"></i>
                    ${slotId}
                `;
                grid.appendChild(btn);
            }
            
            document.getElementById('available-count').innerText = `Available (${TOTAL_SLOTS - occupied.length})`;
            document.getElementById('occupied-count').innerText = `Occupied (${occupied.length})`;
            lucide.createIcons();
        }

        function toggleSlot(slotId) {
            if (occupied.includes(slotId)) {
                occupied = occupied.filter(s => s !== slotId);
            } else {
                occupied.push(slotId);
            }
            updateUI();
        }

        document.addEventListener('DOMContentLoaded', updateUI);
    </script>
    <script src="js/icons.js"></script>
</body>
</html>

