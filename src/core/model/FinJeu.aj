package core.model;

import java.util.concurrent.TimeUnit;


import core.Player;
import javafx.application.Platform;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.ButtonType;
import javafx.scene.paint.Color;


public aspect FinJeu {

	//public pointcut fin(Player p) : call(* *.gameOver(p));
	
	//pointcut setGrid(Board b,Grid g) : target(b) && args(g) && execution(* *.board());
	int [] a = new int [5];
	int [] c = new int [5];
	
	pointcut fin(Grid g, Player p) : target(g) && call(* *.notifyGameOver(Player)) && args(p);
	pointcut isWon(int x,int y, int dx, int dy, Player p,Grid g): target(g)&&args(x,y,dx,dy,p)&&execution(* *.isWonBy(int,int,int,int,Player));
	
	/*after(Board b,Grid g): setGrid(b,g){
		System.out.println("test");
	}*/

	
	after(int x,int y, int dx, int dy, Player p, Grid g) returning(boolean b): isWon(x,y,dx,dy,p,g){
		if(b==true) {
			System.out.println("parameters : "+x+"/"+y+"/"+dx+"/"+dy);
			for(int i=0;i<5;i++) {
				a[i] = x+i*dx;
				c[i] = y+i*dy;	
			}	
			for(int i=0;i<5;i++) {
				if (a[0] == a[1]) {
					c[i] += 1;
				}
				else
					
					a[4-i] += 1;
				System.out.println("Colonne / Ligne : "+a[4-i]+"/"+c[i]);	
			}
			
		}
	}
	
	
	
	after(Grid g, Player p): fin(g, p){
		System.out.println("testfin");
		//Dialog dialog = new Dialog(DialogType.);
		Alert alertWinner = new Alert(AlertType.NONE, "bingoooo! " + p.getName()+" wins"+ "\n" + 
				"\n Appuyer sur \"OK\" pour voir la sequence gagnante", ButtonType.OK);
		Player winner = new Player("winner", Color.BLUE);
		Player lastpoint = new Player("last", Color.BLUE);
		alertWinner.showAndWait();
		for(int i=0;i<4;i++) {
		g.placeStone(a[i],c[i] , winner);
		}
		g.placeStone(a[4], c[4], lastpoint);
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
