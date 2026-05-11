<aside class="flex flex-col h-full flex-shrink-0" style="width: 230px; background: #161b27; border-right: 1px solid rgba(255,255,255,0.06);">
    <!-- Logo -->
    <div class="flex items-center gap-2.5 px-5 py-[18px] flex-shrink-0" style="border-bottom: 1px solid rgba(255,255,255,0.06);">
        <div class="flex items-center justify-center rounded-xl flex-shrink-0" style="width: 34px; height: 34px; background: #2563eb;">
            <i data-lucide="activity" size="17" color="white"></i>
        </div>
        <span style="color: #fff; font-weight: 700; font-size: 16px;">ParkPulse</span>
    </div>

    <!-- Nav -->
    <nav class="flex-1 overflow-y-auto py-3 px-3">
        <a href="/dashboard" class="flex items-center gap-3 w-full px-3 py-[10px] rounded-xl mb-0.5 transition-all duration-150 ${activePage == 'dashboard' ? 'sidebar-item-active' : 'sidebar-item-inactive'}">
            <i data-lucide="layout-dashboard" size="17"></i>
            <span style="font-size: 14px;">Dashboard</span>
        </a>
        <a href="/staff" class="flex items-center gap-3 w-full px-3 py-[10px] rounded-xl mb-0.5 transition-all duration-150 ${activePage == 'staff' ? 'sidebar-item-active' : 'sidebar-item-inactive'}">
            <i data-lucide="users" size="17"></i>
            <span style="font-size: 14px;">Staff</span>
        </a>
    </nav>

    <!-- Bottom -->
    <div class="flex flex-col gap-1 px-3 py-3 flex-shrink-0" style="border-top: 1px solid rgba(255,255,255,0.06);">
        <button class="flex items-center gap-3 px-3 py-[10px] rounded-xl w-full transition-all sidebar-item-inactive" style="background: transparent; border: none; cursor: pointer; text-align: left;">
            <i data-lucide="sun" size="17"></i>
            <span style="font-size: 14px;">Light Mode</span>
        </button>
        <button class="flex items-center gap-3 px-3 py-[10px] rounded-xl w-full transition-all sidebar-item-inactive" style="background: transparent; border: none; cursor: pointer; text-align: left;">
            <i data-lucide="log-out" size="17"></i>
            <span style="font-size: 14px;">Sign Out</span>
        </button>
    </div>
</aside>
<script>
    lucide.createIcons();
</script>
