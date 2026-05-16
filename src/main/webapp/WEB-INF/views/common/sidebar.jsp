<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside 
    class="shrink-0 border-r border-sidebar-border bg-sidebar flex flex-col overflow-hidden transition-all duration-300 ease-in-out"
    :style="{ width: sidebarOpen ? '240px' : '64px' }"
>
    <!-- Header row — hamburger + logo -->
    <div class="flex items-center gap-3 px-4 py-5" :class="sidebarOpen ? '' : 'justify-center'">
        <button 
            @click="toggleSidebar()"
            class="size-9 shrink-0 flex items-center justify-center rounded-xl transition-colors hover:bg-sidebar-accent text-sidebar-foreground/70"
            :title="sidebarOpen ? 'Collapse sidebar' : 'Expand sidebar'"
        >
            <i data-lucide="menu" class="size-5"></i>
        </button>
        <template x-if="sidebarOpen">
            <div class="flex items-center gap-2 overflow-hidden whitespace-nowrap">
                <div class="size-7 bg-blue-600 rounded-lg flex items-center justify-center shadow-md shrink-0">
                    <svg viewBox="0 0 28 28" fill="none" xmlns="http://www.w3.org/2000/svg" class="size-5">
                        <polyline points="2,14 7,14 9,8 12,20 15,11 17,17 20,14 26,14" stroke="white" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
                    </svg>
                </div>
                <span class="text-sm font-semibold text-sidebar-foreground">ParkPulse</span>
            </div>
        </template>
    </div>

    <nav class="flex-1 px-2 space-y-0.5 overflow-hidden">
        <!-- Parking Slots parent -->
        <div>
            <button 
                @click="window.location.href='${pageContext.request.contextPath}/'; toggleParking()"
                class="w-full flex items-center rounded-xl transition-colors"
                :class="[
                    (window.location.pathname.includes('dashboard') || window.location.pathname.includes('analytics') || window.location.pathname.includes('vehicles')) 
                        ? 'bg-blue-600 text-white shadow-md' 
                        : 'text-sidebar-foreground/60 hover:bg-sidebar-accent',
                    sidebarOpen ? 'gap-3 px-3 py-2.5' : 'justify-center py-2.5'
                ]"
            >
                <i data-lucide="parking-square" class="size-4 shrink-0"></i>
                <template x-if="sidebarOpen">
                    <span class="text-sm flex-1 text-left overflow-hidden whitespace-nowrap">Parking Slots</span>
                </template>
                <template x-if="sidebarOpen">
                    <i data-lucide="chevron-down" class="size-4 shrink-0 transition-transform" :class="parkingExpanded ? 'rotate-180' : ''"></i>
                </template>
            </button>

            <!-- Sub-items -->
            <div 
                x-show="parkingExpanded && sidebarOpen" 
                x-collapse
                class="pl-8 pt-0.5 space-y-0.5"
            >
                <a 
                    href="${pageContext.request.contextPath}/analytics"
                    class="w-full flex items-center gap-2 px-3 py-2 rounded-lg text-sm transition-colors"
                    :class="window.location.pathname.includes('analytics') ? 'bg-sidebar-accent text-sidebar-foreground' : 'text-sidebar-foreground/60 hover:bg-sidebar-accent'"
                >
                    <i data-lucide="bar-chart-3" class="size-3.5"></i>
                    <span class="whitespace-nowrap">Analytics</span>
                </a>
                <a 
                    href="${pageContext.request.contextPath}/vehicles"
                    class="w-full flex items-center gap-2 px-3 py-2 rounded-lg text-sm transition-colors"
                    :class="window.location.pathname.includes('vehicles') ? 'bg-sidebar-accent text-sidebar-foreground' : 'text-sidebar-foreground/60 hover:bg-sidebar-accent'"
                >
                    <i data-lucide="list-checks" class="size-3.5"></i>
                    <span class="whitespace-nowrap">Vehicles</span>
                </a>
            </div>
        </div>
    </nav>

    <!-- Footer -->
    <div class="border-t border-sidebar-border p-2 space-y-0.5">
        <!-- Theme toggle -->
        <button 
            @click="toggleTheme()"
            class="w-full flex items-center rounded-xl py-2.5 transition-colors text-sidebar-foreground/60 hover:bg-sidebar-accent"
            :class="sidebarOpen ? 'gap-3 px-3' : 'justify-center'"
        >
            <template x-if="!isDark">
                <i data-lucide="moon" class="size-4 shrink-0"></i>
            </template>
            <template x-if="isDark">
                <i data-lucide="sun" class="size-4 shrink-0"></i>
            </template>
            <template x-if="sidebarOpen">
                <span x-text="isDark ? 'Light Mode' : 'Dark Mode'" class="text-sm overflow-hidden whitespace-nowrap"></span>
            </template>
        </button>

        <!-- Sign Out -->
        <button 
            class="w-full flex items-center rounded-xl py-2.5 transition-colors text-sidebar-foreground/60 hover:bg-sidebar-accent"
            :class="sidebarOpen ? 'gap-3 px-3' : 'justify-center'"
        >
            <i data-lucide="log-out" class="size-4 shrink-0"></i>
            <template x-if="sidebarOpen">
                <span class="text-sm overflow-hidden whitespace-nowrap">Sign Out</span>
            </template>
        </button>
    </div>
</aside>
