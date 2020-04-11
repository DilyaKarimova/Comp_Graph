import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class RLE {

    public void compress(String source, String dis) {
        try {
            FileInputStream in = new FileInputStream(source); //открываем файл на чтение
            FileOutputStream out = new FileOutputStream(dis); //открываем файл на запись байтов
            int next = 0;
            int count = in.read(); // читаем входной файл
            while ((next = in.read()) >= 0) {//выполняется пока не закончился файл
                int counter = 1;// количество повторений
                if (count == next) {//если то же самое
                    counter++;
                    while (next == (count = in.read())) {//подсчет количества повторений
                        counter++;
                    }
                    while (counter >= 63) {     // Случаи, когда число повторений больше 63
                        out.write(255);      // (192 + 63）
                        out.write(next);
                        System.out.println("Более 63 случаев"+(0xc0+63)+" "+count);
                        counter -= 63;//Минус 63 байта обработки
                    }
                    if (counter > 1) {//Обработка оставшихся байтов
                        out.write(0xc0 + counter);
                        out.write(next);
                        System.out.println(("Повторите для остальных "+0xc0 +" " + counter) + " " + counter);
                    }
                } else {
                    if (count <= 0xc0) {      // Не повторяйте случаи менее 192
                        System.out.println(count + " a "); //
                        out.write(count);
                        count = next;
                    } else {//Не повторяйте случаи, когда больше 192
                        out.write(0xc1);
                        out.write(count);
                        count = next;
                        System.out.println((0xc1) + count + " bbb ");
                    }
                }
            }
            if (count <= 0xc0) {      // Обработка последнего байта
                System.out.println(count);
                out.write(count);
            } else {
                out.write(0xc1);
                out.write(count);
                System.out.println((0xc1) + count);
            }
            in.close();//Закрытие входного потока
            out.close();//Закрыть выходной поток
        } catch (IOException e) {
        }
    }

    public void decompress(String source, String dis) {
        try {
            FileInputStream in = new FileInputStream(source);
            FileOutputStream out = new FileOutputStream(dis);
            int count = 0;
            while ((count = in.read()) >= 0) {
                if (count == 0xc1) { // 0xc1 ==
                    out.write(in.read());
                } else if (count <= 0xc0) { //0xc0 == 48
                    out.write(count);
                } else if (count > 0xc1) {
                    int next = in.read();
                    for (int i = 0; i < (count - 0xc0); i++) {
                        out.write(next);
                    }
                }
            }
        } catch (Exception e) {
            e.getStackTrace();
        }
    }

    public static void main(String[] args) {
        new RLE().compress("/Users/grigoriy/Desktop/Dilkar/RLE/input.png", "compressed.txt"); //Сжатие до 456.cjj,
        System.out.println("Sborka -----------------------");
        new RLE().decompress("compressed.txt", "output.png");
    }
}
