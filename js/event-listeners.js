(function() {
    let handCardsArray = document.querySelectorAll('.hand__card');
    handCardsArray.forEach(function(handCard) {
        handCard.addEventListener('click', function(evt) {
            //убираем активный класс у всех карт
            let activeCardsArray = document.querySelectorAll('.hand-card-active');
            let activeCard = evt.target;
            if (activeCardsArray.length !== 0) {
                activeCardsArray.forEach(function(actvCard) {
                    activeCard.classList.remove("hand-card-active");
                });

            };
            //добавление нажатой карте класс active
            activeCard.classList.add('hand-card-active');
            // alert(document.querySelector('.hand-card-active').id);
            // chooseMove(LOGIN, PASSWORD, GAMEID); 
            chooseMove(activeCard.id);
        });
    });
})();

(function() {
    let okButton = document.querySelector('#okButton');
    okButton.addEventListener('click', function() {
        okButton.classList.add("ok-active");
        // console.log(okButton);
        // switchRole();
        // moveResult(LOGIN, PASSWORD, OPONENTID, PLAYERID);
        moveResult();
    });
})();

(function() {
    let passButton = document.querySelector('#passButton');
    passButton.addEventListener('click', function() {
        passButton.classList.add("pass-active");

        defendMove(-1);
        
    });
})();


