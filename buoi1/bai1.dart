

import 'dart:io';

bool checkNhuan(int n) {
  if (n % 4 == 0) return true;
  return false;
}
int dem(int n){
  int dem = 0;
  while(n>0){
    n=n~/10;
    dem++;
  }
  return dem;
}
void printPsacal(int numRows){
  List<List<int>> arrPascal = [];
  for(int i=0 ; i<numRows ; i++){
    List<int> arr = [];
    for(int j = 0 ; j <= i ; j ++){
      if(j==0||j==i)
        arr.add(1);
      else 
        arr.add(arrPascal[i-1][j]+arrPascal[i-1][j-1]);
    }
    arrPascal.add(arr);
  }
  for(int i = 0 ; i < numRows ; i++){
    int spaces = numRows - i - 1;
    for(int j = 0 ; j <spaces ; j++)
      stdout.write(" ");
    for(int j = 0 ; j <=i; j++){
      stdout.write('${arrPascal[i][j]} ');
    }
    stdout.write('\n');
  }
}
String astrologicalSignNames(int day, String month){
  var monthToDayArr = {'jan' : [20, ['Capricorn','Aquarius']],
  'feb' : [19,['Aquarius','Pisces']] ,
  'mar' : [20, ['Pisces','Aries']],
  'apr': [20, ['Aries','Taurus']],
  'may' : [20, ['Taurus','Gemini']],
  'jun': [21,['Gemini','Cancer']],
  'jul': [22,['Cancer','Leo']],
  'agu' : [22,['Leo','Virgo']],
  'sep': [21,['Virgo','Libra']],
  'oct':[22,['Libra','Scorpio']],
  'nov':[22,['Scoprio','Sagittarius']],
  'dec':[21,['Sagittarius','Capricorn']]
  };
  List<dynamic> keyMonth = monthToDayArr[month]!;
  List<String> astrologicalNames = keyMonth[1];
  if(day <= keyMonth[0]) return astrologicalNames[0];
  else return astrologicalNames[1];
}
bool isPrime(int number) {
  if (number < 2) {
    return false;
  }
  for (int i = 2; i <= number / 2; i++) {
    if (number % i == 0) {
      return false;
    }
  }
  return true;
}
void getList(){
  List<int> generateList = List.generate(100, (index) => index).where((element) => element < 1000).toList();
  generateList.forEach(print);
  Set<int> setB = generateList.toSet();
  setB.forEach(print);
  List<int> listC = setB.where((number) => isPrime(number)).toList();
  listC.forEach(print);

}

void main() {
  // print(astrologicalSignNames(10, 'feb'));
  getList();
}
