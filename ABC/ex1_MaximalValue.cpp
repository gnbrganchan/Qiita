#include <bits/stdc++.h>
#define rep(i,cc,n) for(int i=cc;i<=n;++i)
#define drep(i,cc,n) for(int i=cc;i>=n;--i)
#define sz(s) (int)(s.size())
#define mod 1000000007

using namespace std;

int main(){

  int n;

  //“ü—Í‚ğó‚¯æ‚é
  cin >> n;
  int b[n-1];

  rep(i,0,n-2)cin >> b[i];
  
  long long ans = b[0];
  rep(i,1,n-2){
  //b_i, b_{i+1}‚Ì‚¤‚¿¬‚³‚¢•û‚ªA_i‚ÌÅ‘å’l‚Æ‚È‚é
  ans += min(b[i-1],b[i]);
  }
  ans += b[n-2];
  
  cout << ans << endl;

  return 0;

}