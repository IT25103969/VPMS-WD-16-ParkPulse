<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<aside id="sidebar" class="w-64 flex flex-col h-screen transition-all duration-300 relative z-40 border-r border-sidebar-border bg-sidebar shrink-0">
    <!-- Logo -->
    <div class="px-6 py-8 flex items-center gap-3">
        <div class="w-10 h-10 rounded-2xl flex items-center justify-center bg-gradient-to-br from-green-600 to-green-400 shadow-lg shadow-green-500/20">
            <i data-lucide="parking-circle" class="size-6 text-white"></i>
        </div>
        <div id="sidebar-logo-text" class="flex flex-col">
            <span class="text-lg font-bold tracking-tight text-foreground">ParkPulse</span>
            <span class="text-[10px] uppercase tracking-widest font-semibold text-green-500/80 -mt-1">Management</span>
        </div>
    </div>

    <!-- Navigation -->
    <nav class="flex-1 px-3 space-y-1.5 overflow-y-auto py-2">
        <a href="/" data-page="/" class="nav-link flex items-center gap-3 px-3 py-2.5 rounded-xl transition-all duration-200 group hover:bg-green-500/5 text-sidebar-foreground/60 hover:text-green-500">
            <i data-lucide="layout-dashboard" class="size-5"></i>
            <span class="text-sm font-medium">Dashboard</span>
        </a>
        <a href="/parking-slots" data-page="/parking-slots" class="nav-link flex items-center gap-3 px-3 py-2.5 rounded-xl transition-all duration-200 group hover:bg-green-500/5 text-sidebar-foreground/60 hover:text-green-500">
            <i data-lucide="parking-square" class="size-5"></i>
            <span class="text-sm font-medium">Parking Slots</span>
        </a>
        <a href="/analytics" data-page="/analytics" class="nav-link flex items-center gap-3 px-3 py-2.5 rounded-xl transition-all duration-200 group hover:bg-green-500/5 text-sidebar-foreground/60 hover:text-green-500">
            <i data-lucide="bar-chart-2" class="size-5"></i>
            <span class="text-sm font-medium">Analytics</span>
        </a>
        
        <div class="pt-4 pb-2 px-3">
            <div class="h-px bg-sidebar-border w-full"></div>
        </div>

        <a href="/membership" data-page="/membership" class="nav-link flex items-center gap-3 px-3 py-2.5 rounded-xl transition-all duration-200 group hover:bg-green-500/5 text-sidebar-foreground/60 hover:text-green-500">
            <i data-lucide="users" class="size-5"></i>
            <span class="text-sm font-medium">Membership</span>
        </a>
        <a href="/membership-analytics" data-page="/membership-analytics" class="nav-link flex items-center gap-3 px-3 py-2.5 rounded-xl transition-all duration-200 group hover:bg-green-500/5 text-sidebar-foreground/60 hover:text-green-500">
            <i data-lucide="pie-chart" class="size-5"></i>
            <span class="text-sm font-medium">Member Analytics</span>
        </a>
        
        <div class="pt-4 pb-2 px-3">
            <div class="h-px bg-sidebar-border w-full"></div>
        </div>

        <a href="/settings" data-page="/settings" class="nav-link flex items-center gap-3 px-3 py-2.5 rounded-xl transition-all duration-200 group hover:bg-green-500/5 text-sidebar-foreground/60 hover:text-green-500">
            <i data-lucide="settings" class="size-5"></i>
            <span class="text-sm font-medium">Settings</span>
        </a>
    </nav>

    <!-- Theme Toggle & Collapse -->
    <div class="p-4 border-t border-sidebar-border space-y-3">
        <button id="theme-toggle" class="w-full flex items-center gap-3 px-3 py-2.5 rounded-xl transition-all duration-200 text-sidebar-foreground/60 hover:text-green-500 hover:bg-green-500/5">
            <i data-lucide="sun" class="size-5 hidden dark:block"></i>
            <i data-lucide="moon" class="size-5 block dark:hidden"></i>
            <span class="text-sm font-medium theme-text">Light Mode</span>
        </button>
        <button id="sidebar-collapse" class="w-full flex items-center gap-3 px-3 py-2.5 rounded-xl transition-all duration-200 text-sidebar-foreground/60 hover:text-green-500 hover:bg-green-500/5">
            <i data-lucide="chevron-left" class="size-5 transition-transform duration-300" id="collapse-icon"></i>
            <span class="text-sm font-medium collapse-text">Collapse Sidebar</span>
        </button>
    </div>
</aside>

<script>
    // Sidebar Active State
    document.querySelectorAll('.nav-link').forEach(link => {
        if (window.location.pathname.includes(link.getAttribute('data-page'))) {
            link.classList.remove('text-sidebar-foreground/60');
            link.classList.add('bg-green-500/10', 'text-green-500');
        }
    });

    // Theme Toggle Logic
    const themeBtn = document.getElementById('theme-toggle');
    const themeText = themeBtn.querySelector('.theme-text');
    
    function updateThemeUI() {
        const isDark = document.body.classList.contains('dark');
        themeText.textContent = isDark ? 'Light Mode' : 'Dark Mode';
    }
    updateThemeUI();

    themeBtn.addEventListener('click', () => {
        const isDark = document.body.classList.toggle('dark');
        localStorage.setItem('theme', isDark ? 'dark' : 'light');
        
        if (isDark) {
            document.body.classList.add('bg-mesh-dark');
            document.body.classList.remove('bg-mesh-light');
        } else {
            document.body.classList.add('bg-mesh-light');
            document.body.classList.remove('bg-mesh-dark');
        }
        updateThemeUI();
    });

    // Sidebar Collapse Logic
    const sidebar = document.getElementById('sidebar');
    const collapseBtn = document.getElementById('sidebar-collapse');
    const collapseIcon = document.getElementById('collapse-icon');
    const logoText = document.getElementById('sidebar-logo-text');
    const navTexts = document.querySelectorAll('.nav-link span, .theme-text, .collapse-text');

    collapseBtn.addEventListener('click', () => {
        const isCollapsed = sidebar.classList.toggle('w-64');
        sidebar.classList.toggle('w-20');
        collapseIcon.classList.toggle('rotate-180');
        
        logoText.classList.toggle('hidden');
        navTexts.forEach(text => text.classList.toggle('hidden'));
    });
</script>
