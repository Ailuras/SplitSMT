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

(declare-sort var980 0)
(declare-sort var3178 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-fun createOrUpdateEphemeral/-937947153 (var980 String String Int) void)
(declare-const null-var980 var980)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const null-Int Int)
(declare-const var3632 var980) ; Statement: r1 := @this: org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient 
(assert (not (= var3632 null-var980)))
(declare-const var1275 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1275 null-String)))
(declare-const var3198 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3198 null-String)))
(declare-const var999 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var999 null-Bool)))
(declare-const var74 Int) ; Statement: r3 := @parameter3: java.lang.Integer 
(assert (not (= var74 null-Int)))
(assert true)
(define-const var3765 Int (lastIndexOf/-1292097097 var1275 47)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(47) 
 ; Statement: if i0 <= 0 goto (branch) 
(assert (<= var3765 0)) ; Cond: i0 <= 0 
 ; Statement: if z0 == 0 goto virtualinvoke r1.<org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient: void createOrUpdatePersistent(java.lang.String,java.lang.String,java.lang.Integer)>(r0, r2, r3) 
(assert (not (= (ite var999 1 0) 0))) ; Negate: Cond: z0 == 0  
(assert true)
;(assert (createOrUpdateEphemeral/-937947153 var3632 var1275 var3198 var74)) ; Statement: virtualinvoke r1.<org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient: void createOrUpdateEphemeral(java.lang.String,java.lang.String,java.lang.Integer)>(r0, r2, r3) 

(declare-const var3632!1 var980)
(declare-const var1275!1 String)
(declare-const var3198!1 String)
(declare-const var74!1 Int)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {lastIndexOf/-1292097097=([java.lang.String, int], int), createOrUpdateEphemeral/-937947153=([org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient, java.lang.String, java.lang.String, java.lang.Integer], void)}
; {var980=org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient, var3632=r1, var1275=r0, var3178=null_type, var3198=r2, var999=z0, var74=r3, var3765=i0}
; {org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient=var980, r1=var3632, r0=var1275, null_type=var3178, r2=var3198, z0=var999, r3=var74, i0=var3765}
;seq <java.lang.String: int lastIndexOf(int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	z0 := @parameter2: boolean;	r3 := @parameter3: java.lang.Integer;	i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(47);	if i0 <= 0 goto (branch);	if z0 == 0 goto virtualinvoke r1.<org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient: void createOrUpdatePersistent(java.lang.String,java.lang.String,java.lang.Integer)>(r0, r2, r3);	virtualinvoke r1.<org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient: void createOrUpdateEphemeral(java.lang.String,java.lang.String,java.lang.Integer)>(r0, r2, r3);	goto [?= return];	return
;block_num 4