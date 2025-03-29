import java.util.Scanner;
import java.util.Locale;

public class Account {
    private Integer number;
    private String agency;
    private String clientName;
    private Double balance;

    public Account() {
        this.balance = 0.0;
    }

    private String validateInfo(String value) {
        Scanner sc = new Scanner(System.in).useLocale(Locale.US);
        String valid = value;
        do {
            try {
                if (valid == null || valid.trim().isEmpty()) {
                    throw new ExceptionAccount("Dados inválidos.");
                }
                break;
            } catch (ExceptionAccount e) {
                System.out.println(e.getMessage());
            }
            System.out.println("Digite novamente, lembre-se, informações com valores vázios ou nulos não são aceitos:");
            valid = sc.nextLine();
        } while (true);
        return valid;
    }

    private Double validateBalance(Double balance) {
        Scanner sc = new Scanner(System.in).useLocale(Locale.US);
        Double valid = balance;
        do {
            try {
                if (valid < 0) {
                    throw new ExceptionAccount("Você não pode depositar um valor negativo!");
                }
                break;
            } catch (ExceptionAccount e) {
                System.out.println(e.getMessage());
            }
            System.out.println("Digite novamente o valor do depósito!");
            valid = sc.nextDouble();
        } while (true);
        return valid;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String getAgency() {
        return agency;
    }

    public void setAgency(String agency) {
        this.agency = validateInfo(agency);
    }

    public String getClientName() {
        return clientName;
    }

    public void setClientName(String clientName) {
        this.clientName = validateInfo(clientName);
    }

    public Double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = validateBalance(balance);
    }

    public void messageUser() {
        System.out.println(
                "Olá " + clientName + ", " +
                        "obrigado por criar uma conta em nosso banco," +
                        " sua agência é " + agency +
                        ", conta " + number +
                        " e seu saldo " + balance +
                        " já está disponível para saque."
        );
    }

}
