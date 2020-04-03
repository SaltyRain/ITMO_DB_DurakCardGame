function confirm(login, password) {
    let login2 = document.querySelector('#inviter').textContent;
    request({
        'login' : login,
        'password' : password,
        'login2' : login2,
        'func' : 'creategame'
    }, 'invite.php', _confirm);
}