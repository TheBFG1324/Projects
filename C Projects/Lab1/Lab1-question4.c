//includes header and macros
#include <stdio.h>
#include <string.h>

int main() //main function declaration
{
    char hex[100]; //creates an empty string
    printf("Enter hex value:\n"); //prints prompt to enter hex value
    scanf("%s", hex); //gets hex value
    printf("Equivalent value is: "); //prints statement 
    int length=strlen(hex); //gets length of string
    for(int i=0; i<length; i++){ //starts a for loop to iterate through string
        switch(hex[i]){ //starts a switch that gets the hex character
            case '0': //checks case
            printf("0000"); //prints value
            break; //break keyword
            case '1':  //checks case
            printf("0001"); //checks case
            break;//break keyword
            case '2': //checks case
            printf("0010");//checks case
            break;//break keyword
            case '3': //checks case
            printf("0011");//checks case
            break;//break keyword
            case '4'://checks case
            printf("0100");//checks case
            break;//break keyword
            case '5'://checks case
            printf("0101");//checks case
            break;//break keyword
            case '6'://checks case
            printf("0110");//checks case
            break;//break keyword
            case '7'://checks case
            printf("0111");//checks case
            break;//break keyword
            case '8'://checks case
            printf("1000");//checks case
            break;//break keyword
            case '9'://checks case
            printf("1001");//checks case
            break;//break keyword
            case 'A'://checks case
            printf("1010");//checks case
            break;//break keyword
            case 'B'://checks case
            printf("1011");//checks case
            break;//break keyword
            case 'C'://checks case
            printf("1100");//checks case
            break;//break keyword
            case 'D'://checks case
            printf("1101");//checks case
            break;//break keyword
            case 'E'://checks case
            printf("1110");//checks case
            break;//break keyword
            case 'F'://checks case
            printf("1111");//checks case
            break;//break keyword
            default: //checks case
            printf("Invalid character input");//checks case
            break;//break keyword
        }
    }
    char binary[100000]; //creates a binary variable
    printf("Enter binary value:\n"); //prints statemetn
    scanf("%s", binary); //sets value tp binary variable

    int binary_length = strlen(binary); //gets length
    int hex_length = binary_length / 4; //breaks it up intro groups of 4
    if(binary_length % 4 != 0) //checks if it needs to add zero places
        hex_length++; //adds to the hex length 

    char hex1[hex_length]; //creates a hex to be outputted

    int i, j, k; //for loop variables
    for(i = 0, j = 0, k = 0; i < binary_length; i += 4, j++) //starts for loop in groups of 4
    {
        int sum = 0;
        for(int x = i; x < i + 4 && x < binary_length; x++) //starts for loop keeping track of the 4 varibles 
        {
            sum = (sum << 1) | (binary[x] - '0'); //binary or to left shift the sum by one 
        }
        if(sum < 10) //if statement 
            hex1[j] = sum + '0'; //changes value at hex string
        else
            hex1[j] = sum - 10 + 'A'; //changes value at the hex string location 
    }

    hex1[j] = '\0'; //changes value at the hex string location 
    printf("Hex value is: %s\n", hex1); //changes value at the hex string location 

    return 0; //returns 0
}
