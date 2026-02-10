#include <stddef.h>
#include <stdint.h>
typedef struct 
{
    char Magic[8] = "tpOS16P";
    char Version[8];
    uint16_t EntryPoint;
    uint16_t CodeSize;
    uint16_t DataSize;
    uint16_t BSSSize;
} tpOS16PrgHeader;

typedef struct 
{
    char Magic[8] = "tpOS32P";
    char Version[8];
    uint32_t EntryPoint;
    uint32_t CodeSize;
    uint32_t DataSize;
    uint32_t BSSSize;
} tpOS32PrgHeader;

typedef struct 
{
    char Magic[8] = "tpOS64P";
    char Version[8];
    uint64_t EntryPoint;
    uint64_t CodeSize;
    uint64_t DataSize;
    uint64_t BSSSize;
} tpOS64PrgHeader;
