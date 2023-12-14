import java.io.*;
import java.util.*;

class Game {
    int minRedCubes;
    int minGreenCubes;
    int minBlueCubes;
    int gameId;

    public Game(String line) {
        minRedCubes = 0;
        minGreenCubes = 0;
        minBlueCubes = 0;

        line = line.substring(5);
        this.gameId = Integer.parseInt(line.split(":\\s")[0]);
        for (String peek : line.split(":\\s")[1].split(";\\s")) {
            for (String cubePeek : peek.split(",\\s", 0)) {
                String cube = cubePeek.split("\\s")[1];
                int numberOf = Integer.parseInt(cubePeek.split(" ")[0]);
                switch (cube) {
                    case "red":
                        if (numberOf > minRedCubes) {
                            this.minRedCubes = numberOf;
                        }
                    case "green":
                        if (numberOf > minGreenCubes) {
                            this.minGreenCubes = numberOf;
                        }
                    case "blue":
                        if (numberOf > minBlueCubes) {
                            this.minBlueCubes = numberOf;
                        }
                        break;
                }
            }
        }
    }

    boolean isPossible(int redCubes, int greenCubes, int blueCubes) {
        boolean redPossible = redCubes >= minRedCubes;
        boolean greenPossible = greenCubes >= minGreenCubes;
        boolean bluePossible = blueCubes >= minBlueCubes;
        return redPossible && greenPossible && bluePossible;
    }
}

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
            sumOfPossibleIds += game.gameId;
            }
        }
    System.out.println(String.format("The sum of IDs of possible games is %d.", 
    sumOfPossibleIds));
    }
}