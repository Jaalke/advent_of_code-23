package advent;

import java.io.*;
import java.util.*;

public class PartTwo {
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

    int sumOfPowers = 0;
    for (Game game : games) {
        System.out.println(game.getPowerOfSet());
        sumOfPowers += game.getPowerOfSet();
    }

    System.out.println(String.format("The sum of powers of all the cube sets is %d.", 
    sumOfPowers));
    }
} 
