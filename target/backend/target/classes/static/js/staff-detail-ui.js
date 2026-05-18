document.addEventListener('DOMContentLoaded', async () => {
  const params = new URLSearchParams(window.location.search);
  const id = params.get('id');
  if (!id) {
    window.location.href = '/staff';
    return;
  }

  const staff = await getStaffById(id);
  if (!staff) {
    window.location.href = '/staff';
    return;
  }

  renderStaffDetails(staff);
});

const COLOR_PALETTE = ["#2563eb", "#7c3aed", "#0891b2", "#059669", "#d97706", "#dc2626", "#db2777"];
function getAvatarColor(id) { return COLOR_PALETTE[id % COLOR_PALETTE.length]; }
function getInitials(name) { return name.split(" ").map((n) => n[0]).join("").toUpperCase().slice(0, 2); }

function renderStaffDetails(staff) {
  document.getElementById('detail-name').innerText = staff.name;
  document.getElementById('detail-role').innerText = staff.role;
  document.getElementById('detail-status').innerText = staff.status;
  document.getElementById('detail-status').style.background = staff.status === 'Active' ? 'rgba(34,197,94,0.15)' : 'rgba(239,68,68,0.15)';
  document.getElementById('detail-status').style.color = staff.status === 'Active' ? '#16a34a' : '#dc2626';
  
  const avatarContainer = document.getElementById('detail-avatar');
  avatarContainer.style.background = staff.avatar ? 'transparent' : getAvatarColor(staff.id);
  if (staff.avatar) {
    avatarContainer.innerHTML = `<img src="${staff.avatar}" alt="${staff.name}" style="width: 100%; height: 100%; object-fit: cover; display: block;" />`;
  } else {
    avatarContainer.innerText = getInitials(staff.name);
    avatarContainer.style.color = '#fff';
    avatarContainer.style.display = 'flex';
    avatarContainer.style.alignItems = 'center';
    avatarContainer.style.justifyContent = 'center';
    avatarContainer.style.fontSize = '24px';
    avatarContainer.style.fontWeight = '700';
  }

  document.getElementById('info-email').innerText = staff.email || '—';
  document.getElementById('info-phone').innerText = staff.phone || '—';
  document.getElementById('info-shift').innerText = staff.shift || '—';
  document.getElementById('info-join-date').innerText = staff.joinDate || '—';
  document.getElementById('info-address').innerText = staff.address || '—';
  document.getElementById('info-vehicle-number').innerText = staff.vehicleNumber || '—';
  document.getElementById('info-vehicle-type').innerText = staff.vehicleType || '—';
  document.getElementById('info-username').innerText = staff.username || '—';

  // Setup Edit button
  document.getElementById('edit-btn').onclick = () => {
    window.location.href = `/staff_form?id=${staff.id}`;
  };

  // Setup Delete button
  document.getElementById('delete-btn').onclick = () => {
    document.getElementById('delete-actions').classList.remove('hidden');
    document.getElementById('main-actions').classList.add('hidden');
  };

  document.getElementById('cancel-delete-btn').onclick = () => {
    document.getElementById('delete-actions').classList.add('hidden');
    document.getElementById('main-actions').classList.remove('hidden');
  };

  document.getElementById('confirm-delete-btn').onclick = async () => {
    await deleteStaff(staff.id);
    window.location.href = '/staff';
  };
}
