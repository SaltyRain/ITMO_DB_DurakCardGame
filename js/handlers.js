/*___________ invites ____________*/

function _wait(response, obj = null) {
    let resp_ob = JSON.parse(response.responseText);
    // console.log(resp_ob);
    if(resp_ob.WAITING === 'WAITING')
        return;
    showModal('modal2');
    document.querySelector('#inviter').textContent = resp_ob.login;
}

function _invite(response, obj) {
    console.log(response.responseText);
    if(response.responseText !== "OK")
        return;
    var login2 = document.getElementById('user_login').value;
    document.querySelector('#inviter').textContent = '.';
    showModal('modal1');
    waitresponse(obj['login'], obj['password'], login2);
}

function _waitresp(response, obj = null) {
    let resp_ob = JSON.parse(response.responseText);
    // console.log(resp_ob);
    if (resp_ob.nextDeck !== 0) {
        window.location.href = "game.php?gameid=" + response.responseText;
    }
}



function _confirm(response, obj) {
    // console.log(response);
    // console.log(obj);
    let resp_ob = JSON.parse(response.responseText);
    // console.log(resp_ob);
    if (resp_ob.nextDeck !== 0) {
        window.location.href = "game.php?gameid=" + resp_ob.nextDeck;
    }
}