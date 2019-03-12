#include <linux/uaccess.h>
#include <linux/errno.h>
#include <linux/fs.h>
#include <linux/module.h>
#include <linux/printk.h>
#include <uapi/linux/stat.h>
#include <linux/slab.h>
#include <linux/string.h>

#define NAME "virtual_character_device"
#define BUFFER_SIZE 4096

MODULE_LICENSE("GPL"); 
MODULE_DESCRIPTION("A virtual device which is allocated 4K array in kernel and print it in user space"); 
MODULE_AUTHOR("Zilu Tian"); 

static int major; 
char * kbuf; 

static ssize_t read(struct file * file, char __user *buf, size_t len, loff_t *off) {
  size_t ret=0; 

  if (*off == 0) {
    if (copy_to_user(buf, kbuf, BUFFER_SIZE)) {
      ret = -EFAULT; 
    } else {
      ret = BUFFER_SIZE; 
      *off = 1; 
    }
  }

  return ret; 
}

static const struct file_operations fops={
  .owner = THIS_MODULE, 
  .read = read, 
}; 

static int __init dev_init(void){
  major = register_chrdev(0, NAME, &fops); 

  kbuf = kzalloc(BUFFER_SIZE, GFP_KERNEL); 
  
  if (!kbuf){
    unregister_chrdev(major, NAME); 
    return -ENOMEM; 
  }

  strncpy(kbuf,"Hi there This is a short message written from kernel space to demonstrate the array is properly allocated and initialized. \n", BUFFER_SIZE); 

  return 0; 
}

static void __exit dev_exit(void){
  unregister_chrdev(major, NAME); 

  if (kbuf) 
    kfree(kbuf); 
}

module_init(dev_init); 
module_exit(dev_exit); 