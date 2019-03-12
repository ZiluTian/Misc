Test environment: Ubuntu 16.04 LTS, linux-headers-4.15.0-24-generic 

To build, enter make 

Create a pseudo file in /proc/hello_info which contains a hello world message and wall clock 
```
./test_dev.sh hello_info 
```

Create a virtual device, allocate a 4KB array in kernel, initialize the array in kernel, map it to user space, and print the array in user space 
```
./test_dev.sh virt_dev 
```
