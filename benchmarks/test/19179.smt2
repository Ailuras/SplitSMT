(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var615 0)
(declare-sort var996 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-fun createOrUpdatePersistent/337919187 (var615 String String Int) void)
(declare-const null-var615 var615)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const null-Int Int)
(declare-const var3590 var615) ; Statement: r1 := @this: org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient 
(assert (not (= var3590 null-var615)))
(declare-const var1516 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1516 null-String)))
(declare-const var1705 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1705 null-String)))
(declare-const var206 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var206 null-Bool)))
(declare-const var532 Int) ; Statement: r3 := @parameter3: java.lang.Integer 
(assert (not (= var532 null-Int)))
(assert true)
(define-const var2360 Int (lastIndexOf/-1292097097 var1516 47)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(47) 
 ; Statement: if i0 <= 0 goto (branch) 
(assert (<= var2360 0)) ; Cond: i0 <= 0 
 ; Statement: if z0 == 0 goto virtualinvoke r1.<org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient: void createOrUpdatePersistent(java.lang.String,java.lang.String,java.lang.Integer)>(r0, r2, r3) 
(assert (= (ite var206 1 0) 0)) ; Cond: z0 == 0 
(assert true)
;(assert (createOrUpdatePersistent/337919187 var3590 var1516 var1705 var532)) ; Statement: virtualinvoke r1.<org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient: void createOrUpdatePersistent(java.lang.String,java.lang.String,java.lang.Integer)>(r0, r2, r3) 

(declare-const var3590!1 var615)
(declare-const var1516!1 String)
(declare-const var1705!1 String)
(declare-const var532!1 Int)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {lastIndexOf/-1292097097=([java.lang.String, int], int), createOrUpdatePersistent/337919187=([org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient, java.lang.String, java.lang.String, java.lang.Integer], void)}
; {var615=org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient, var3590=r1, var1516=r0, var996=null_type, var1705=r2, var206=z0, var532=r3, var2360=i0}
; {org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient=var615, r1=var3590, r0=var1516, null_type=var996, r2=var1705, z0=var206, r3=var532, i0=var2360}
;seq <java.lang.String: int lastIndexOf(int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	z0 := @parameter2: boolean;	r3 := @parameter3: java.lang.Integer;	i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(47);	if i0 <= 0 goto (branch);	if z0 == 0 goto virtualinvoke r1.<org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient: void createOrUpdatePersistent(java.lang.String,java.lang.String,java.lang.Integer)>(r0, r2, r3);	virtualinvoke r1.<org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient: void createOrUpdatePersistent(java.lang.String,java.lang.String,java.lang.Integer)>(r0, r2, r3);	return
;block_num 4