#include <stdio.h>
int PrintReadyToInstallMsg(char *packageName)
{
    printf("Ready to install package " + *packageName);
    printf("Are you sure that you want to install the package? (Y/N)");
    char choice = getchar();
    if (choice == "Y" || choice == "y") return 1;
    return 0;
}