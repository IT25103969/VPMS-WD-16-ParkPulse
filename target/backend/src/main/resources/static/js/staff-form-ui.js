document.addEventListener('DOMContentLoaded', async () => {
  const params = new URLSearchParams(window.location.search);
  const id = params.get('id');
  
  if (id) {
    const staff = await getStaffById(id);
    if (staff) {
      document.getElementById('form-title').innerText = 'Edit Staff Member';
      document.getElementById('breadcrumb-page').innerText = `Edit — ${staff.name}`;
      document.getElementById('staff-id').value = staff.id;
      document.getElementById('name').value = staff.name;
      document.getElementById('role').value = staff.role;
      document.getElementById('status').value = staff.status;
      document.getElementById('shift').value = staff.shift;
      document.getElementById('email').value = staff.email;
      document.getElementById('phone').value = staff.phone;
      document.getElementById('joinDate').value = staff.joinDate;
      document.getElementById('address').value = staff.address;
      document.getElementById('vehicleNumber').value = staff.vehicleNumber;
      document.getElementById('vehicleType').value = staff.vehicleType;
      document.getElementById('username').value = staff.username;
      document.getElementById('password').value = staff.password;
      
      // Load existing avatar preview
      if (staff.avatar) {
        document.getElementById('avatar-preview').innerHTML = `<img src="${staff.avatar}" style="width: 100%; height: 100%; object-fit: cover;">`;
      }
    }
  }

  // Avatar preview logic
  const avatarInput = document.getElementById('avatar-input');
  const avatarPreview = document.getElementById('avatar-preview');

  avatarInput.addEventListener('change', (e) => {
    const file = e.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (event) => {
        avatarPreview.innerHTML = `<img src="${event.target.result}" style="width: 100%; height: 100%; object-fit: cover;">`;
      };
      reader.readAsDataURL(file);
    }
  });

  // Password toggle logic
  const togglePasswordBtn = document.getElementById('toggle-password');
  const passwordInput = document.getElementById('password');

  togglePasswordBtn.addEventListener('click', () => {
    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
    passwordInput.setAttribute('type', type);
    
    // Update icon
    const icon = togglePasswordBtn.querySelector('i');
    if (type === 'text') {
      icon.setAttribute('data-lucide', 'eye-off');
    } else {
      icon.setAttribute('data-lucide', 'eye');
    }
    lucide.createIcons();
  });

  const form = document.getElementById('staff-form');
  form.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    // Create FormData object for multipart/form-data
    const formData = new FormData(form);
    
    // Add the image file explicitly if selected
    if (avatarInput.files[0]) {
      formData.append('image', avatarInput.files[0]);
    }
    
    const staffId = document.getElementById('staff-id').value;
    
    try {
      if (staffId) {
        await updateStaff(staffId, formData);
      } else {
        await addStaff(formData);
      }
      window.location.href = '/staff';
    } catch (error) {
      alert(error.message);
    }
  });
});
