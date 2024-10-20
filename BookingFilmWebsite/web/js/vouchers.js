document.addEventListener('DOMContentLoaded', function () {
    const section = document.querySelector('section');
    let scrollAmount = 0;
    
    function autoScroll() {
        scrollAmount += 2; // Adjust the speed of scroll here
        section.scrollLeft = scrollAmount;
        
        // If we've scrolled to the end, reset scrollAmount
        if (scrollAmount >= section.scrollWidth - section.clientWidth) {
            scrollAmount = 0;
        }
    }

    setInterval(autoScroll, 50); // Adjust the interval for scroll speed
});
