package core.model;

import core.Player;

public class Spot {

    public final int x, y;

    private Player occupant;

    Spot(int x, int y) {
        this.x = x;
        this.y = y;
    }

    void clear() {
        occupant = null;
    }

    void setOccupant(Player player) {
        this.occupant = player;
    }

    public Player getOccupant() {
        return occupant;
    }

    public boolean isOccupant(Player player) {
        return occupant == player;
    }

    public boolean isEmpty() {
        return occupant == null;
    }

    @Override
    public String toString() {
        return x + " " + y;
    }
}
