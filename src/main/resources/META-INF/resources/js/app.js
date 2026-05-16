document.addEventListener('alpine:init', () => {
    Alpine.store('app', {
        isDark: localStorage.getItem('theme') === 'dark',
        sidebarCollapsed: false,
        activePage: 'members',

        toggleTheme() {
            this.isDark = !this.isDark;
            localStorage.setItem('theme', this.isDark ? 'dark' : 'light');
            document.documentElement.classList.toggle('dark', this.isDark);
        },

        init() {
            document.documentElement.classList.toggle('dark', this.isDark);
        }
    });
});
