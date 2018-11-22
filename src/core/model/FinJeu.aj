package core.model;

import java.util.concurrent.TimeUnit;

import core.BoardEventListener;
import core.GridEventListener;
import core.Player;
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
	
	//pointcut setGrid(Board b,Grid g) : target(b) && args(g) && execution(* *.board());
	
	pointcut fin(Grid g, Player p) : target(g) && call(* *.notifyGameOver(Player)) && args(p);
	pointcut isWon(int x,int y, int dx, int dy, Player p,Grid g): target(g)&&args(x,y,dx,dy,p)&&execution(* *.isWonBy(int,int,int,int,Player));
	
	/*after(Board b,Grid g): setGrid(b,g){
		System.out.println("test");
	}*/

	
	after(int x,int y, int dx, int dy, Player p, Grid g) returning(boolean b): isWon(x,y,dx,dy,p,g){
		if(b==true) {
			Player winner = new Player("winner", Color.BLUE);
			System.out.println("parameters : "+x+"/"+y+"/"+dx+"/"+dy);
			int a,c;
			for(int i=0;i<5;i++) {
				a=x+i*dx;
				c=y+i*dy;	
				Spot s = g.getSpot(a, c);
				//System.out.println(s.x+"/"+s.y);
				//s.clear();
				s.setOccupant(winner);
			
				//g.isOccupiedBy(a, c, winner);
				
				//Platform.
				//System.out.println(s.getOccupant().getName());
				System.out.println("Colonne / Ligne : "+a+"/"+c);	     
				//g.placeStone(a, c, winner);
			}	
			
		}
	}
	
	
	
	after(Grid g, Player p): fin(g, p){
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
