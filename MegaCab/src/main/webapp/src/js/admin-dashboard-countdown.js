let countdown = 10;
const timerDisplay = document.getElementById("timer");

const countdownInterval = setInterval(function() {
    countdown--;
    if (document.getElementById("timer")) {
        document.getElementById("timer").innerText = "Session expires in " + countdown + " seconds.";
    }
    if (countdown <= 0) {
        clearInterval(countdownInterval);
        window.location.href = "AdminLogoutServlet";
    }
}, 1000);

//Reset the timer on user activity
document.addEventListener("mousemove", resetTimer);
document.addEventListener("keypress", resetTimer);
function resetTimer() {
    countdown = 10;
}