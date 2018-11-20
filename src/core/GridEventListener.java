package core;

import core.model.Spot;

public interface GridEventListener {
    void stonePlaced(Spot place);
    void gameOver(Player winner);
}
