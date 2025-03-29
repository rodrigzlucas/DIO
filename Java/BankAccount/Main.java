import java.util.Locale;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        Account account = new Account();
        Scanner sc = new Scanner(System.in).useLocale(Locale.US);

        System.out.println("Por favor, digite o nome do cliente!");
        String clientName = sc.nextLine();
        account.setClientName(clientName);

        System.out.println("Por favor, digite o número da conta");
        int number = sc.nextInt();
        account.setNumber(number);

        System.out.println("Por favor, digite o número da agência");
        String agency = sc.next();
        account.setAgency(agency);

        System.out.println("Por favor, deposite um valor na sua conta!");
        double balance = sc.nextDouble();
        account.setBalance(balance);

        account.messageUser();

        sc.close();
    }
}
