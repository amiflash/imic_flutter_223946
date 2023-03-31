/*
2. Từ class học sinh:
- Viết 1 hàm trả về xếp hạng học lực
(kiểu enum trên) với điều kiện như sau: + Yếu nếu điểm tổng kết < 5
+ Trung bình nếu điểm tổng kết từ 5 đến < 6.5 và các môn đều trung bình
+ Khá nếu điểm tổng kết từ 6.5
đến < 8 và các môn đều khá
+ Giỏi nếu điểm tổng kết từ 8 và
các môn đều giỏi
- Viết một hàm kiểm tra nếu cần thi lại ((ouput là bool), với điều kiện có ít nhất 1 môn học là yếu
- Viết một hàm trả về danh sách các môn cần thi lại
- Viết một hàm trả về số vở là phần thưởng với điều kiện như sau:
+ Nếu khá: Số vở nhận dc là 10, + Nếu giỏi: Số vở nhận dc là 15
cuốn*/

import 'package:view_and_layout_sample/subject.dart';

class Student {
  String studentName;

  List<Subject> subjects = [];

  Student({required this.studentName});

  void initSubjects() {
    Subject math = Subject(subjectName: 'Math');
    math.firstSemesterTestMark15List = [5, 6, 6.5, 8];
    math.secondSemesterTestMark15List = [6, 5.5];
    math.secondSemesterTestMark15List = [7, 5.5, 6.5, 7.5];
    math.secondSemesterTestMark45List = [7, 6];
    math.firstFinalScore = 7;
    math.secondFinalScore = 8.5;

    Subject physic = Subject(subjectName: 'Physic');
    physic.firstSemesterTestMark15List = [7, 6.5, 8, 8];
    physic.secondSemesterTestMark15List = [7, 7.5];
    physic.secondSemesterTestMark15List = [6, 7.5, 6.5, 8];
    physic.secondSemesterTestMark45List = [7, 8];
    physic.firstFinalScore = 8;
    physic.secondFinalScore = 8.5;

    Subject history = Subject(subjectName: 'History');
    history.firstSemesterTestMark15List = [4, 6.5, 7.5, 7];
    history.secondSemesterTestMark15List = [6, 7.5];
    history.secondSemesterTestMark15List = [7, 7.5, 8.5, 7];
    history.secondSemesterTestMark45List = [7.5, 8];
    history.firstFinalScore = 8;
    history.secondFinalScore = 7.5;

    subjects = [math, physic, history];
  }

  double getFirstFinalScore() {
    double sum = 0;

    if (subjects.isEmpty) {
      return sum;
    }

    for (Subject subject in subjects) {
      sum += subject.getFirstSemesterScore();
    }

    return sum / subjects.length;
  }

  double getSecondFinalScore() {
    double sum = 0;

    if (subjects.isEmpty) {
      return sum;
    }

    for (Subject subject in subjects) {
      sum += subject.getSecondSemesterScore();
    }

    return sum / subjects.length;
  }

  double getFinalScore() {
    double sum = 0;

    if (subjects.isEmpty) {
      return sum;
    }

    for (Subject subject in subjects) {
      sum += subject.getFinalScore();
    }

    return sum / subjects.length;
  }

  LearningAbility getLearningAbility() {
    double finalScore = getFinalScore();
    LearningAbility allSubjectAbility = _getAllSubjectAbility();

    if (finalScore < 5) {
      return LearningAbility.weak;
    }

    if (finalScore < 6.5) {
      return (allSubjectAbility == LearningAbility.weak)
          ? LearningAbility.weak
          : LearningAbility.average;
    }

    if (finalScore < 8) {
      return (allSubjectAbility == LearningAbility.average)
          ? LearningAbility.average
          : LearningAbility.good;
    }

    return (allSubjectAbility == LearningAbility.good)
        ? LearningAbility.good
        : LearningAbility.excellent;
  }

  bool needRedoExam() {
    for (Subject subject in subjects) {
      if (subject.needRedoExam()) {
        return true;
      }
    }

    return false;

    /*
      List<Subject> redoExamSubjects = getRedoExamSubjects();

      return !list.isEmpty;
    */
  }

  List<Subject> getRedoExamSubjects() {
    List<Subject> list = [];

    for (Subject subject in subjects) {
        if (subject.needRedoExam()) {
          list.add(subject);
        }
    }

    return list;
  }

  int getRewardNotebookNum() {
      LearningAbility ability = getLearningAbility();

      if (ability == LearningAbility.good) {
        return 10;
      }

      if (ability == LearningAbility.excellent) {
        return 15;
      }

      return 0;
  }

  LearningAbility _getAllSubjectAbility() {
    for (Subject subject in subjects) {
      LearningAbility ability = subject.getLearningAbility();

      switch (ability) {
        case LearningAbility.weak:
          return LearningAbility.weak;
        case LearningAbility.average:
          return LearningAbility.average;
        case LearningAbility.good:
          return LearningAbility.good;
        case LearningAbility.excellent:
          return LearningAbility.excellent;
      }
    }

    return LearningAbility.excellent;
  }
}
