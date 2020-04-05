function showPass() {
    if (document.getElementById('hideMe') !== null) {
        document.getElementById('hideMe').remove();
    }
        
    const passMessage = document.createElement('div');
    passMessage.className = 'pass-message';
    passMessage.id = 'hideMe';
    passMessage.textContent = 'Пас';

    document.querySelector('.pass-message-section').append(passMessage);
}