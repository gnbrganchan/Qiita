#include <bits/stdc++.h>
#define rep(i,cc,n) for(int i=cc;i<=n;++i)
 
using namespace std;

int main(){
 
  int n;
 
  cin >> n;
  
  long a[n+1],b[n],ans=0.0;
  
  //入力を受け取る
  rep(i,0,n)cin >> a[i]; 
  rep(i,0,n-1)cin >> b[i];
  
  rep(i,0,n-1){
    //勇者iが倒せる数が残っていないときは次の勇者へ
    if(b[i]==0)continue;

    //勇者iが倒せる数が残っているモンスターの数より少ないときは倒せるだけ倒す
    //都市iのモンスターを倒しきれないとき
    if(b[i] <= a[i]){
      ans += b[i];
      continue;
    }

    //勇者iが倒せる数が残っているモンスターの数より少ないときは倒せるだけ倒す
    //都市iのモンスターは倒せるが都市i+1のモンスターは倒しきれないとき
    if(b[i] <= a[i] + a[i+1]){
      ans += b[i];
      b[i] -= a[i];
      a[i+1] -= b[i];
      continue;
    }

    //勇者iが都市i, i+1のモンスターをすべて倒しきれるときはすべて倒す
    ans += a[i]+a[i+1];
    //a[i]も0にすべきだが、この変数はこの後使わないので省略
    a[i+1]=0;
  }
 
  cout << ans << endl;
 
  return 0;
 
}