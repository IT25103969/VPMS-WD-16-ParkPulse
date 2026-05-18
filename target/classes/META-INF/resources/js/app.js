document.addEventListener('alpine:init', () => {
    Alpine.store('app', {
        isDark: localStorage.getItem('theme') === 'dark',
        sidebarCollapsed: localStorage.getItem('sidebarCollapsed') === 'true',
        activePage: window.location.pathname.includes('analytics') ? 'membership-analytics' : 'members',
        membershipOpen: window.location.pathname.includes('members') || window.location.pathname.includes('analytics'),

        toggleTheme() {
            this.isDark = !this.isDark;
            localStorage.setItem('theme', this.isDark ? 'dark' : 'light');
            document.documentElement.classList.toggle('dark', this.isDark);
        },

        toggleSidebar() {
            this.sidebarCollapsed = !this.sidebarCollapsed;
            localStorage.setItem('sidebarCollapsed', this.sidebarCollapsed);
        },

        init() {
            document.documentElement.classList.toggle('dark', this.isDark);
        }
    });
});
