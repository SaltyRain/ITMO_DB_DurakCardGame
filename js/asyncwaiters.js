function waitinvite(login, password) {
    setInterval(function() {
        if(document.querySelector('#inviter').textContent != '')
            return;
        request(
            {'login' : login,
             'password' : password,
             'func' : 'invitelistener'},
            'invite.php', _wait);
    }, 1500);
}

function waitresponse(login, password, login2) {
    setInterval(function() {
        request(
            {'login' : login,
             'password' : password,
             'login2' : login2,
             'func' : 'waitresponse'},
        'invite.php', _waitresp);
    }, 1500);
}