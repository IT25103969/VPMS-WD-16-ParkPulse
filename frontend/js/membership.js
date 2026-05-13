// Mock Data
let members = [
    { id: "MBR-001", name: "Alice Johnson", email: "alice.johnson@email.com", phone: "+1 (555) 234-5678", vehicle: "Toyota Camry", licensePlate: "ABC-1234", plan: "Monthly", status: "Active", joinDate: "2025-01-15" },
    { id: "MBR-002", name: "Bob Martinez", email: "bob.martinez@email.com", phone: "+1 (555) 345-6789", vehicle: "Honda Civic", licensePlate: "XYZ-5678", plan: "Annual", status: "Active", joinDate: "2024-11-02" },
    { id: "MBR-003", name: "Carol White", email: "carol.white@email.com", phone: "+1 (555) 456-7890", vehicle: "Ford Focus", licensePlate: "DEF-9012", plan: "Quarterly", status: "Inactive", joinDate: "2024-08-20" },
    { id: "MBR-004", name: "David Lee", email: "david.lee@email.com", phone: "+1 (555) 567-8901", vehicle: "Tesla Model 3", licensePlate: "GHI-3456", plan: "Annual", status: "Active", joinDate: "2025-02-10" },
    { id: "MBR-005", name: "Emma Davis", email: "emma.davis@email.com", phone: "+1 (555) 678-9012", vehicle: "BMW 3 Series", licensePlate: "JKL-7890", plan: "Monthly", status: "Suspended", joinDate: "2024-07-05" },
    { id: "MBR-006", name: "Frank Wilson", email: "frank.wilson@email.com", phone: "+1 (555) 789-0123", vehicle: "Chevrolet Malibu", licensePlate: "MNO-1234", plan: "Quarterly", status: "Active", joinDate: "2025-03-18" },
    { id: "MBR-007", name: "Grace Chen", email: "grace.chen@email.com", phone: "+1 (555) 890-1234", vehicle: "Nissan Altima", licensePlate: "PQR-5678", plan: "Annual", status: "Active", joinDate: "2024-12-01" },
];

// State
let currentPage = 1;
const pageSize = 5;
let searchQuery = "";
let statusFilter = "All";
let planFilter = "All";
let sortField = "id";
let sortDir = "asc";
let selectedIds = new Set();

// Elements
const tableBody = document.getElementById('member-table-body');
const searchInput = document.getElementById('search-input');
const clearSearchBtn = document.getElementById('clear-search');
const planFilterSelect = document.getElementById('plan-filter');
const statusFilters = document.getElementById('status-filters');
const paginationInfo = document.getElementById('pagination-info');
const paginationControls = document.getElementById('pagination-controls');
const selectAllCheckbox = document.getElementById('select-all');
const bulkActions = document.getElementById('bulk-actions');
const selectedCountText = document.getElementById('selected-count');
const notifBtn = document.getElementById('notif-btn');
const notifDropdown = document.getElementById('notif-dropdown');
const toastContainer = document.getElementById('toast-container');

// Initialize
function init() {
    render();
    setupEventListeners();
}

function setupEventListeners() {
    // Notification Dropdown Toggle
    if (notifBtn) {
        notifBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            notifDropdown.classList.toggle('hidden');
        });
    }

    document.addEventListener('click', () => {
        if (notifDropdown) notifDropdown.classList.add('hidden');
    });

    if (notifDropdown) {
        notifDropdown.addEventListener('click', (e) => e.stopPropagation());
    }

    if (searchInput) {
        searchInput.addEventListener('input', (e) => {
            searchQuery = e.target.value.toLowerCase();
            clearSearchBtn.classList.toggle('hidden', !searchQuery);
            currentPage = 1;
            render();
        });
    }

    if (clearSearchBtn) {
        clearSearchBtn.addEventListener('click', () => {
            searchInput.value = "";
            searchQuery = "";
            clearSearchBtn.classList.add('hidden');
            currentPage = 1;
            render();
        });
    }

    if (planFilterSelect) {
        planFilterSelect.addEventListener('change', (e) => {
            planFilter = e.target.value;
            currentPage = 1;
            render();
        });
    }

    if (statusFilters) {
        statusFilters.addEventListener('click', (e) => {
            if (e.target.classList.contains('filter-tab')) {
                document.querySelectorAll('.filter-tab').forEach(tab => tab.classList.remove('active', 'bg-green-500/10', 'text-green-500'));
                e.target.classList.add('active', 'bg-green-500/10', 'text-green-500');
                statusFilter = e.target.getAttribute('data-status');
                currentPage = 1;
                render();
            }
        });
    }

    if (selectAllCheckbox) {
        selectAllCheckbox.addEventListener('change', (e) => {
            const pagedMembers = getFilteredAndSortedMembers().slice((currentPage - 1) * pageSize, currentPage * pageSize);
            if (e.target.checked) {
                pagedMembers.forEach(m => selectedIds.add(m.id));
            } else {
                pagedMembers.forEach(m => selectedIds.delete(m.id));
            }
            updateBulkActions();
            renderTableOnly();
        });
    }

    // Modal Pills
    document.querySelectorAll('.plan-pill').forEach(btn => {
        btn.addEventListener('click', () => {
            updateModalPills(btn.getAttribute('data-value'), document.getElementById('member-status').value);
        });
    });

    document.querySelectorAll('.status-pill').forEach(btn => {
        btn.addEventListener('click', () => {
            updateModalPills(document.getElementById('member-plan').value, btn.getAttribute('data-value'));
        });
    });
}

function updateModalPills(plan, status) {
    document.querySelectorAll('.plan-pill').forEach(btn => {
        const isSelected = btn.getAttribute('data-value') === plan;
        if (isSelected) {
            btn.classList.add('bg-green-500/10', 'border-green-500/50', 'shadow-lg', 'shadow-green-500/10');
            btn.classList.remove('bg-foreground/5', 'border-border');
        } else {
            btn.classList.remove('bg-green-500/10', 'border-green-500/50', 'shadow-lg', 'shadow-green-500/10');
            btn.classList.add('bg-foreground/5', 'border-border');
        }
    });
    document.getElementById('member-plan').value = plan;

    document.querySelectorAll('.status-pill').forEach(btn => {
        const isSelected = btn.getAttribute('data-value') === status;
        if (isSelected) {
            btn.classList.add('bg-green-500/10', 'border-green-500/50', 'shadow-lg', 'shadow-green-500/10');
            btn.classList.remove('bg-foreground/5', 'border-border');
        } else {
            btn.classList.remove('bg-green-500/10', 'border-green-500/50', 'shadow-lg', 'shadow-green-500/10');
            btn.classList.add('bg-foreground/5', 'border-border');
        }
    });
    document.getElementById('member-status').value = status;
}

// Toast System
function showToast(message, type = 'success') {
    if (!toastContainer) return;
    const toast = document.createElement('div');
    
    toast.className = `px-4 py-3 rounded-xl border flex items-center gap-3 shadow-2xl animate-fade-in min-w-[280px] transition-all duration-500`;
    
    let icon = 'check-circle';
    if (type === 'success') {
        toast.classList.add('bg-green-500/10', 'border-green-500/20', 'text-green-500');
        icon = 'check-circle';
    } else {
        toast.classList.add('bg-red-500/10', 'border-red-500/20', 'text-red-500');
        icon = 'alert-circle';
    }
    
    toast.innerHTML = `
        <i data-lucide="${icon}" class="size-5"></i>
        <p class="text-sm font-semibold">${message}</p>
    `;
    
    toastContainer.appendChild(toast);
    lucide.createIcons();
    
    setTimeout(() => {
        toast.classList.add('opacity-0', 'translate-x-10');
        setTimeout(() => toast.remove(), 500);
    }, 3000);
}

function getFilteredAndSortedMembers() {
    let filtered = members.filter(m => {
        const matchesSearch = m.name.toLowerCase().includes(searchQuery) || 
                            m.email.toLowerCase().includes(searchQuery) || 
                            m.id.toLowerCase().includes(searchQuery) ||
                            m.licensePlate.toLowerCase().includes(searchQuery);
        const matchesStatus = statusFilter === "All" || m.status === statusFilter;
        const matchesPlan = planFilter === "All" || m.plan === planFilter;
        return matchesSearch && matchesStatus && matchesPlan;
    });

    filtered.sort((a, b) => {
        let valA = a[sortField];
        let valB = b[sortField];
        if (sortDir === "asc") return valA > valB ? 1 : -1;
        return valA < valB ? 1 : -1;
    });

    return filtered;
}

function render() {
    renderStats();
    renderTable();
}

function renderStats() {
    const totalEl = document.getElementById('stat-total');
    const activeEl = document.getElementById('stat-active');
    const inactiveEl = document.getElementById('stat-inactive');
    
    if (totalEl) totalEl.textContent = members.length;
    if (activeEl) activeEl.textContent = members.filter(m => m.status === "Active").length;
    if (inactiveEl) inactiveEl.textContent = members.filter(m => m.status !== "Active").length;
}

function renderTable() {
    if (!tableBody) return;
    
    const filtered = getFilteredAndSortedMembers();
    const totalItems = filtered.length;
    const totalPages = Math.ceil(totalItems / pageSize) || 1;
    
    if (currentPage > totalPages) currentPage = totalPages;
    
    const start = (currentPage - 1) * pageSize;
    const end = Math.min(start + pageSize, totalItems);
    const pagedMembers = filtered.slice(start, end);

    const countEl = document.getElementById('member-count');
    if (countEl) countEl.textContent = `${totalItems} member${totalItems !== 1 ? 's' : ''} found`;

    // Render Table Body
    if (pagedMembers.length === 0) {
        tableBody.innerHTML = `<tr><td colspan="9" class="text-center py-20">
            <div class="flex flex-col items-center gap-3">
                <div class="w-16 h-16 rounded-2xl flex items-center justify-center bg-foreground/[0.04] border border-border">
                    <i data-lucide="search" class="size-7 text-sidebar-foreground/40"></i>
                </div>
                <p class="font-medium text-sidebar-foreground/60">No members found</p>
                <p class="text-xs text-sidebar-foreground/40">Try adjusting your filters or search query</p>
            </div>
        </td></tr>`;
    } else {
        tableBody.innerHTML = pagedMembers.map(m => `
            <tr class="border-b border-border transition-colors hover:bg-foreground/[0.02] ${selectedIds.has(m.id) ? 'bg-green-500/5' : ''}">
                <td class="px-6 py-4">
                    <input type="checkbox" class="row-checkbox w-4 h-4 rounded border-border text-green-500 focus:ring-green-500/20 bg-background" 
                        data-id="${m.id}" ${selectedIds.has(m.id) ? 'checked' : ''} onchange="toggleRow('${m.id}')">
                </td>
                <td class="px-4 py-4">
                    <span class="font-mono text-xs px-2 py-1 rounded-lg bg-green-500/10 text-green-500 border border-green-500/20">${m.id}</span>
                </td>
                <td class="px-4 py-4">
                    <div class="flex items-center gap-3">
                        <div class="w-9 h-9 rounded-xl flex items-center justify-center text-xs font-bold text-white bg-green-500/20 text-green-500 border border-green-500/30">
                            ${m.name.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase()}
                        </div>
                        <span class="font-semibold text-foreground">${m.name}</span>
                    </div>
                </td>
                <td class="px-4 py-4">
                    <p class="text-sm text-foreground">${m.email}</p>
                    <p class="text-xs text-sidebar-foreground/60 mt-0.5">${m.phone}</p>
                </td>
                <td class="px-4 py-4">
                    <div class="flex items-center gap-1.5 text-sidebar-foreground/60">
                        <i data-lucide="car" class="size-3.5"></i>
                        <span class="text-sm text-foreground">${m.vehicle}</span>
                    </div>
                    <span class="text-xs mt-1 ml-5 px-1.5 py-0.5 rounded font-mono bg-foreground/5 text-sidebar-foreground/60 border border-border inline-block">${m.licensePlate}</span>
                </td>
                <td class="px-4 py-4">
                    <span class="px-2.5 py-1 rounded-full text-xs font-semibold ${getPlanStyles(m.plan)}">${m.plan}</span>
                </td>
                <td class="px-4 py-4">
                    <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-semibold ${getStatusStyles(m.status)}">
                        <span class="w-1.5 h-1.5 rounded-full ${getStatusDotStyles(m.status)}"></span>
                        ${m.status}
                    </span>
                </td>
                <td class="px-4 py-4 text-xs text-sidebar-foreground/60">${m.joinDate}</td>
                <td class="px-4 py-4">
                    <div class="flex items-center justify-center gap-1.5">
                        <button onclick="openEditModal('${m.id}')" class="w-8 h-8 rounded-xl flex items-center justify-center bg-green-500/10 border border-green-500/20 text-green-500 hover:bg-green-500/20 transition-colors">
                            <i data-lucide="pencil" class="size-3.5"></i>
                        </button>
                        <button onclick="openDeleteConfirm('${m.id}')" class="w-8 h-8 rounded-xl flex items-center justify-center bg-red-500/10 border border-red-500/20 text-red-500 hover:bg-red-500/20 transition-colors">
                            <i data-lucide="trash" class="size-3.5"></i>
                        </button>
                    </div>
                </td>
            </tr>
        `).join('');
    }

    // Update Pagination
    if (paginationInfo) paginationInfo.innerHTML = `Showing <span class="text-foreground font-semibold">${totalItems === 0 ? 0 : start + 1}–${end}</span> of <span class="text-foreground font-semibold">${totalItems}</span>`;
    
    if (paginationControls) {
        let paginationHtml = `
            <button onclick="changePage(${currentPage - 1})" ${currentPage === 1 ? 'disabled' : ''} class="w-8 h-8 rounded-lg flex items-center justify-center border border-border bg-foreground/5 text-sidebar-foreground/60 hover:text-foreground disabled:opacity-30">
                <i data-lucide="chevron-left" class="size-4"></i>
            </button>
        `;
        
        for (let i = 1; i <= totalPages; i++) {
            paginationHtml += `
                <button onclick="changePage(${i})" class="w-8 h-8 rounded-lg flex items-center justify-center text-xs font-semibold transition-all ${i === currentPage ? 'bg-gradient-to-br from-green-600 to-green-500 text-white shadow-md shadow-green-500/20' : 'border border-border bg-foreground/5 text-sidebar-foreground/60 hover:text-foreground'}">
                    ${i}
                </button>
            `;
        }
        
        paginationHtml += `
            <button onclick="changePage(${currentPage + 1})" ${currentPage === totalPages ? 'disabled' : ''} class="w-8 h-8 rounded-lg flex items-center justify-center border border-border bg-foreground/5 text-sidebar-foreground/60 hover:text-foreground disabled:opacity-30">
                <i data-lucide="chevron-right" class="size-4"></i>
            </button>
        `;
        paginationControls.innerHTML = paginationHtml;
    }
    
    // Check if select-all should be checked
    if (selectAllCheckbox) {
        const allChecked = pagedMembers.length > 0 && pagedMembers.every(m => selectedIds.has(m.id));
        selectAllCheckbox.checked = allChecked;
        selectAllCheckbox.indeterminate = !allChecked && pagedMembers.some(m => selectedIds.has(m.id));
    }

    lucide.createIcons();
    updateBulkActions();
}

function renderTableOnly() {
    renderTable();
}

function changePage(page) {
    currentPage = page;
    renderTable();
}

function sortBy(field) {
    if (sortField === field) {
        sortDir = sortDir === "asc" ? "desc" : "asc";
    } else {
        sortField = field;
        sortDir = "asc";
    }
    renderTable();
}

function toggleRow(id) {
    if (selectedIds.has(id)) {
        selectedIds.delete(id);
    } else {
        selectedIds.add(id);
    }
    renderTable();
}

function updateBulkActions() {
    if (!bulkActions) return;
    const count = selectedIds.size;
    bulkActions.classList.toggle('hidden', count === 0);
    if (selectedCountText) selectedCountText.textContent = `${count} member${count !== 1 ? 's' : ''} selected`;
}

function clearSelection() {
    selectedIds.clear();
    renderTable();
}

// Styles Helpers
function getStatusStyles(status) {
    if (status === "Active") return "bg-green-500/10 border border-green-500/30 text-green-600 dark:text-green-400";
    if (status === "Inactive") return "bg-slate-500/10 border border-slate-500/30 text-slate-600 dark:text-slate-400";
    return "bg-red-500/10 border border-red-500/30 text-red-600 dark:text-red-400";
}
function getStatusDotStyles(status) {
    if (status === "Active") return "bg-green-500 shadow-[0_0_5px_rgba(34,197,94,0.5)]";
    if (status === "Inactive") return "bg-slate-500";
    return "bg-red-500 shadow-[0_0_5px_rgba(239,68,68,0.5)]";
}
function getPlanStyles(plan) {
    if (plan === "Monthly") return "bg-green-500/10 border border-green-500/20 text-green-600 dark:text-green-400";
    if (plan === "Quarterly") return "bg-teal-500/10 border border-teal-500/20 text-teal-600 dark:text-teal-400";
    return "bg-amber-500/10 border border-amber-500/20 text-amber-600 dark:text-amber-400";
}

// Modal Logic
const modalContainer = document.getElementById('modal-container');
const memberModal = document.getElementById('member-modal');
const deleteModal = document.getElementById('delete-modal');
const bulkDeleteModal = document.getElementById('bulk-delete-modal');
const memberForm = document.getElementById('member-form');

function openModal(type, id = null) {
    if (!modalContainer) return;
    modalContainer.classList.remove('hidden');
    document.querySelectorAll('.modal-content').forEach(m => m.classList.add('hidden'));
    
    if (type === 'add-member-modal') {
        document.getElementById('modal-title').textContent = "Add New Member";
        document.getElementById('modal-icon').setAttribute('data-lucide', 'plus');
        document.getElementById('member-id-hidden').value = "";
        if (memberForm) memberForm.reset();
        updateModalPills('Monthly', 'Active');
        memberModal.classList.remove('hidden');
    } else if (type === 'bulk-delete-modal') {
        const countEl = document.getElementById('bulk-delete-count');
        if (countEl) countEl.textContent = selectedIds.size;
        bulkDeleteModal.classList.remove('hidden');
    }
    lucide.createIcons();
}

function openEditModal(id) {
    const m = members.find(member => member.id === id);
    if (!m) return;
    
    document.getElementById('modal-title').textContent = "Edit Member";
    document.getElementById('modal-icon').setAttribute('data-lucide', 'pencil');
    document.getElementById('modal-subtitle').textContent = id;
    
    document.getElementById('member-id-hidden').value = m.id;
    document.getElementById('member-name').value = m.name;
    document.getElementById('member-email').value = m.email;
    document.getElementById('member-phone').value = m.phone;
    document.getElementById('member-vehicle').value = m.vehicle;
    document.getElementById('member-plate').value = m.licensePlate;
    
    updateModalPills(m.plan, m.status);
    
    modalContainer.classList.remove('hidden');
    document.querySelectorAll('.modal-content').forEach(m => m.classList.add('hidden'));
    memberModal.classList.remove('hidden');
    lucide.createIcons();
}

function openDeleteConfirm(id) {
    const m = members.find(member => member.id === id);
    if (!m) return;
    
    document.getElementById('delete-member-name').textContent = m.name;
    document.getElementById('confirm-delete-btn').onclick = () => deleteMember(id);
    
    modalContainer.classList.remove('hidden');
    document.querySelectorAll('.modal-content').forEach(m => m.classList.add('hidden'));
    deleteModal.classList.remove('hidden');
}

function closeModal() {
    if (modalContainer) modalContainer.classList.add('hidden');
}

function handleAdd(data) {
    const newId = `MBR-${String(members.length + 1).padStart(3, '0')}`;
    const nm = {
        id: newId,
        ...data,
        joinDate: new Date().toISOString().split('T')[0],
        isNew: true,
    };
    members.unshift(nm);
    showToast(`${nm.name} added successfully.`);
}

function handleEdit(id, data) {
    const index = members.findIndex(m => m.id === id);
    if (index !== -1) {
        members[index] = { ...members[index], ...data };
        showToast(`${data.name} updated successfully.`);
    }
}

function handleDelete(id) {
    const member = members.find(m => m.id === id);
    members = members.filter(m => m.id !== id);
    selectedIds.delete(id);
    if (member) showToast(`${member.name} removed.`, 'error');
}

function handleBulkDelete() {
    const count = selectedIds.size;
    members = members.filter(m => !selectedIds.has(m.id));
    selectedIds.clear();
    showToast(`${count} member${count > 1 ? 's' : ''} deleted.`, 'error');
}

function saveMember() {
    const id = document.getElementById('member-id-hidden').value;
    const name = document.getElementById('member-name').value;
    const email = document.getElementById('member-email').value;
    const phone = document.getElementById('member-phone').value;
    const vehicle = document.getElementById('member-vehicle').value;
    const plate = document.getElementById('member-plate').value;
    const plan = document.getElementById('member-plan').value;
    const status = document.getElementById('member-status').value;

    if (!name || !email || !phone || !vehicle || !plate) {
        showToast("Please fill all required fields.", 'error');
        return;
    }

    const data = { name, email, phone, vehicle, licensePlate: plate, plan, status };

    if (id) {
        handleEdit(id, data);
    } else {
        handleAdd(data);
    }

    closeModal();
    render();
}

function deleteMember(id) {
    handleDelete(id);
    closeModal();
    render();
}

function bulkDelete() {
    handleBulkDelete();
    closeModal();
    render();
}

function refreshData() {
    showToast("Data refreshed.");
    render();
}

// Start
init();
