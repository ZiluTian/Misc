#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/proc_fs.h>
#include <linux/seq_file.h>
#include <linux/sched/signal.h>
#include <linux/jiffies.h>

#define NAME "hello_info"

MODULE_LICENSE("GPL"); 
MODULE_DESCRIPTION("Pseudo file that prints out hello world, num of current processes, and wall clock time"); 
MODULE_AUTHOR("Zilu Tian"); 

static int helloinfo_proc_show(struct seq_file * m, void *v){
  long unsigned int begin; 
  long unsigned int end; 
  long unsigned int total_time; 

  begin = jiffies; 
  seq_printf(m, "[Jiffies start time: %lu] \n", begin); 
  seq_printf(m, "Hello world! \n"); 

  struct task_struct * task_list; 
  long unsigned int total_proc = 0; 
  for_each_process(task_list) {
    // verify against ps -aux for correctness  
    // seq_printf(m, "%d %s\n", task_list->pid, task_list->comm); 
    ++total_proc; 
  }
  seq_printf(m, "Total process count is %lu \n", total_proc);
  
  end = jiffies; 
  total_time = end - begin; 
  seq_printf(m, "[Jiffies end time: %lu]\n[Wall clock time: %lu]\n", end, total_time);  

 
  return 0; 
}

static int helloinfo_proc_open(struct inode * inode, struct file * file) {
  return single_open(file, helloinfo_proc_show, NULL); 
}

static const struct file_operations fops={
  .open = helloinfo_proc_open,
  .read = seq_read,
  .llseek = seq_lseek,
  .release = single_release,
};

static int __init proc_init(void){
  proc_create(NAME, 0, NULL, &fops); 
  return 0; 
}

static void __exit proc_exit(void){

  remove_proc_entry(NAME, NULL); 
}

// fs_initial(proc_init); 
module_init(proc_init); 
module_exit(proc_exit); 