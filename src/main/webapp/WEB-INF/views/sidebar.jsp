<aside id="sidebar" class="shrink-0 sidebar-bg flex flex-col overflow-hidden transition-all duration-300 w-[240px]">
    <!-- Header row — hamburger + logo -->
    <div class="flex items-center gap-3 px-4 py-5" id="sidebar-header">
        <button id="toggle-sidebar" class="size-9 shrink-0 flex items-center justify-center rounded-xl transition-colors hover:bg-gray-100 dark:hover:bg-[#1a2540] text-gray-600 dark:text-gray-300" title="Toggle sidebar">
            <i data-lucide="menu" class="size-5"></i>
        </button>
        <div class="sidebar-content flex items-center gap-2 overflow-hidden whitespace-nowrap transition-opacity duration-200">
            <div class="size-7 bg-blue-600 rounded-lg flex items-center justify-center shadow-md shrink-0">
                <svg viewBox="0 0 28 28" fill="none" xmlns="http://www.w3.org/2000/svg" class="size-5">
                    <polyline points="2,14 7,14 9,8 12,20 15,11 17,17 20,14 26,14" stroke="white" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" fill="none" />
                </svg>
            </div>
            <span class="text-sm font-semibold text-primary">ParkPulse</span>
        </div>
    </div>

    <nav class="flex-1 px-2 space-y-0.5 overflow-hidden">
        <!-- Parking Slots parent -->
        <div>
            <button id="parking-menu-toggle" class="w-full flex items-center gap-3 px-3 py-2.5 rounded-xl transition-colors bg-blue-600 text-white shadow-md">
                <i data-lucide="parking-square" class="size-4 shrink-0"></i>
                <span class="sidebar-content text-sm flex-1 text-left overflow-hidden whitespace-nowrap">Parking Slots</span>
                <i data-lucide="chevron-down" id="parking-chevron" class="sidebar-content size-4 shrink-0 transition-transform rotate-180"></i>
            </button>

            <!-- Sub-items -->
            <div id="parking-submenu" class="overflow-hidden transition-all duration-300">
                <div class="pl-8 pt-0.5 space-y-0.5">
                    <a href="/" class="nav-item flex items-center gap-2 px-3 py-2 rounded-lg text-sm transition-colors text-muted hover:bg-gray-100 dark:hover:bg-[#1a2540]">
                        <i data-lucide="layout-dashboard" class="size-3.5"></i>
                        <span class="whitespace-nowrap">Dashboard</span>
                    </a>
                    <a href="/slots" class="nav-item flex items-center gap-2 px-3 py-2 rounded-lg text-sm transition-colors text-muted hover:bg-gray-100 dark:hover:bg-[#1a2540]">
                        <i data-lucide="parking-square" class="size-3.5"></i>
                        <span class="whitespace-nowrap">Slots</span>
                    </a>
                    <a href="/analytics" class="nav-item flex items-center gap-2 px-3 py-2 rounded-lg text-sm transition-colors text-muted hover:bg-gray-100 dark:hover:bg-[#1a2540]">
                        <i data-lucide="bar-chart-3" class="size-3.5"></i>
                        <span class="whitespace-nowrap">Analytics</span>
                    </a>
                    <a href="/vehicles" class="nav-item flex items-center gap-2 px-3 py-2 rounded-lg text-sm transition-colors text-muted hover:bg-gray-100 dark:hover:bg-[#1a2540]">
                        <i data-lucide="list-checks" class="size-3.5"></i>
                        <span class="whitespace-nowrap">Vehicles</span>
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Footer -->
    <div class="border-t border-gray-200 dark:border-[#1f2a44] p-2 space-y-0.5">
        <!-- Theme toggle -->
        <button id="theme-toggle" class="w-full flex items-center gap-3 px-3 py-2.5 rounded-xl transition-colors bg-gray-100 dark:bg-[#1a2540] text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-[#243154]">
            <i data-lucide="sun" class="hidden dark:block size-4 shrink-0"></i>
            <i data-lucide="moon" class="block dark:hidden size-4 shrink-0"></i>
            <span class="sidebar-content text-sm overflow-hidden whitespace-nowrap" id="theme-text">Light Mode</span>
        </button>

        <!-- Sign Out -->
        <button class="w-full flex items-center gap-3 px-3 py-2.5 rounded-xl transition-colors bg-gray-100 dark:bg-[#1a2540] text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-[#243154]">
            <i data-lucide="log-out" class="size-4 shrink-0"></i>
            <span class="sidebar-content text-sm overflow-hidden whitespace-nowrap">Sign Out</span>
        </button>
    </div>
</aside>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const sidebar = document.getElementById('sidebar');
        const toggleBtn = document.getElementById('toggle-sidebar');
        const sidebarContents = document.querySelectorAll('.sidebar-content');
        const parkingToggle = document.getElementById('parking-menu-toggle');
        const parkingSubmenu = document.getElementById('parking-submenu');
        const parkingChevron = document.getElementById('parking-chevron');
        const themeToggle = document.getElementById('theme-toggle');
        const themeText = document.getElementById('theme-text');

        // Sidebar Collapse
        let sidebarOpen = localStorage.getItem('sidebarOpen') !== 'false';
        const updateSidebar = () => {
            if (sidebarOpen) {
                sidebar.style.width = '240px';
                sidebarContents.forEach(el => el.classList.remove('hidden'));
            } else {
                sidebar.style.width = '64px';
                sidebarContents.forEach(el => el.classList.add('hidden'));
                parkingSubmenu.style.height = '0px';
                parkingChevron.classList.remove('rotate-180');
            }
            localStorage.setItem('sidebarOpen', sidebarOpen);
        };
        
        toggleBtn.addEventListener('click', () => {
            sidebarOpen = !sidebarOpen;
            updateSidebar();
        });

        // Submenu Toggle
        let parkingExpanded = true;
        parkingToggle.addEventListener('click', () => {
            if (!sidebarOpen) {
                sidebarOpen = true;
                updateSidebar();
            }
            parkingExpanded = !parkingExpanded;
            parkingSubmenu.style.height = parkingExpanded ? 'auto' : '0px';
            parkingChevron.classList.toggle('rotate-180', parkingExpanded);
        });

        // Theme Toggle
        const updateThemeUI = () => {
            const isDark = document.documentElement.classList.contains('dark');
            themeText.textContent = isDark ? 'Light Mode' : 'Dark Mode';
        };

        themeToggle.addEventListener('click', () => {
            document.documentElement.classList.toggle('dark');
            const isDark = document.documentElement.classList.contains('dark');
            localStorage.setItem('theme', isDark ? 'dark' : 'light');
            updateThemeUI();
        });

        // Initialize Theme from LocalStorage
        if (localStorage.getItem('theme') === 'dark' || (!localStorage.getItem('theme') && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
            document.documentElement.classList.add('dark');
        } else {
            document.documentElement.classList.remove('dark');
        }
        
        // Initialize Sidebar from LocalStorage
        updateSidebar();
        updateThemeUI();

        // Highlight active nav item
        const currentPath = window.location.pathname.split('/').pop() || 'dashboard.jsp';
        document.querySelectorAll('.nav-item').forEach(item => {
            if (item.getAttribute('href') === currentPath) {
                item.classList.remove('text-muted');
                item.classList.add('bg-blue-50', 'dark:bg-[#1a2540]', 'text-blue-700', 'dark:text-white');
            }
        });

        // Initialize Lucide Icons
        lucide.createIcons();
    });
</script>
