package core;

import javafx.scene.paint.Color;

public class Player {

    private Color color;
    private final String name;

    public Player(String name, Color color) {
        this.name = name;
        this.color = color;
    }

    public Color getColor() {
        return color;
    }
    public String getName() {
        return name;
    }

}

