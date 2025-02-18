from multiprocessing import Process as MPProcess, Pool as MPPool, Queue as mpQueue, Pipe as mpPipe, Manager
import os, time, random

class test_mp_class:
    def __init__(self,ta_id,pr_id) -> None:
        self.task_id = ta_id
        self.proc_id = pr_id
    
    @property
    def test_id(self):
        return ("this is " + str(self.proc_id + 2))

class test_mp:
    def __init__(self) -> None:
        start = time.time()
        # run_single_process(mpQ)
        test_mp_list = [1]
        self.run_process_pool(mpQ,test_mp_list)
        print(test_mp_list)
        end = time.time()
        

    def test_mp_datatrans_proc(self,task_id:int,mpQ,obj):
        proc_id = os.getpid()
        print('子进程: {} - 任务{}'.format(os.getpid(), task_id))
        test_obj = test_mp_class(task_id,proc_id)
        obj.append(task_id)
        print(obj)
        time.sleep(2)
        mpQ.put(test_obj)

    def run_single_process(self,mpQ):
        """
        手动开辟单个process的写法
        对比下面的pool的写法，所用的queue不是一个东西
        """
        # 
        print('run_single_proc进程: {}'.format(os.getpid()))
        process = [MPProcess(target=self.test_mp_datatrans_proc, args=(1,mpQ,)),
                MPProcess(target=self.test_mp_datatrans_proc, args=(2,mpQ,)), 
                MPProcess(target=self.test_mp_datatrans_proc, args=(3,mpQ,)), 
                MPProcess(target=self.test_mp_datatrans_proc, args=(4,mpQ,)), ]
        [p.start() for p in process]
        [p.join() for p in process]

    def run_process_pool(self,mpQ,test_obj):
        def test_inlinue_mp(i):
            print("this is "+i)
        """
        自动线程pool的用法，
        需要注意的是pool无法使用queue来实现消息传递，而需要使用Manager().Queue()
        """
        
        print('run_process_pool进程: {}'.format(os.getpid()))
        MPPoolQueue = Manager().Queue()
        
        mpPool = MPPool()
        for i in range(16):
            mpPool.apply_async(self.test_mp_datatrans_proc, args=(i,MPPoolQueue,test_obj))
            # mpPool.apply_async(test_inlinue_mp, args=(i,))
        print('等待所有子进程完成。')
        mpPool.close()# 关闭pool使其不接受新的线程
        mpPool.join()# 等所有的进程执行完毕
        
        test_dir = {}
        while not MPPoolQueue.empty():
            temp = MPPoolQueue.get()
            test_dir[temp.task_id] = temp.test_id
        
    


if __name__=='__main__':
    print('main进程: {}'.format(os.getpid()))
    mpQ = mpQueue()
    test_mp_obj = test_mp()
    
    

    
    
    test_dir = {}
    while not mpQ.empty():
        temp = mpQ.get()
        test_dir[temp.task_id] = temp.test_id
    
    # print(test_dir)

    
    



    
