

import de.bezier.guido.*;
public final static int NUM_ROWS = 20; 
public final static int NUM_COLS = 20;
public final static int NUM_BOMBS = 100; 
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++)
        for(int c = 0; c < NUM_COLS; c++)
            buttons[r][c] = new MSButton(r,c);
    
    
    setBombs();
}
public void setBombs()
{
    while(bombs.size() < NUM_BOMBS)
    {
        int r = (int)(Math.random()*NUM_ROWS);
        int c = (int)(Math.random()*NUM_COLS);
        if(!bombs.contains(buttons[r][c])) {
        bombs.add(buttons[r][c]);
        }
    }
}

public void draw ()
{
    fill( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    int countB = 0;
    for(int r = 0; r < buttons.length; r++){
        for(int c = 0; c < buttons[0].length; c++){
                if(buttons[r][c].isClicked() == true || buttons[r][c].isMarked()==true){
                    countB = countB+1;
                }
             }   
    }
    if(countB == (NUM_ROWS * NUM_COLS - NUM_BOMBS))
        return true;

    return false;
}
public void displayLosingMessage()
{
      
    buttons[9][8].setLabel("Y");
    buttons[9][9].setLabel("O");
    buttons[9][10].setLabel("U");
    buttons[10][8].setLabel("L");
    buttons[10][9].setLabel("O");
    buttons[10][10].setLabel("S");
    buttons[10][11].setLabel("E");
    //noLoop();
}
public void displayWinningMessage()
{
    
    buttons[9][8].setLabel("Y");
    buttons[9][9].setLabel("O");
    buttons[9][10].setLabel("U");
    buttons[10][8].setLabel("W");
    buttons[10][9].setLabel("I");
    buttons[10][10].setLabel("N");
    //noLoop();
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager

    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT){
            if(buttons[r][c].isMarked() == false){
                marked = true;
            }
            else{
               marked = false; 
               clicked = false;         
            }
         }else if(clicked && bombs.contains(this)==true){
            displayLosingMessage();
         }else if (countBombs(r,c) > 0) {
            String name = "" + countBombs(r,c);
             setLabel(name);
         }else{
            if(isValid(r,c+1) == true && buttons[r][c+1].isClicked()==false )
                buttons[r][c+1].mousePressed();
            if(isValid(r,c-1) == true && buttons[r][c-1].isClicked()==false)
                buttons[r][c-1].mousePressed();
            if(isValid(r+1,c+1) == true && buttons[r+1][c+1].isClicked()==false)
                buttons[r+1][c+1].mousePressed();
            if(isValid(r+1,c) == true && buttons[r+1][c].isClicked()==false)
                buttons[r+1][c].mousePressed();
            if(isValid(r+1,c-1) == true && buttons[r+1][c-1].isClicked()==false)
                buttons[r+1][c-1].mousePressed();
            if(isValid(r-1,c+1) == true && buttons[r-1][c+1].isClicked()==false)
                 buttons[r-1][c+1].mousePressed();
            if(isValid(r-1,c) == true && buttons[r-1][c].isClicked()==false)
                buttons[r-1][c].mousePressed();
            if(isValid(r-1,c-1) == true && buttons[r-1][c-1].isClicked()==false)
                 buttons[r-1][c-1].mousePressed();
         }   
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r < NUM_ROWS && r>=0 && c <NUM_COLS && c >=0)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
            if(isValid(row,col+1) == true && bombs.contains(buttons[row][col+1])==true )
                numBombs = numBombs+1;
            if(isValid(row,col-1) == true && bombs.contains(buttons[row][col-1])==true)
                numBombs = numBombs+1;
            if(isValid(row+1,col+1) == true && bombs.contains(buttons[row+1][col+1])==true)
                numBombs = numBombs+1;
            if(isValid(row+1,col) == true &&bombs.contains(buttons[row+1][col])==true)
                numBombs = numBombs+1;
            if(isValid(row+1,col-1) == true && bombs.contains(buttons[row+1][col-1])==true)
                numBombs = numBombs+1;
            if(isValid(row-1,col+1) == true && bombs.contains(buttons[row-1][col+1])==true)
                 numBombs = numBombs+1;
            if(isValid(row-1,col) == true && bombs.contains(buttons[row-1][col])==true)
                numBombs = numBombs+1;
            if(isValid(row-1,col-1) == true &&bombs.contains(buttons[row-1][col-1])==true)
                 numBombs = numBombs+1;
        return numBombs;
    }
}



