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

(declare-sort var471 0)
(declare-sort var3515 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-fun createOrUpdateEphemeral/2136578993 (var471 String String) void)
(declare-const null-var471 var471)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var3679 var471) ; Statement: r1 := @this: org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient 
(assert (not (= var3679 null-var471)))
(declare-const var519 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var519 null-String)))
(declare-const var3154 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3154 null-String)))
(declare-const var648 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var648 null-Bool)))
(assert true)
(define-const var166 Int (lastIndexOf/-1292097097 var519 47)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(47) 
 ; Statement: if i0 <= 0 goto (branch) 
(assert (<= var166 0)) ; Cond: i0 <= 0 
 ; Statement: if z0 == 0 goto virtualinvoke r1.<org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient: void createOrUpdatePersistent(java.lang.String,java.lang.String)>(r0, r2) 
(assert (not (= (ite var648 1 0) 0))) ; Negate: Cond: z0 == 0  
(assert true)
;(assert (createOrUpdateEphemeral/2136578993 var3679 var519 var3154)) ; Statement: virtualinvoke r1.<org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient: void createOrUpdateEphemeral(java.lang.String,java.lang.String)>(r0, r2) 

(declare-const var3679!1 var471)
(declare-const var519!1 String)
(declare-const var3154!1 String)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {lastIndexOf/-1292097097=([java.lang.String, int], int), createOrUpdateEphemeral/2136578993=([org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient, java.lang.String, java.lang.String], void)}
; {var471=org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient, var3679=r1, var519=r0, var3515=null_type, var3154=r2, var648=z0, var166=i0}
; {org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient=var471, r1=var3679, r0=var519, null_type=var3515, r2=var3154, z0=var648, i0=var166}
;seq <java.lang.String: int lastIndexOf(int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	z0 := @parameter2: boolean;	i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(47);	if i0 <= 0 goto (branch);	if z0 == 0 goto virtualinvoke r1.<org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient: void createOrUpdatePersistent(java.lang.String,java.lang.String)>(r0, r2);	virtualinvoke r1.<org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient: void createOrUpdateEphemeral(java.lang.String,java.lang.String)>(r0, r2);	goto [?= return];	return
;block_num 4