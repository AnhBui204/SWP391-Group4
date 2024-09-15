package Model;

import java.util.ArrayList; // Import ArrayList because it's from the java.util package

public class test {
    public static void main(String[] a) {
        ArrayList<User> list = UserDB.listAllUsers();
        for (User user : list) {
            System.out.println(user);
        }
    }
}
