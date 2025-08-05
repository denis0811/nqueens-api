package org.example.NQueensAPI;

import java.util.ArrayList;
import java.util.List;

public class NQueensSolver {

    private static final int N = 8;
    private int[] board = new int[N];
    private List<List<Integer>> solutions = new ArrayList<>();
    private boolean[] columnsUsed = new boolean[N];
    private boolean[] mainDiagonalsUsed = new boolean[2 * N - 1];
    private boolean[] antiDiagonalsUsed = new boolean[2 * N - 1];

    public NQueensSolver() {
        // Find all solutions when the solver is created
        solve(0);
    }

    public int getSolutionCount() {
        return solutions.size();
    }

    public List<Integer> getSolution(int index) {
        if (index >= 0 && index < solutions.size()) {
            return solutions.get(index);
        }
        return null;
    }

    private void solve(int row) {
        if (row == N) {
            storeSolution();
            return;
        }
        for (int col = 0; col < N; col++) {
            if (!columnsUsed[col] &&
                    !mainDiagonalsUsed[row + col] &&
                    !antiDiagonalsUsed[row - col + N - 1]) {
                board[row] = col;
                columnsUsed[col] = true;
                mainDiagonalsUsed[row + col] = true;
                antiDiagonalsUsed[row - col + N - 1] = true;
                solve(row + 1);
                columnsUsed[col] = false;
                mainDiagonalsUsed[row + col] = false;
                antiDiagonalsUsed[row - col + N - 1] = false;
            }
        }
    }

    private void storeSolution() {
        List<Integer> solution = new ArrayList<>();
        for (int col : board) {
            solution.add(col);
        }
        solutions.add(solution);
    }
}