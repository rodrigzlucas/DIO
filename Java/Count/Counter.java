import java.util.Locale;
import java.util.Scanner;

public class Counter {
    public static void main(String[] args) {
        Scanner terminal = new Scanner(System.in).useLocale(Locale.US);

        System.out.println("Digite o primeiro parâmetro");
        int paramOne = terminal.nextInt();

        System.out.println("Digite o segundo parâmetro");
        int paramTwo = terminal.nextInt();

        terminal.close();

        try {
            counter(paramOne, paramTwo);
        } catch (ParamsInvalidException exception) {
            System.out.println(exception.getMessage());
        }
    }

    public static void counter(int paramOne, int paramTwo) throws ParamsInvalidException {
        if (paramOne > paramTwo) {
            throw new ParamsInvalidException("O primeiro valor é maior que o segunda valor.");
        } else {
            int count = paramTwo - paramOne;
            for (int i = 1; i <= count; i++) {
                System.out.println(i);
            }
        }

    }
}
