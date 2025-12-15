#include <stdio.h>
#include <string.h>

typedef struct
{
    char name;
    char number;
} person;

int main(void)
{
    person values[2];
    values[0].name = "Kai";
    values[0].number = "+1 134-104-1940";

    char n = gets("Number (0-9): ");
    for (int i = 0; i < sizeof(values); i++)
    {
        printf("Name: " + values[i].name);
        printf("Number: " + values[i].number);
    }

    return 0;
}