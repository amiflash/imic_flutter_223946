/*
2. Hãy viết một class về nhân viên với các đặc tính sau:
+ Tên nhân viên
+ Họ của nhân viên
+ Lương cơ bản
+ Một mảng doanh số theo tháng (quy ước từ tháng 1 đến tháng 12 tương ứng
với giá trị của index từ 0 tới 11)
+ Số năm làm việc
+ Số ngày phép cơ bản trong 1 năm
+ Số ngày phép đã nghỉ
+ Hãy viết các hàm sau trong class này:
- Hàm trả về tên họ đầy đủ của nhân viên
- Hàm trả về lương của nhân viên theo tháng với quy tắc: Lương cơ bản cộng thêm % doanh số. Số cộng thêm là 10% doanh số nếu doanh số đạt 50tr đến nhỏ hơn 200tr, cộng thêm 15% nếu đạt từ 200tr đến nhỏ hơn 500tr, cộng thêm 20% nếu doanh số đạt trên 500tr
- Hàm trả về số ngày dc nghỉ theo quy tắc: Nếu số năm làm việc nhỏ hơn 3 năm thì số ngày dc nghỉ là ngày phép cơ bản, từ năm 3 trở đi thì cứ 1 năm làm việc sẽ dc thêm 1 ngày phép. Ví dụ: Ngày phép cơ bản là 12, 1 nhân viên đã làm 5 năm thì ngày phép là 12 + 3 = 15 ngày.
- Hàm kiểm tra nhân viên là xuất sắc năm nếu doanh số đạt 1.5 tỷ và không có tháng nào doanh số thấp hơn 100tr và số ngày phép đã nghỉ không âm


4. Từ class nhân viên:
- Khai báo thuộc tính gồm 1 danh
sách các product.
- Khai báo 1 enum định nghĩa các
case đánh giá KPI của nhân viên: Không hoàn thành, hoàn thành, hoàn thành tốt, xuất sắc.
- Viết 1 hàm trả về danh sách các product đã dc thanh toán trong 1 tháng (input là enum tháng cần tính)
- Viết 1 hàm trả về tổng số tiền hàng đã được thanh toán trong 1 tháng
- Viết 1 hàm trả về số lương trong tháng với điều kiện như cũ, %doanh số là % số tiền hàng của tháng đó
- Viết một hàm trả về tổng doanh số trong 1 năm (số tiền hàng đã dc thanh toán trong năm)
- Viết một hàm trả về KPI của nhân viên trong năm với điều kiện sau:
+ Không hoàn thành nếu doanh số dưới 500tr
+ Hoàn thành nếu doanh số từ 500tr đến < 1tỷ
+ Hoàn thành tốt nếu doanh số từ 1tỷ đến < 1.5tỷ
+ Xuất sắc nếu doanh số từ 1.5 tỷ
- Viết một hàm tính số lương cơ bản cho năm tới như sau:
+ Nếu không hoàn thành: Trừ đi 5% lương cơ bản hiện tại
+ Nếu hoàn thành: Giữ nguyên lương cơ bản
+ Nếu hoàn thành tốt: Tăng 5% lương cơ bản hiện tại
+ Nếu xuất sắc: Tăng 10% lương cơ bản hiện tại
*/


import 'package:view_and_layout_sample/product.dart';

enum KPIStatus { underStandard, achived, good, excelent }

class Employee {
  String firstName;
  String lastName;
  double basicSalary; //unit is milion
  List<double> sales = []; //unit is milion
  int yearOfWorking = 0;
  int basicLeaveDay = 0;
  int usedLeaveDay = 0;

  List<Product> products = [];

  Employee(
      {required this.firstName,
      required this.lastName,
      required this.basicSalary});

  String getFullName() {
    return '$firstName $lastName';
  }

  /*
  double getMonthlySalary(int month) {
    //month: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
    double saleNum = sales[month - 1];

    double sum = basicSalary + saleNum * _getRewardPercent(saleNum);

    return sum;
  }
  */

  double getMonthlySalary(Month month) {
    double saleNum = getSaleInMonth(month);

    double sum = basicSalary + saleNum * _getRewardPercent(saleNum);

    return sum;
  }

  int getAnualLeaveDay() {
    int extraLeaveDay = (yearOfWorking < 3) ? 0 : (yearOfWorking - 2);

    return basicLeaveDay + extraLeaveDay;
  }

  double _getRewardPercent(double saleNum) {
    if (saleNum < 50) {
      // 50 milions
      return 0;
    }

    if (saleNum < 200) {
      return 0.1;
    }

    if (saleNum < 500) {
      return 0.15;
    }

    return 0.2;
  }

  List<Product> getPaidProductInMonth(Month month) {
    List<Product> list = [];

    if (products.isEmpty) {
      return list;
    }

    for (Product product in products) {
      if (product.paymentMonth == month) {
          list.add(product);
      }
    }

    return list;
  }

  double getSaleInMonth(Month month) {
    List<Product> paidProducts = getPaidProductInMonth(month);

    double sum = 0;

    for (Product product in paidProducts) {
      sum += product.price;
    }

    return sum;
  }

  double getYearlySale() {
     double sum = 0;

    for (Product product in products) {
      sum += product.price;
    }

    return sum;
  }

  KPIStatus getKPIStatus() {
    double totalSale = getYearlySale();

    if (totalSale < 500) { //milions
      return KPIStatus.underStandard;
    }

    if (totalSale < 1000) {
      return KPIStatus.achived;
    }

    if (totalSale < 1500) {
      return KPIStatus.good;
    }

    return KPIStatus.excelent;
  }

  double nextYearBasicSalary() {
    KPIStatus kpiStatus = getKPIStatus();
    double salary = 0;

    switch (kpiStatus) {
      case KPIStatus.underStandard:
      salary = basicSalary - (basicSalary*0.05);
      break;
      case KPIStatus.achived:
      salary = basicSalary;
      break;
      case KPIStatus.good:
      salary = basicSalary + (basicSalary*0.05);
      break;
      case KPIStatus.excelent:
      salary = basicSalary + (basicSalary*0.1);
      break;
    }

    return salary;
  }
}
