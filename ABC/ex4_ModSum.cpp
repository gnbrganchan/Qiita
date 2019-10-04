#include <bits/stdc++.h>
#define rep(i,cc,n) for(int i=cc;i<=n;++i)
#define drep(i,cc,n) for(int i=cc;i>=n;--i)
#define mod 1000000007

using namespace std;
class CompareFirst
{
public:
  bool operator()(pair<int,int> n1,pair<int,int> n2) {
    return n1.first>n2.first; //>:desc <:asc
  }
};

int main(){

  long long n,k,ans;

  //“ü—Í‚ğó‚¯æ‚é
  cin >> n;
  n--;

  //ans = 0.5 * n * (n+1) (1,...,n-1‚Ì˜aj 
  ans = n*(n+1)/2;
 
  cout << ans << endl;
  return 0;

}
