//
//  appletrace.m
//  appletrace
//
//  Created by everettjf on 2017/9/12.
//  Copyright © 2017年 everettjf. All rights reserved.
//


#import "appletrace.h"
#include <map>
#include <vector>
#include <string>
#include <pthread.h>
#include <mach/mach_time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

namespace appletrace {
    class Logger{
    private:
//        int block_size = 64 * 1024 * 1024;  // 64MB
        int block_size = 16 * 1024 * 1024;  // 16MB
//        int block_size = 1 * 1024 * 1024;  // 1MB
//        int block_size = 1 * 1024;  // 1KB
        
        int fd_ = 0;
        char * file_start_ = NULL;
        char * file_cur_ = NULL;
        size_t cur_size_ = 0;
    public:
        Logger(){}
        ~Logger(){}
        
        bool Open(const char * log_path){
            Close();
            
            remove(log_path);
            fd_ = ::open(log_path, O_CREAT|O_RDWR,(mode_t)0600);
            if(fd_ == -1){
                NSLog(@"open file failed");
                return false;
            }
            off_t cur_off = ::lseek(fd_, block_size - 1, SEEK_SET);
            ssize_t wrote_bytes = ::write(fd_,"",1);
            if(wrote_bytes != 1){
                NSLog(@"wrote error");
                Close();
                return false;
            }
            ::lseek(fd_, 0, SEEK_SET);
            
            file_start_ = (char*)::mmap(NULL,block_size,PROT_READ|PROT_WRITE,MAP_SHARED,fd_,0);
            if(file_start_ == MAP_FAILED){
                NSLog(@"map failed");
                Close();
                return false;
            }
            file_cur_ = file_start_;
            return true;
        }
        void Close(){
            if(file_start_){
                ::munmap(file_start_, block_size);
            }
            if(fd_){
                ::close(fd_);
            }
            fd_ = 0;
            file_start_ = NULL;
            file_cur_ = NULL;
            cur_size_ = 0;
        }
        bool AddLine(const char * line){
            if(!file_cur_)
                return false;
            
            size_t len = strlen(line);
            if(cur_size_ + len + 1> block_size){
                NSLog(@"file full");
                return false;
            }
            
            memcpy(file_cur_, line, len);
            file_cur_ += len;
            memcpy(file_cur_, (const char *)"\n",1);
            file_cur_ += 1;
            
            cur_size_ += len + 1;
            return true;
        }
    };
    
    
    class LoggerManager{
    private:
        static int file_counter;
        Logger log_;
    public:
        std::string GetFilePath(){
            NSString * tmp_dir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
            tmp_dir = [tmp_dir stringByAppendingPathComponent:@"appletracedata"];
            
            NSString * log_name;
            if(file_counter == 0){
                [[NSFileManager defaultManager] removeItemAtPath:tmp_dir error:nil];
                [[NSFileManager defaultManager] createDirectoryAtPath:tmp_dir withIntermediateDirectories:YES attributes:nil error:nil];
                
                log_name = @"trace.appletrace";
            }else{
                log_name = [NSString stringWithFormat:@"trace_%@.appletrace",@(file_counter)];
            }
            NSString * log_path = [tmp_dir stringByAppendingPathComponent:log_name];
            NSLog(@"log path = %@",log_path);
            return std::string(log_path.UTF8String);
        }
        bool Open(){
            std::string path = GetFilePath();
            if(!log_.Open(path.c_str())){
                return false;
            }
            ++file_counter;
            return true;
        }
        void AddLine(const char *line){
            if(log_.AddLine(line))
                return;
            
            NSLog(@"will map a new file");
            // map a new file
            if(!Open())
                return;
            
            if(!log_.AddLine(line)){
                // error
                NSLog(@"still error add line");
            }
        }
    };
    int LoggerManager::file_counter = 0;
    
    class Trace{
    private:
        LoggerManager log_;
        dispatch_queue_t queue_;
        uint64_t begin_;
        mach_timebase_info_data_t timeinfo_;
    public:
        bool Open(){
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                log_.Open();
                
                queue_ = dispatch_queue_create("appletrace.queue", DISPATCH_QUEUE_SERIAL);
                mach_timebase_info(&timeinfo_);
                begin_ = mach_absolute_time() * timeinfo_.numer / timeinfo_.denom;
                
            });
            return true;
        }
        
        void WriteSection(const char *name,const char *ph){
            pthread_t thread = pthread_self();
            __uint64_t thread_id=0;
            pthread_threadid_np(thread,&thread_id);
            uint64_t time = mach_absolute_time() * timeinfo_.numer / timeinfo_.denom;
            uint64_t elapsed = time - begin_;
            
            NSString *str = [NSString stringWithFormat:@"{\"name\":\"%s\",\"cat\":\"catname\",\"ph\":\"%s\",\"pid\":666,\"tid\":%llu,\"ts\":%llu}",
                              name,ph,thread_id,elapsed
                              ];
            dispatch_async(queue_, ^{
                log_.AddLine(str.UTF8String);
            });
        }
    };
    
    class TraceManager{
    private:
        Trace t_;
    public:
        static TraceManager & Instance(){
            static TraceManager o;
            return o;
        }
        
        TraceManager(){
            if(!t_.Open()){
                NSLog(@"error open trace file");
            }
        }
        
        void BeginSection(const char* name){
            t_.WriteSection(name, "B");
        }

        void EndSection(const char* name){
            t_.WriteSection(name, "E");
        }
    };
}

void APTBeginSection(const char* name){
    appletrace::TraceManager::Instance().BeginSection(name);
}

void APTEndSection(const char* name){
    appletrace::TraceManager::Instance().EndSection(name);
}

