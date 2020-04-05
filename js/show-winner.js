function showWinner(winnerId) {
    if (window.myId === winnerId) {
        alert('Конец игры. Вы победили!');
    }
    else {
        alert('Конец игры. Вы проиграли!');
    }
    if (winnerId === 0) {
        alert('Ошибка с определением победителя');
    }
        
}