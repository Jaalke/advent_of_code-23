package advent;

public class Game {
    private int minRedCubes;
    private int minGreenCubes;
    private int minBlueCubes;
    private int gameId;

    public Game(String line) {
        minRedCubes = 1;
        minGreenCubes = 1;
        minBlueCubes = 1;

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
                        break;
                    case "green":
                        if (numberOf > minGreenCubes) {
                            this.minGreenCubes = numberOf;
                        }
                        break;
                    case "blue":
                        if (numberOf > minBlueCubes) {
                            this.minBlueCubes = numberOf;
                        }
                        break;
                }
            }
        }
    }

    public int getMinRedCubes() {
        return this.minRedCubes;
    }

    public int getMinGreenCubes() {
        return this.minGreenCubes;
    }

    public int getMinBlueCubes() {
        return this.minBlueCubes;
    }

    public int getGameId() {
        return this.gameId;
    }

    public void setMinRedCubes(int minRedCubes) {
        this.minRedCubes = minRedCubes;
    }

    public void setMinGreenCubes(int minGreenCubes) {
        this.minGreenCubes = minGreenCubes;
    }

    public void setMinBlueCubes(int minBlueCubes) {
        this.minBlueCubes = minBlueCubes;
    }

    public void setGameId(int gameId) {
        this.gameId = gameId;
    }

    public boolean isPossible(int redCubes, int greenCubes, int blueCubes) {
        boolean redPossible = redCubes >= minRedCubes;
        boolean greenPossible = greenCubes >= minGreenCubes;
        boolean bluePossible = blueCubes >= minBlueCubes;
        return redPossible && greenPossible && bluePossible;
    }
    
    public int getPowerOfSet() {
        return (this.minRedCubes * this.minGreenCubes * this.minBlueCubes);
    }
}
