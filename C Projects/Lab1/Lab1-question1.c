//import headers
#include <stdio.h>
#include <math.h>
#include <stdbool.h>
//main function declaration
int main()
{   
    bool key=true; //variable to check while loop continuation
    float myNum; //first number in equation 
    char myChar; //operator in the equation
    float myNum2; //second number in the equation 

    while (key==true){ //start of the while loop
        printf("Enter the equation:\n"); //prints prompt to ask for equation input
        scanf("%f %c %f", &myNum, &myChar, &myNum2); //gets equation input
        if (myChar=='+'){ //checks if operator is +
            float result=myNum+myNum2; //calculates result
            printf("%f%c%f=%f", myNum, myChar, myNum2, result);  //prints equation and result
        } else if (myChar=='-'){ //checks if operator is -
            float result=myNum-myNum2; //calculates result
            printf("%f%c%f=%f", myNum, myChar, myNum2, result); //prints equation and result
        } else if (myChar=='*'){ //checks if operator is *
            float result=myNum*myNum2; //calculates result
            printf("%f%c%f=%f", myNum, myChar, myNum2, result);  //prints equation and result
        } else if (myChar=='/'){ //checks if operator is /
            float result=myNum/myNum2; //calculates result
            printf("%f%c%f=%f", myNum, myChar, myNum2, result);  //prints equation and result
        } else{ //else keyword
            printf("Invalid input");  //prints equation and result
        } 
        printf("\nDo you wish to continue (y,n):\n"); //prints prompt to continue
        char ans; //ans character instance
        scanf(" %c", &ans); //gets answer
        if(ans=='y'){ //if answer is y continue
            key=true; //continue
        }
        else{ //else keyword
            key=false; //key turns false ending the while loop
        }
        
        
    }
    
    
    
        
    

    return 0; //returns 0
}

