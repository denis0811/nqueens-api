package org.example.NQueensAPI;

import io.javalin.Javalin;
import java.util.List;
import io.javalin.http.Header;

public class NQueensAPI {

    public static void main(String[] args) {
        NQueensSolver solver = new NQueensSolver();

        Javalin app = Javalin.create(config -> {
            // This is the important part to allow requests from the browser
            config.plugins.enableCors(cors -> {
                cors.add(it -> {
                    it.anyHost(); // This allows requests from all hosts
                });
            });
        }).start(7000);

        app.get("/solutions/{id}", ctx -> {
            try {
                int solutionId = Integer.parseInt(ctx.pathParam("id"));
                int solutionIndex = solutionId - 1;

                List<Integer> solution = solver.getSolution(solutionIndex);

                if (solution != null) {
                    ctx.json(solution);
                } else {
                    ctx.status(404).result("Error: There are only " + solver.getSolutionCount() + " solutions. " + solutionId + " is out of range.");
                }
            } catch (NumberFormatException e) {
                ctx.status(400).result("Error: Please provide a valid number.");
            }
        });
    }
}