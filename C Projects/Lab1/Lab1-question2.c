//adding the header
#include <stdio.h>

int main() //main function declaration
{
    float average= 173.0; //average height variable
    float tall=183.0; //tall height variable
    float input; //inputed height
    printf("Enter Height:\n"); //prompts user to input height
    scanf("%f", &input); //gets user height
    if (input<= average-10){ //if height is 10 less than the average 
        printf("You are in the small grouping"); //prints statement
        
    } else if (input>= 183){// if inout is taller than the tall limit 
        printf("You are in the tall grouping"); //prints statement
    } else{ //otherwise they are in the average category 
        printf("You are in the average grouping"); //prints statement
    }

    return 0;//returns 0
}
