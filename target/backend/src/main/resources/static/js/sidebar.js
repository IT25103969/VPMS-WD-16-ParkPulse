function toggleSidebar() {
  const sidebar = document.getElementById('sidebar');
  const isCollapsed = sidebar.classList.toggle('collapsed');
  localStorage.setItem('sidebarCollapsed', isCollapsed);
  
  // Trigger lucide icon refresh if needed, though usually not needed for static icons
  updateSidebarUI(isCollapsed);
}

function updateSidebarUI(isCollapsed) {
  const sidebar = document.getElementById('sidebar');
  if (isCollapsed) {
    sidebar.style.width = '64px';
    document.querySelectorAll('.sidebar-label').forEach(el => el.style.display = 'none');
    document.querySelectorAll('.sidebar-logo-text').forEach(el => el.style.display = 'none');
    document.querySelectorAll('.sidebar-nav-item').forEach(el => el.style.justifyContent = 'center');
  } else {
    sidebar.style.width = '230px';
    document.querySelectorAll('.sidebar-label').forEach(el => el.style.display = 'inline');
    document.querySelectorAll('.sidebar-logo-text').forEach(el => el.style.display = 'inline');
    document.querySelectorAll('.sidebar-nav-item').forEach(el => el.style.justifyContent = 'flex-start');
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const isCollapsed = localStorage.getItem('sidebarCollapsed') === 'true';
  if (isCollapsed) {
    const sidebar = document.getElementById('sidebar');
    if (sidebar) {
      sidebar.classList.add('collapsed');
      updateSidebarUI(true);
    }
  }
});

