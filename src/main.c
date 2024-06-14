#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int solve_quadratic(float a, float b, float c);

int solve_quadratic(float a, float b, float c) {
    float discriminant = b * b - 4 * a * c;
    float x1, x2;

    if (discriminant > 0) {
        x1 = (-b + sqrt(discriminant)) / (2 * a);
        x2 = (-b - sqrt(discriminant)) / (2 * a);
        printf("\nx1 = %f \n", x1);
        printf("\nx2 = %f \n", x2);
        return 0;
    } else if (discriminant == 0) {
        x1 = x2 = -b / (2 * a);
        printf("\nx1 = x2 = %f \n", x1);
        return 1;
    } else {  
        printf("\nYour discriminant < 0. Equation has no solutions! \n");
        return -1;
    }
}

int main(int argc, char* argv[])
{	
	float a;
	float b;
	float c;	
		if(argc == 1){
		printf("\nPlease, enter value of vairables for your function ax^2+bx+c=0! \n");
		
		printf("\nPlease, enter a:");
		scanf("%f",&a);
		
		printf("\nPlease, enter b:");
		scanf("%f",&b);
		
		printf("\nPlease, enter c:");
		scanf("%f",&c);
		return solve_quadratic(a,b,c);
		
	}
		else if(argc == 2){
		printf("\nPlease, enter value of vairables for your function ax^2+bx+c=0!\n");
		
		printf("eneter value for b:");
		scanf("%f",&b);
		
		printf("eneter value for c:");
		scanf("%f",&c);
		return solve_quadratic(strtof(argv[1], NULL),b,c);
	}
		else if(argc == 3){
		printf("\nPlease, enter value of vairables for your function ax^2+bx+c=0!\n");
		printf("eneter value for c:");
		scanf("%f",&c);
		return solve_quadratic(strtof(argv[1], NULL),strtof(argv[2], NULL),c);
	}
		else if(argc == 4){
		a = strtof(argv[1], NULL);
		b = strtof(argv[2], NULL);
		c = strtof(argv[3], NULL);
		return solve_quadratic(a,b,c);		
	}
	    return 0;
}	
