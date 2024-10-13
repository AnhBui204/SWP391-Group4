
const sideMenu = document.querySelector('aside');
const menuBtn = document.querySelector('#menu_bar');
const closeBtn = document.querySelector('#close_btn');

menuBtn.addEventListener('click', ()=>{
    sideMenu.style.display = "block";
});

closeBtn.addEventListener('click', ()=>{
    sideMenu.style.display = "none";
});

// Get elements
const themeToggler = document.querySelector('.theme-toggler');

// Function to apply dark mode based on user preference
function applyDarkModePreference() {
    const darkModeEnabled = localStorage.getItem('darkMode') === 'enabled';
    
    if (darkModeEnabled) {
        document.body.classList.add('dark-theme-variables');
        themeToggler.querySelector('span:nth-child(1)').classList.remove('active'); // light_mode
        themeToggler.querySelector('span:nth-child(2)').classList.add('active'); // dark_mode
    } else {
        document.body.classList.remove('dark-theme-variables');
        themeToggler.querySelector('span:nth-child(1)').classList.add('active'); // light_mode
        themeToggler.querySelector('span:nth-child(2)').classList.remove('active'); // dark_mode
    }
}

// Apply dark mode on page load based on saved preference
applyDarkModePreference();

// Event listener for toggling dark mode
themeToggler.addEventListener('click', () => {
    const darkModeEnabled = document.body.classList.toggle('dark-theme-variables');
    
    // Toggle active class on theme icons
    themeToggler.querySelector('span:nth-child(1)').classList.toggle('active'); // light_mode
    themeToggler.querySelector('span:nth-child(2)').classList.toggle('active'); // dark_mode

    // Save the dark mode preference
    if (darkModeEnabled) {
        localStorage.setItem('darkMode', 'enabled');
    } else {
        localStorage.setItem('darkMode', 'disabled');
    }
});
