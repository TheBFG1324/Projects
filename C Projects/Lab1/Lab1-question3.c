#include <stdio.h>

int main() //main function delaration
{
    printf("enter the number to check all prime numbers in the limit set\n"); //statment to get the upper limit of the numbers needed to check
    int num; //number limit instance
    scanf("%d", &num); //gets the number limit
    
    
    
    for(int i=2; i<=num; i++){ //starts the for loop to get every number up to and equal to the limit
        int flag=0; //checks if number can be divded by number 
        for(int j=2; j<i; j++){ //for loop decleration
            if (i%j==0){ //if number can be divided with no remiander
                flag=1; //change flag to 1
                break; //end for loop
                
            }
        }
    if(flag==0){ //checks to see if a number that was divisible was found
        printf(" %d", i);//prints number 
    }
    }

    return 0; //returns 0
}
