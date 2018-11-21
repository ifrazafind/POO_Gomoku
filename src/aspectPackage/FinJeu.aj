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

	public pointcut fin() : call(* *.gameOver(..));
	
	after(): fin(){
		System.out.println("testfin");
		//Dialog dialog = new Dialog(DialogType.);
		Alert alert = new Alert(AlertType.CONFIRMATION, "message", ButtonType.YES);
		alert.showAndWait();

		if (alert.getResult() == ButtonType.YES) {
		    Platform.exit();
		}
	}
	
}