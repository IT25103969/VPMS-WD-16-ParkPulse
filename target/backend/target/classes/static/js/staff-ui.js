let activeTab = 'all';
let searchQuery = '';
let confirmDeleteId = null;

const COLOR_PALETTE = ["#2563eb", "#7c3aed", "#0891b2", "#059669", "#d97706", "#dc2626", "#db2777"];
function getAvatarColor(id) { return COLOR_PALETTE[id % COLOR_PALETTE.length]; }
function getInitials(name) { return name.split(" ").map((n) => n[0]).join("").toUpperCase().slice(0, 2); }

async function renderStaffCards() {
  // All filtering and search calculations are now performed on the backend
  const filtered = await getStaffList(searchQuery, activeTab);
  const container = document.getElementById('staff-grid');
  if (!container) return;

  if (filtered.length === 0) {
    container.innerHTML = `
      <div class="flex flex-col items-center justify-center rounded-xl col-span-full" style="height: 200px; color: var(--text-sub); font-size: 14px;">
        <i data-lucide="users" style="width: 32px; height: 32px; margin-bottom: 10px; opacity: 0.4;"></i>
        ${searchQuery ? "No staff matching your search." : "No staff members yet."}
      </div>
    `;
    lucide.createIcons();
    return;
  }

  container.innerHTML = filtered.map(staff => `
    <div
      class="rounded-xl p-4 flex flex-col gap-3 staff-card"
      style="background: var(--card-alt); border: 1px solid var(--border); transition: border-color 0.15s, box-shadow 0.15s; cursor: pointer;"
      onclick="window.location.href='/staff_detail?id=${staff.id}'"
    >
      <div class="flex items-start gap-3">
        <div
          class="flex items-center justify-center rounded-full flex-shrink-0"
          style="width: 40px; height: 40px; background: ${staff.avatar ? 'transparent' : getAvatarColor(staff.id)}; fontSize: 14px; color: #fff; font-weight: 700; overflow: hidden; border: ${staff.avatar ? '1px solid var(--border)' : 'none'};"
        >
          ${staff.avatar
            ? `<img src="${staff.avatar}" alt="${staff.name}" style="width: 100%; height: 100%; object-fit: cover; display: block;" />`
            : getInitials(staff.name)
          }
        </div>
        <div class="flex-1 min-w-0">
          <p style="color: var(--text); font-size: 14px; font-weight: 600; line-height: 1.3;">${staff.name}</p>
          <p style="color: var(--text-sub); font-size: 12px;">${staff.role}</p>
        </div>
        <span
          style="padding: 2px 8px; border-radius: 20px; font-size: 11px; font-weight: 600; background: ${staff.status === 'Active' ? 'rgba(34,197,94,0.15)' : 'rgba(239,68,68,0.15)'}; color: ${staff.status === 'Active' ? '#16a34a' : '#dc2626'}; white-space: nowrap; flex-shrink: 0;"
        >
          ${staff.status}
        </span>
      </div>

      <div class="space-y-1.5">
        <div class="flex items-center gap-2">
          <i data-lucide="clock" style="width: 11px; height: 11px; color: var(--text-sub);"></i>
          <span style="color: var(--text-sub); font-size: 11px;">${staff.shift}</span>
        </div>
        ${staff.email ? `
          <div class="flex items-center gap-2">
            <i data-lucide="mail" style="width: 11px; height: 11px; color: var(--text-sub);"></i>
            <span style="color: var(--text-sub); font-size: 11px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
              ${staff.email}
            </span>
          </div>
        ` : ''}
        ${staff.phone ? `
          <div class="flex items-center gap-2">
            <i data-lucide="phone" style="width: 11px; height: 11px; color: var(--text-sub);"></i>
            <span style="color: var(--text-sub); font-size: 11px;">${staff.phone}</span>
          </div>
        ` : ''}
        ${staff.joinDate ? `
          <div class="flex items-center gap-2">
            <i data-lucide="calendar" style="width: 11px; height: 11px; color: var(--text-sub);"></i>
            <span style="color: var(--text-sub); font-size: 11px;">Joined ${staff.joinDate}</span>
          </div>
        ` : ''}
      </div>

      <div style="border-top: 1px solid var(--border); padding-top: 10px;">
        <div class="flex items-center gap-2" id="card-actions-${staff.id}">
          <button
            onclick="event.stopPropagation(); window.location.href='/staff_form?id=${staff.id}'"
            class="flex items-center gap-1.5 px-3 py-1.5 rounded-lg flex-1 justify-center"
            style="background: rgba(37,99,235,0.12); color: #2563eb; border: 1px solid rgba(37,99,235,0.25); cursor: pointer; font-size: 12px; font-weight: 500;"
          >
            <i data-lucide="pencil" style="width: 11px; height: 11px;"></i> Edit
          </button>
          <button
            onclick="event.stopPropagation(); showConfirmDelete(${staff.id})"
            class="flex items-center gap-1.5 px-3 py-1.5 rounded-lg flex-1 justify-center"
            style="background: rgba(239,68,68,0.12); color: #dc2626; border: 1px solid rgba(239,68,68,0.25); cursor: pointer; font-size: 12px; font-weight: 500;"
          >
            <i data-lucide="trash-2" style="width: 11px; height: 11px;"></i> Delete
          </button>
        </div>
        <div class="flex items-center gap-2 hidden" id="confirm-delete-${staff.id}" onclick="event.stopPropagation()">
          <span style="color: #dc2626; font-size: 12px; flex: 1;">Confirm delete?</span>
          <button
            onclick="handleDelete(${staff.id})"
            style="background: rgba(239,68,68,0.15); color: #dc2626; border: none; cursor: pointer; padding: 4px 10px; border-radius: 6px; font-size: 12px;"
          >Yes</button>
          <button
            onclick="cancelDelete(${staff.id})"
            style="background: var(--hover); color: var(--text-sub); border: none; cursor: pointer; padding: 4px 10px; border-radius: 6px; font-size: 12px;"
          >No</button>
        </div>
      </div>
    </div>
  `).join('');

  lucide.createIcons();
}

async function updateStats() {
  // Statistics calculations are now performed on the backend
  const stats = await getStaffStats();
  document.getElementById('stat-total').innerText = stats.total;
  document.getElementById('stat-active').innerText = stats.active;
  document.getElementById('stat-offduty').innerText = stats.offDuty;
}

async function setTab(tab) {
  activeTab = tab;
  document.querySelectorAll('.tab-btn').forEach(btn => {
    if (btn.dataset.tab === tab) {
      btn.style.background = '#2563eb';
      btn.style.color = '#fff';
      btn.style.fontWeight = '600';
    } else {
      btn.style.background = 'transparent';
      btn.style.color = 'var(--text-sub)';
      btn.style.fontWeight = '400';
    }
  });
  await renderStaffCards();
}

async function handleSearch(e) {
  searchQuery = e.target.value;
  await renderStaffCards();
}

function showConfirmDelete(id) {
  document.getElementById(`card-actions-${id}`).classList.add('hidden');
  document.getElementById(`confirm-delete-${id}`).classList.remove('hidden');
}

function cancelDelete(id) {
  document.getElementById(`card-actions-${id}`).classList.remove('hidden');
  document.getElementById(`confirm-delete-${id}`).classList.add('hidden');
}

async function handleDelete(id) {
  await deleteStaff(id);
  await updateStats();
  await renderStaffCards();
}

document.addEventListener('DOMContentLoaded', async () => {
  const searchInput = document.getElementById('staff-search');
  if (searchInput) {
    searchInput.addEventListener('input', handleSearch);
  }
  
  await updateStats();
  await renderStaffCards();
});
