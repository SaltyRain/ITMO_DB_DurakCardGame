function invite(login, password) {
    let login2 = document.querySelector('#user_login').value;
    request({
        'login' : login,
        'password' : password,
        'login2' : login2,
        'func' : 'invite'
    }, 'invite.php', _invite);
}