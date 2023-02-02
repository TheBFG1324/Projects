//includes header and macros
#include<stdio.h>
#include<string.h>

int length_counter(char* ptr){ //creates a function that counts the length of a string
    int length=0; //creates a variable to keep track 
    while(*ptr!=NULL){ //starts a while loop of while the pointer derefernced value isn't null then it continues
        length++; //adds one to the length
        ptr++; //gets the next memory allocation of the array
    }
    return length; //returns length
}

int main(){ //main function declaration
    char string[100000]; //creates empty string
    printf("Enter the string you want to calculate the length of: \n"); //prints prompt for user to input value
    scanf("%s", string); //gets user input
    char* begining=&string[0]; //creates a pointer for the first value of the string 
    int length=length_counter(begining); //calls the function
    printf("The amount of characters is: %d", length); //prints length
    return 0; //returns 0
    
    
     
}