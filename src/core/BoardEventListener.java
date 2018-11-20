package core;

import core.model.Spot;

public interface BoardEventListener {
    void spotClicked(Spot place);
}
