pragma solidity 0.4.24;


contract TicTacToe {

    address public p1;
    address public p2;
    address public lastPlayer;
    address public winner;
    bool public gameOver;
    uint256 public takenTurns;
    
    address[9] private gameBoard_;
    
    function startGame(address _p1, address _p2) external {
        p1 = _p1;
        p2 = _p2;
    }
    
    
    function takeTurn(uint256 _boardPosition) external {
        require(!gameOver, "Sorry game has Ended.");
        require(msg.sender == p1 || msg.sender == p2, "You are not a valid player.");
        require(gameBoard_[_boardPosition] == 0, "Spot already taken!");
        require(msg.sender != lastPlayer, "This is not your turn.");
        
        gameBoard_[_boardPosition] = msg.sender;
        lastPlayer = msg.sender;
        takenTurns++;
        
        if (isWinner(msg.sender)) {
            winner = msg.sender;
            gameOver = true;      
        } else if (takenTurns == 9) {
            gameOver = true;
        }
    }
  
    function isWinner(address player) private view returns(bool) {
        uint8[3][8] memory winningSpots = [
            [0,1,2],[3,4,5],[6,7,8],  // rows
            [0,3,6],[1,4,7],[2,5,8],  // columns
            [0,4,8],[6,4,2]           // diagonals
        ];
        
        for (uint8 i = 0; i < winningSpots.length; i++) {
            uint8[3] memory filter = winningSpots[i];
            if (
                gameBoard_[filter[0]]==player &&
                gameBoard_[filter[1]]==player &&
                gameBoard_[filter[2]]==player
            ) {
                return true;
            }
        }
    }
        
    function getBoard() external view returns(address[9]) {
        return gameBoard_;
    }
}
