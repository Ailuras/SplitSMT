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

(declare-sort var329 0)
(declare-sort var705 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-fun createOrUpdatePersistent/-1197213291 (var329 String String) void)
(declare-const null-var329 var329)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var1355 var329) ; Statement: r1 := @this: org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient 
(assert (not (= var1355 null-var329)))
(declare-const var2196 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2196 null-String)))
(declare-const var1779 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1779 null-String)))
(declare-const var2357 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var2357 null-Bool)))
(assert true)
(define-const var3861 Int (lastIndexOf/-1292097097 var2196 47)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(47) 
 ; Statement: if i0 <= 0 goto (branch) 
(assert (<= var3861 0)) ; Cond: i0 <= 0 
 ; Statement: if z0 == 0 goto virtualinvoke r1.<org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient: void createOrUpdatePersistent(java.lang.String,java.lang.String)>(r0, r2) 
(assert (= (ite var2357 1 0) 0)) ; Cond: z0 == 0 
(assert true)
;(assert (createOrUpdatePersistent/-1197213291 var1355 var2196 var1779)) ; Statement: virtualinvoke r1.<org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient: void createOrUpdatePersistent(java.lang.String,java.lang.String)>(r0, r2) 

(declare-const var1355!1 var329)
(declare-const var2196!1 String)
(declare-const var1779!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {lastIndexOf/-1292097097=([java.lang.String, int], int), createOrUpdatePersistent/-1197213291=([org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient, java.lang.String, java.lang.String], void)}
; {var329=org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient, var1355=r1, var2196=r0, var705=null_type, var1779=r2, var2357=z0, var3861=i0}
; {org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient=var329, r1=var1355, r0=var2196, null_type=var705, r2=var1779, z0=var2357, i0=var3861}
;seq <java.lang.String: int lastIndexOf(int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	z0 := @parameter2: boolean;	i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(47);	if i0 <= 0 goto (branch);	if z0 == 0 goto virtualinvoke r1.<org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient: void createOrUpdatePersistent(java.lang.String,java.lang.String)>(r0, r2);	virtualinvoke r1.<org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient: void createOrUpdatePersistent(java.lang.String,java.lang.String)>(r0, r2);	return
;block_num 4