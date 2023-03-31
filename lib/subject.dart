/*
1. Hãy viết một class về môn học với những đặc tính như sau: + Tên môn học
+ Một mảng điểm kiểm tra 15p học kỳ 1
+ Một mảng điểm kiểm tra 1 tiết học kỳ 1
+ Một mảng điểm kiểm tra 15p học kỳ 2 
+ Một mảng điểm kiểm tra 1 tiết học kỳ 2 
+ Điểm thi học kỳ 1
+ Điểm thi học kỳ 2

+ Hãy viết các hàm sau trong class này:
- Hàm tính điểm tổng kết của từng học kỳ với quy tắc: (tổng điểm 15p + tổng điểm 1 tiết*2 + điểm thi học kỳ*3)/(số lượng điểm 15p + số lượng điểm 1 tiết*2 + 3 )
- Hàm tính điểm tổng kết với quy tắc: (Điểm tổng kết học kỳ 1 + Điểm tổng kết học 2*2)/3
- Hàm kiểm tra nếu cần thi lại môn học, với điều kiện điểm tổng kết < 5

- Viết 1 enum định nghĩa các case của học lực: yếu, trung bình, khá, giỏi
- Viết 1 hàm trả về học lực của môn học đó với output là kiểu enum trên
- Viết 1 hàm kiểm tra (ouput là bool) nếu cần thi lại môn đó, trong trường hợp học lực là yếu

*/

enum LearningAbility {
  weak,
  average,
  good,
  excellent
}


class Subject {
  String subjectName;
  List<double> firstSemesterTestMark15List = [];
  List<double> secondSemesterTestMark15List = [];

  List<double> firstSemesterTestMark45List = [];
  List<double> secondSemesterTestMark45List = [];

  double firstFinalScore = 0;
  double secondFinalScore = 0;

  Subject({required this.subjectName});

  double getFirstSemesterScore() {
    return _sumSemesterScore(firstSemesterTestMark15List, firstSemesterTestMark45List, firstFinalScore);
  }

  double getSecondSemesterScore() {
    return _sumSemesterScore(secondSemesterTestMark15List, secondSemesterTestMark45List, secondFinalScore);
  }

  double getFinalScore() {
    double firstScore = getFirstSemesterScore();
    double secondScore = getSecondSemesterScore();

    return (firstScore + secondScore*2)/3;
  }

  LearningAbility getLearningAbility() {
    double finalScore = getFinalScore();

    if (finalScore < 5) {
      return LearningAbility.weak;
    }

    if (finalScore < 6.5) {
      return LearningAbility.average;
    }

    if (finalScore < 8) {
      return LearningAbility.good;
    }

    return LearningAbility.excellent;
  }

  bool needRedoExam() {
    return (getLearningAbility() == LearningAbility.weak);
  }

  double _sumSemesterScore(List<double> mark15, List<double>mark45, double finalScore) {
      double sum15 = _sumScore(mark15);
      double sum45 = _sumScore(mark45);

      int totalCount = mark15.length + mark45.length*2 + 3; 

      double totalScore = (sum15 + sum45*2 + finalScore*3);

      double sum = totalScore/totalCount;

      return sum;
  }

  double _sumScore(List<double> marks) {
    double sum = 0;

    if (marks.isEmpty) {
      return sum;
    }

    for (int i = 0; i < marks.length; i++) {
      sum += marks[i];
    }

    return sum;    
  }
}