<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<aside 
    class="sidebar-transition shrink-0 flex flex-col h-full overflow-hidden transition-colors duration-300"
    :class="[
        $store.app.sidebarCollapsed ? 'w-14' : 'w-44',
        $store.app.isDark ? 'bg-[#13151f]' : 'bg-white'
    ]"
>
    <!-- Brand row -->
    <div class="flex items-center border-b h-16" :class="[$store.app.isDark ? 'border-white/10' : 'border-gray-200', $store.app.sidebarCollapsed ? 'justify-center px-0' : 'gap-2.5 px-3']">
        <!-- Collapsed Brand -->
        <button x-show="$store.app.sidebarCollapsed" @click="$store.app.toggleSidebar()" class="w-8 h-8 rounded-lg flex items-center justify-center transition-colors" :class="$store.app.isDark ? 'text-gray-400 hover:text-white hover:bg-white/10' : 'text-gray-500 hover:text-gray-800 hover:bg-gray-100'">
            <svg class="size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="4" x2="20" y1="12" y2="12"/><line x1="4" x2="20" y1="6" y2="6"/><line x1="4" x2="20" y1="18" y2="18"/></svg>
        </button>

        <!-- Expanded Brand -->
        <div x-show="!$store.app.sidebarCollapsed" class="flex items-center gap-2.5 w-full">
            <div class="w-8 h-8 rounded-lg bg-blue-600 flex items-center justify-center shrink-0">
                <svg class="size-4 text-white" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 12h-2.48a2 2 0 0 0-1.93 1.46l-2.35 8.36a.25.25 0 0 1-.48 0L9.24 2.18a.25.25 0 0 0-.48 0l-2.35 8.36A2 2 0 0 1 4.48 12H2"/></svg>
            </div>
            <span class="font-semibold text-sm flex-1 truncate" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'">
                ParkPulse
            </span>
            <button @click="$store.app.toggleSidebar()" class="w-7 h-7 rounded-lg flex items-center justify-center transition-colors shrink-0" :class="$store.app.isDark ? 'text-gray-400 hover:text-white hover:bg-white/10' : 'text-gray-500 hover:text-gray-800 hover:bg-gray-100'">
                <svg class="size-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="4" x2="20" y1="12" y2="12"/><line x1="4" x2="20" y1="6" y2="6"/><line x1="4" x2="20" y1="18" y2="18"/></svg>
            </button>
        </div>
    </div>

    <!-- Nav -->
    <nav class="flex-1 px-2 py-4 flex flex-col gap-1 overflow-y-auto overflow-x-hidden">
        <!-- Dashboard -->
        <a href="/" class="flex items-center rounded-lg text-sm w-full text-left transition-colors" 
           :class="[$store.app.sidebarCollapsed ? 'justify-center px-0 py-2.5' : 'gap-2.5 px-3 py-2.5', $store.app.activePage === 'dashboard' ? 'bg-blue-600 text-white' : ($store.app.isDark ? 'text-gray-400 hover:bg-white/5 hover:text-white' : 'text-gray-500 hover:bg-gray-100 hover:text-gray-800')]">
            <i data-lucide="layout-dashboard" class="size-4"></i>
            <span x-show="!$store.app.sidebarCollapsed" x-transition class="truncate">Dashboard</span>
        </a>

        <!-- Parking Slots -->
        <a href="#" class="flex items-center rounded-lg text-sm w-full text-left transition-colors" 
           :class="[$store.app.sidebarCollapsed ? 'justify-center px-0 py-2.5' : 'gap-2.5 px-3 py-2.5', $store.app.isDark ? 'text-gray-400 hover:bg-white/5 hover:text-white' : 'text-gray-500 hover:bg-gray-100 hover:text-gray-800']">
            <i data-lucide="parking-circle" class="size-4"></i>
            <span x-show="!$store.app.sidebarCollapsed" x-transition class="truncate">Parking Slots</span>
        </a>

        <!-- Membership Group -->
        <div x-data="{ open: $store.app.membershipOpen }">
            <button @click="if($store.app.sidebarCollapsed) { $store.app.toggleSidebar(); open = true; } else { open = !open }" 
                    class="flex items-center justify-between px-3 py-2.5 rounded-lg text-sm w-full text-left transition-colors"
                    :class="[($store.app.activePage === 'members' || $store.app.activePage === 'membership-analytics') ? ($store.app.isDark ? 'text-white' : 'text-gray-800') : ($store.app.isDark ? 'text-gray-400 hover:bg-white/5' : 'text-gray-500 hover:bg-gray-100')]">
                <span class="flex items-center gap-2.5">
                    <i data-lucide="users" class="size-4"></i>
                    <span x-show="!$store.app.sidebarCollapsed" x-transition>Membership</span>
                </span>
                <i data-lucide="chevron-down" class="size-3.5 transition-transform duration-200" :class="open ? 'rotate-180' : ''" x-show="!$store.app.sidebarCollapsed"></i>
            </button>

            <div x-show="open && !$store.app.sidebarCollapsed" x-collapse class="ml-3 pl-2 border-l flex flex-col gap-0.5 overflow-hidden" :class="$store.app.isDark ? 'border-white/5' : 'border-gray-100'">
                <a href="/members" class="flex items-center gap-2 px-2.5 py-2 rounded-r-lg text-xs w-full text-left transition-colors"
                   :class="$store.app.activePage === 'members' ? ($store.app.isDark ? 'bg-blue-600/15 text-blue-400 border-l-2 border-blue-500' : 'bg-blue-50 text-blue-600 border-l-2 border-blue-500') : ($store.app.isDark ? 'text-gray-400 hover:bg-white/5 hover:text-white' : 'text-gray-500 hover:bg-gray-100 hover:text-gray-800')">
                    <i data-lucide="user-square-2" class="size-3.5"></i>
                    Members
                </a>
                <a href="/analytics" class="flex items-center gap-2 px-2.5 py-2 rounded-r-lg text-xs w-full text-left transition-colors"
                   :class="$store.app.activePage === 'membership-analytics' ? ($store.app.isDark ? 'bg-blue-600/15 text-blue-400 border-l-2 border-blue-500' : 'bg-blue-50 text-blue-600 border-l-2 border-blue-500') : ($store.app.isDark ? 'text-gray-400 hover:bg-white/5 hover:text-white' : 'text-gray-500 hover:bg-gray-100 hover:text-gray-800')">
                    <i data-lucide="bar-chart-2" class="size-3.5"></i>
                    Analytics
                </a>
            </div>
        </div>

        <div class="my-1 border-t" :class="$store.app.isDark ? 'border-white/5' : 'border-gray-100'"></div>

        <!-- Settings -->
        <a href="#" class="flex items-center rounded-lg text-sm w-full text-left transition-colors" 
           :class="[$store.app.sidebarCollapsed ? 'justify-center px-0 py-2.5' : 'gap-2.5 px-3 py-2.5', $store.app.isDark ? 'text-gray-400 hover:bg-white/5 hover:text-white' : 'text-gray-500 hover:bg-gray-100 hover:text-gray-800']">
            <i data-lucide="settings" class="size-4"></i>
            <span x-show="!$store.app.sidebarCollapsed" x-transition class="truncate">Settings</span>
        </a>
    </nav>

    <!-- Bottom Actions -->
    <div class="pb-4 flex flex-col gap-2" :class="$store.app.sidebarCollapsed ? 'px-2' : 'px-3'">
        <!-- Expanded Theme Switcher -->
        <div x-show="!$store.app.sidebarCollapsed" x-transition class="border rounded-lg px-3 py-2 overflow-hidden" :class="$store.app.isDark ? 'border-white/10' : 'border-gray-200'">
            <p class="text-xs mb-2" :class="$store.app.isDark ? 'text-blue-400' : 'text-blue-600'">Theme Mode</p>
            <button @click="$store.app.toggleTheme()" class="flex items-center gap-2 rounded-md px-2 py-1.5 text-xs w-full transition-colors" :class="$store.app.isDark ? 'bg-[#1e2235] text-gray-300 hover:bg-white/10' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'">
                <span x-show="$store.app.isDark" class="flex items-center gap-2">
                    <svg class="size-3 text-yellow-400" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="4"/><path d="M12 2v2"/><path d="M12 20v2"/><path d="m4.93 4.93 1.41 1.41"/><path d="m17.66 17.66 1.41 1.41"/><path d="M2 12h2"/><path d="M20 12h2"/><path d="m6.34 17.66-1.41 1.41"/><path d="m19.07 4.93-1.41 1.41"/></svg>
                    Switch to Light
                </span>
                <span x-show="!$store.app.isDark" class="flex items-center gap-2">
                    <svg class="size-3 text-blue-500" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z"/></svg>
                    Switch to Dark
                </span>
            </button>
        </div>

        <!-- Collapsed Theme Switcher -->
        <button x-show="$store.app.sidebarCollapsed" @click="$store.app.toggleTheme()" class="w-full flex items-center justify-center py-2 rounded-lg transition-colors" :class="$store.app.isDark ? 'bg-[#1e2235] text-gray-300 hover:bg-white/10' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'">
            <svg x-show="$store.app.isDark" class="size-4 text-yellow-400" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="4"/><path d="M12 2v2"/><path d="M12 20v2"/><path d="m4.93 4.93 1.41 1.41"/><path d="m17.66 17.66 1.41 1.41"/><path d="M2 12h2"/><path d="M20 12h2"/><path d="m6.34 17.66-1.41 1.41"/><path d="m19.07 4.93-1.41 1.41"/></svg>
            <svg x-show="!$store.app.isDark" class="size-4 text-blue-500" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z"/></svg>
        </button>

        <button class="flex items-center justify-center gap-2 border rounded-lg py-2 text-xs transition-colors w-full" :class="$store.app.isDark ? 'bg-[#1e2235] border-white/10 text-gray-300 hover:bg-white/10' : 'bg-gray-100 border-gray-200 text-gray-500 hover:bg-gray-200'">
            <svg class="size-3.5 shrink-0" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" x2="9" y1="12" y2="12"/></svg>
            <span x-show="!$store.app.sidebarCollapsed" x-transition>Sign Out</span>
        </button>
    </div>
</aside>
