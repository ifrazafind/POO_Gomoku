package aspectPackage;

import core.Player;
import javafx.application.Application;
import javafx.application.Platform;
import javafx.scene.Scene;
import javafx.scene.canvas.Canvas;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Dialog;
import javafx.scene.layout.BorderPane;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

public aspect FinJeu {
	
	//public pointcut fin(Player p) : call(* *.gameOver(p));
	public pointcut fin(Player p) : call(* *.gameOver(Player)) && args(p);
	after(Player p): fin(p){
		System.out.println("testfin");
		//Dialog dialog = new Dialog(DialogType.);
		Alert alert = new Alert(AlertType.NONE, "bingoooo! " + p.getName()+" wins", ButtonType.YES);
		alert.showAndWait();

		if (alert.getResult() == ButtonType.YES) {
		    Platform.exit();
		}
	}
	
}
