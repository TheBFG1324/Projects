
//includes header
#include<stdio.h>

int main(){ //main function declaration
    printf("Enter the size of the array being inputed:\n "); //prints statement
    int size; //vreates variable 
    scanf("%d", &size); //sets value to variable
    int array[size]; //makes an array of given size
    for(int i=0; i<size;i++){ //starts a far loop to loop through array
        printf("Enter integer for the %d index: ", i); //prints statement
        int num; //creates variable
        scanf(" %d", &num); //gets variable
        array[i]=num; //sets array value to variable
    }
    int unique[size]; //starts a unique array with equal size
    for(int i=0; i<size;i++){ //sets all values in array to 0
        unique[i]='\0'; //sets all values in array to 0
    }
    
    
    
    for(int y=0; y<size; y++){ //starts for loop to go through array
        int num=array[y]; //gets number
        int counter=0; //starts counter
        for(int z=0; z<size; z++){ //starts for loop
            if(num==unique[z]){ //if number is equal to value in the unique array 
                counter++; //add one to the counter
            }
        }
        if(counter==0){ //if the number isnt in the unique array
            unique[y]=num; //puts it in the unique array
        }    
    }
    for(int i=0; i<size;i++){ //starts a for loop
        int num =unique[i]; //gets num at array
        int counter=0; //starts counter
        for(int x=0; x<size; x++){ //starts for loop
            if(num==array[x]){ //if number in unique equals a value in array
                counter++; //adds to counter
            }
        }
        if(counter>1){ //if there was more than one value that was the same as the unique array value
            printf("The number %d appears %d times.\n", num, counter); //prints the number of time it appears
        }
        
    }
    return 0;//returns 0
}