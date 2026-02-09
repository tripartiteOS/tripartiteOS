>[!NOTE]
> This article is WIP (Work-In-Progress).
# tripartiteOS � Executable files format
###### Licensed as GNU GPLv2
This document describes the executabe files format in tripartiteOS

## tpOS16 executables
In the beginning of the file, there should be a DOS stub that outputs the following message:

`This 16-bit program requires tripartiteOS to run.`

The program then should exit to the command prompt.

After the stub, there should be the following header:

```c
    typedef struct
    {
        char[8] Magic = "tpOS16PR";
        char[8] Version = "v0.1.0";
        uint16_t EntryPoint;
        uint16_t CodeSize;
        uint16_t DataSize;
        uint16_t BSSSize;
    } tpOS16Header;
```

After the header, there should be the code section, followed by the data section. The BSS section is not stored in the file, but its size is specified in the header. When the executable is loaded, the BSS section should be zero-initialized.

## tpOS32 executables
The format of tpOS32 executables is similar to tpOS16 executables, but with the following differences:
- The magic string in the header is "tpOS32PR".
- The entry point, code size, data size, and BSS size are all 32-bit values instead of 16-bit values.
- The DOS stub outputs the following message:
`This 32-bit program requires tripartiteOS to run.`

## tpOS64 executables
The format of tpOS64 executables is similar to tpOS32 executables, but with the following differences:
- The magic string in the header is "tpOS64PR".
- The entry point, code size, data size, and BSS size are all 64-bit values instead of 32-bit values.
- The DOS stub outputs the following message:
`This 64-bit program requires tripartiteOS to run.`

> [!WARNING]
> The CPU architecture of the executable must be supported by the version of tripartiteOS you are using. The following table shows the supported CPU architectures for each version of tripartiteOS:
> | CPU Architecture | Supported app Architectures                  |
> |------------------|----------------------------------------------|
> | x86_32           | tpOS16, tpOS32, DOS16, DOS32                 |
> | x86_64           | tpOS16, tpOS32, tpOS64, DOS16, DOS32, DOS64* |
>
> <sup>*Despite what most people think, you can indeed write DOS applications that work in long mode.</sup>