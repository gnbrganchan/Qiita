#include <bits/stdc++.h>
#define rep(i,cc,n) for(int i=cc;i<=n;++i)
#define drep(i,cc,n) for(int i=cc;i>=n;--i)
#define sz(s) (int)(s.size())
#define vecprint(v) rep(i,0,v.size()-1)cout << v[i] << " ";cout << endl;
#define mod 1000000007

using namespace std;

int main(){

  int a,n,m;
  long long ans=0;
  priority_queue<int> q;

  //入力を受け取る
  cin >> n >> m;
  
  rep(i,0,n-1){
    cin >> a;
    q.push(a);
  }

  //チケットを一枚ずつ使う
  rep(i,0, m-1){
    //qから最大値を取り出し、値を半分にしてqに戻す
    a = q.top();
    q.pop();
    q.push(a/2);
  }

  //チケットを使い終わった後、qに残っている金額を合計する
  rep(i,0,n-1){
    a = q.top();
    q.pop();
    ans += a;
  }
  
  cout << ans << endl;
  return 0;
}
