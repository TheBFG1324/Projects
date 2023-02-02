//includes macros and headers
#include<stdio.h>
#include<math.h>
#include<stdbool.h>

int main(){ //main function declaration 
    bool key=true; //key used to keep the while loop going if wanted
    while(key){ //start of the while loop
        /* First half of this block of code is the exact same as the Lab1-question1.c file. 
            I just copied and pasted it. All of the comments for this part of the code
            can be found in that file. */
        char option;
        printf("Do you want to enter an equation, or do a special operation?(y for equation n for special operation q to quit): ");
        scanf(" %c", &option);
        if(option=='y'){
            float myNum;
            char myChar;
            float myNum2;
            printf("Enter the equation:\n");
            scanf("%f %c %f", &myNum, &myChar, &myNum2); 
            if (myChar=='+'){
                float result=myNum+myNum2;
                printf("%f%c%f=%f", myNum, myChar, myNum2, result);
            } else if (myChar=='-'){
                float result=myNum-myNum2;
                printf("%f%c%f=%f", myNum, myChar, myNum2, result);
            } else if (myChar=='*'){
                float result=myNum*myNum2;
                printf("%f%c%f=%f", myNum, myChar, myNum2, result);
            } else if (myChar=='/'){
                float result=myNum/myNum2;
                printf("%f%c%f=%f", myNum, myChar, myNum2, result);
            } else{
                printf("Invalid input");
            } 
            printf("\nDo you wish to continue (y,n):\n");
            char ans;
            scanf(" %c", &ans);
            if(ans=='y'){
                key=true;
            }
            else{
                key=false;
            }
        }
            
         else if(option=='n'){ //if they want to do special operations this block of code runs 
            char option2; //creates an option variable to see what math operation if wanted to be completed
            printf("Do you want to square root(r)\n Ceiling (c)\n Flooring(f)\n Power(p)\n (a+b)^2(s)\n"); //print statement
            scanf(" %c", &option2); //sets value to the option
            if(option2=='r'){ //if they want to square root this block runs
                float num; //creates variable
                printf("Enter number: "); //prints statement
                scanf(" %f", &num);
                printf("\nanswer: %f\n",sqrt(num) ); //prints statement
            }
            else if(option2=='c'){
                float num; //creates variable
                printf("Enter number: "); //prints statement
                scanf(" %f", &num); //recieves variables
                printf("\nanswer: %f\n",ceil(num)); //prints statement
            }
            else if(option2=='f'){
                float num; //creates variable
                printf("Enter number: "); //prints statement
                scanf(" %f", &num); //recieves variables
                printf("\nanswer: %f\n",floor(num)); //prints statement
            }
            else if(option2=='p'){
                float num; //creates variable
                float power; //creates variable
                printf("Enter number: "); //prints statement
                scanf(" %f", &num); //recieves variables
                printf("Enter power: "); //prints statement
                scanf(" %f", &power); //recieves variables
                printf("\nanswer: %f\n",pow(num, power)); //prints statement
                
            } else if(option2=='s'){
                char par; //creates variable
                int num1; //creates variable
                char ope; //creates variable
                int num2; //creates variable
                char par2;//creates variable
                char up; //creates variable
                int power; //creates variable
                printf("Enter equation: \n"); //prints statement
                scanf(" %c%d%c%d%c%c%d", &par, &num1, &ope, &num2, &par2, &up, &power); //recieves variables
                printf("\nAnswer: %f\n ", pow((num1+num2),power)); //prints statement
                
                
            } else{
                printf("Invlid character submission try again\n"); //prints statement
            }
        }
        else if (option=='q'){ //if they want to end the program this if statement runs
            key=false; //creates variable
        }
    }
    return 0; //returns 0
    

}