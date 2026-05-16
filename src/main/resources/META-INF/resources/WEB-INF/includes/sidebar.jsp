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
        <!-- Expanded Brand -->
        <div x-show="!$store.app.sidebarCollapsed" class="flex items-center gap-2.5 w-full">
            <div class="w-8 h-8 rounded-lg bg-blue-600 flex items-center justify-center shrink-0">
                <svg class="size-4 text-white" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 12h-2.48a2 2 0 0 0-1.93 1.46l-2.35 8.36a.25.25 0 0 1-.48 0L9.24 2.18a.25.25 0 0 0-.48 0l-2.35 8.36A2 2 0 0 1 4.48 12H2"/></svg>
            </div>
            <span class="font-semibold text-sm flex-1 truncate" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'">
                ParkPulse
            </span>
        </div>
    </div>

    <!-- Nav -->
    <nav class="flex-1 px-2 py-4 flex flex-col gap-1 overflow-y-auto overflow-x-hidden">
        <a href="/" class="flex items-center rounded-lg text-sm w-full text-left transition-colors" 
           :class="[$store.app.sidebarCollapsed ? 'justify-center px-0 py-2.5' : 'gap-2.5 px-3 py-2.5', $store.app.activePage === 'dashboard' ? 'bg-blue-600 text-white' : ($store.app.isDark ? 'text-gray-400 hover:bg-white/5 hover:text-white' : 'text-gray-500 hover:bg-gray-100 hover:text-gray-800')]">
            <i data-lucide="layout-dashboard" class="size-4"></i>
            <span x-show="!$store.app.sidebarCollapsed" x-transition class="truncate">Dashboard</span>
        </a>

        <a href="/members" class="flex items-center rounded-lg text-sm w-full text-left transition-colors"
           :class="[$store.app.sidebarCollapsed ? 'justify-center px-0 py-2.5' : 'gap-2.5 px-3 py-2.5', ($store.app.activePage === 'members') ? 'bg-blue-600 text-white' : ($store.app.isDark ? 'text-gray-400 hover:bg-white/5 hover:text-white' : 'text-gray-500 hover:bg-gray-100 hover:text-gray-800')]">
            <i data-lucide="users" class="size-4"></i>
            <span x-show="!$store.app.sidebarCollapsed" x-transition class="truncate">Members</span>
        </a>

        <a href="/analytics" class="flex items-center rounded-lg text-sm w-full text-left transition-colors"
           :class="[$store.app.sidebarCollapsed ? 'justify-center px-0 py-2.5' : 'gap-2.5 px-3 py-2.5', $store.app.activePage === 'membership-analytics' ? 'bg-blue-600 text-white' : ($store.app.isDark ? 'text-gray-400 hover:bg-white/5 hover:text-white' : 'text-gray-500 hover:bg-gray-100 hover:text-gray-800')]">
            <i data-lucide="bar-chart-2" class="size-4"></i>
            <span x-show="!$store.app.sidebarCollapsed" x-transition class="truncate">Analytics</span>
        </a>
    </nav>
</aside>
