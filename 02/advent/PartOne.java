package advent;

import java.io.*;
import java.util.*;

public class PartOne {
    public static void main(String[] args) throws IOException{
        BufferedReader input = null;
        ArrayList<Game> games = new ArrayList<Game>();

        try {
            input = new BufferedReader(new FileReader("input.txt"));
            String line;
            while ((line = input.readLine()) != null) {
                games.add(new Game(line));
            }
        } finally {
            if (input != null) {
                input.close();
            }
        }

    int sumOfPossibleIds = 0;
    for (Game game : games) {
        if (game.isPossible(12, 13, 14)) {
            sumOfPossibleIds += game.getGameId();
        }
    }
    
    System.out.println(String.format("The sum of IDs of possible games is %d.", 
    sumOfPossibleIds));
    }
}