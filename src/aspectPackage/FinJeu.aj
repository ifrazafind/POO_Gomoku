package aspectPackage;

import java.util.concurrent.TimeUnit;

import core.BoardEventListener;
import core.GridEventListener;
import core.Player;
import core.model.Spot;
import javafx.application.Application;
import javafx.application.Platform;
import javafx.scene.Scene;
import javafx.scene.canvas.Canvas;
import javafx.scene.canvas.GraphicsContext;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Dialog;
import javafx.scene.layout.BorderPane;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.stage.Stage;
import ui.Board;

import java.util.ArrayList;
import java.util.List;

public aspect FinJeu {
	
	//public pointcut fin(Player p) : call(* *.gameOver(p));
	//pointcut setScene(Stage s) : call(* *.start(Stage)) && args(s);
	pointcut fin(Player p) : call(* *.notifyGameOver(Player)) && args(p);
	pointcut isWon(int x,int y, int dx, int dy, Player p): args(x,y,dx,dy,p)&&call(* *.isWonBy(int,int,int,int,Player));
	
	
	
	after(int x,int y, int dx, int dy, Player p) returning(boolean b): isWon(x,y,dx,dy,p){
		if(b==true) {
			System.out.println("parameters : "+x+"/"+y+"/"+dx+"/"+dy);
			int a,c;
			for(int i=0;i<5;i++) {
				a=x+i*dx;
				c=y+i*dy;
				System.out.println("Colonne / Ligne : "+a+"/"+c);
				//Board.this.getGraphicsContext2D();
				//Board.getGraphicsContext2D();
	            //Circle gc = new Circle();
	            //gc.setFill(Color.BLUE);
	            //double xx = 30 + a * 30; // center x
	            //double yy = 30 + c * 30; // center y
	            //double rr = 30 / 2; // radius
	            //Circle gc =new Circle(xx, yy, rr, Color.BLUE);
	            //gc.setFill(x - r, y - r, r * 2, r * 2);
	            
			}
			System.out.println("test");	
		}
		
		
	}
	
	after(Player p): fin(p){
		System.out.println("testfin");
		//Dialog dialog = new Dialog(DialogType.);
		Alert alertWinner = new Alert(AlertType.NONE, "bingoooo! " + p.getName()+" wins", ButtonType.OK);
		alertWinner.showAndWait();

		if (alertWinner.getResult() == ButtonType.OK) {
			try {
				TimeUnit.SECONDS.sleep(1);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			alertWinner = new Alert(AlertType.NONE, "fin de la partie", ButtonType.OK);
			alertWinner.showAndWait();
			if (alertWinner.getResult() == ButtonType.OK) {
				Platform.exit();
			}
		}
	}
	
}
