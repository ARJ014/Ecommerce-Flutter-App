#include <bits/stdc++.h>
#include <iostream>
using namespace std;

// } Driver Code Ends
class Solution
{
public:
    int arrayOperations(int n, vector<int> &arr)
    {
        int c = 0;
        int max = 0;

        if (arr[n - 1] != 0)
        {
            arr[n] = 0;
            n++;
        }
        for (int i = 0; i < n; i++)
        {
            int x = arr[i];
            if (x != 0)
            {
                c++;
            }
            else
            {
                if (c != 0)
                {
                    max++;
                    c = 0;
                }
            }
        }
        if (max == 0)
            return 0 - 1;
        else
            return max;

        // code here
    }
};

//{ Driver Code Starts.

int main()
{
    int t;
    cin >> t;
    while (t--)
    {

        int n;
        cin >> n;

        vector<int> arr(n);
        for (int i = 0; i < n; i++)
        {
            cin >> arr[i];
        }

        Solution obj;
        int res = obj.arrayOperations(n, arr);

        cout << res << endl;
    }
}
