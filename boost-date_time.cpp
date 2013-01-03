#include <boost/date_time/gregorian/gregorian.hpp>
#include <iostream>

int main() 
{
  
  using namespace boost::gregorian;
  using namespace std;
  string s;
  cout << "Enter birth day YYYY-MM-DD (eg: 2002-02-01): ";
  cin >> s;
  
  try {
    date birthday(from_simple_string(s));
    date today = day_clock::local_day();
    days days_alive = today - birthday;
    days one_day(1);

    cout << birthday << endl;
    cout << today << endl;
    cout << one_day.days() << endl;

    if (days_alive == one_day) {
      cout << "Born yesterday, very funny" << endl;
    }
    else if (days_alive < days(0)) {
      cout << "Not born yet, hmm: " << days_alive.days() 
                << " days" <<endl;
    }
    else {
      cout << "Days alive: " << days_alive.days() << endl;
    }

  }
  catch(...) {
    cout << "Bad date entered: " << s << endl;
  }
  return 0;
}
